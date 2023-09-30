class_name Spawner
extends Node2D
# Spawner.gd

@export var enemy_tscn_list : Array[PackedScene]
@export var boss_tscn : PackedScene

@export var spawn_range_max : float = 250.0
@export var spawn_range_min : float = -250.0
@export var spawn_offset_min : float = 70.0

var last_spawn_position: float = 0.0  # 前回のスポーン位置を保存する変数


func Initialize():
	$AnimationPlayer.play("spawning")
	
	
# AnimationPlayerから呼ぶ
func spawn_enemies(id:int=0,num:int=1):
	if id < 0 or id >= enemy_tscn_list.size():
		print("invalid enemy id")
		return

	var enemies = []
	for i in range(num):
		enemies.append(spawn_enemy(id))

	enemies.sort_custom(func(a,b): return a.position.y < b.position.y)
	var z_index_count = 0
	for enemy in enemies:
		enemy.z_index = z_index_count
		z_index_count += 1
	

func spawn_enemy(id:int=0) -> Enemy:
	var spawned_enemy = enemy_tscn_list[id].instantiate() as Enemy
	self.add_child(spawned_enemy)
	
	var new_spawn_position = get_valid_spawn_position()
	spawned_enemy.position.y = new_spawn_position
	last_spawn_position = new_spawn_position  # スポーン位置を保存

	spawned_enemy.initialize()
	return spawned_enemy


func get_valid_spawn_position():
	var timeout = 10
	var new_position = 0.0
	while timeout > 0:
		timeout -= 1
		new_position = randf_range(spawn_range_min, spawn_range_max)
		if abs(new_position - last_spawn_position) >= spawn_offset_min:
			break	
	return new_position


func spawn_boss():
	if boss_tscn == null:
		print("boss_tscn is null")
		return
	var spawned_boss = boss_tscn.instantiate()
	self.add_child(spawned_boss)
	
	spawned_boss.position = Vector2(0, 0)

	spawned_boss.initialize()
