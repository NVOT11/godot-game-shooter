class_name Player
extends CharacterBody2D
# Player.gd

# Exports
@export var Joystick: VirtualJoystick
@export var FireButton: TouchScreenButton

@export var bullet_tscn: PackedScene
@export var move_speed = 800
@export var move_range = Vector2(1280, 720)

@export var sound_shot: AudioStream
@export var sound_damage: AudioStream

@export var shot_usage:int = 10
@export var recovery_time :float = 0.03
@export var recover_amount :int = 1

var direction := Vector2(0, 0)
var elapsed_time := 0.0
var bullet_root : Node


func Initialize():
	$AnimationPlayer.play("idle")
	bullet_root = Node2D.new()
	get_parent().add_child(bullet_root)


func _input(_event: InputEvent) -> void:		
	if Input.is_action_just_pressed("fire"):
		fire()

	if FireButton and FireButton.is_pressed():
		fire()


func _process(delta):
	elapsed_time += delta
	if elapsed_time > recovery_time:
			elapsed_time = 0
			PlayerData.Recover_Energy(recover_amount)

	if PlayerData.OnMobile and Joystick.is_pressed:
		direction = Joystick.output.normalized()
		return
	
	direction = Input.get_vector( "left", "right","up", "down")


func _physics_process(_delta):
	velocity = direction * move_speed	
	move_and_slide()
	
	# 移動範囲の制限
	if position.y < 0:
		position.y = 0
	elif position.y > move_range.y:
		position.y = move_range.y
	
	if position.x < 0:
		position.x = 0
	elif position.x > move_range.x:
		position.x = move_range.x


# 攻撃
func fire():
	if not PlayerData.Use_Energy(shot_usage):
		return

	$AnimationPlayer.play("fire")
	$AudioStreamPlayer2D.stream = sound_shot
	$AudioStreamPlayer2D.play()
		
	var spawned_bullet = bullet_tscn.instantiate() as Bullet
	bullet_root.add_child(spawned_bullet)
	spawned_bullet.position = self.position
	spawned_bullet.initialize()

	PlayerData.Use_Energy(1)


# 敵に当たった時
func apply_damage(damage):
	$AnimationPlayer.play("damage")
	$AudioStreamPlayer2D.stream = sound_damage
	$AudioStreamPlayer2D.play()

	PlayerData.Add_Score(-damage)


# 攻撃モーション後にAnimationPlayerから呼ばれる
func return_to_idle():
	$AnimationPlayer.play("idle")
