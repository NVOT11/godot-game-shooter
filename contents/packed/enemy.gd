# Enemy.gd
extends Node2D
class_name Enemy

@export var health = 10
@export var attack_power = 30
@export var score = 100
@export var move_direction = Vector2(-1, 0) 
@export var move_speed = 400 
@export var out_range:int = -1200
@export var collision_shape2d: CollisionShape2D

@export var sound_damage: AudioStream

var _killed: bool = true


func initialize():
	$Area2D.body_entered.connect(detect_body.bind())
	$Area2D.area_entered.connect(detect_area.bind())	
	$AnimationPlayer.play("idle")
	_killed = false


func _process(delta):
	if _killed:
		return
	position += move_direction * move_speed * delta
	is_dead()


func detect_area(_area):
	pass


func detect_body(_body):
	var current = _body
	while current != null:
		if current.has_method("apply_damage"):
			current.apply_damage(attack_power)
		current = current.get_parent()
		continue


func apply_damage(damage):
	if _killed:
		return
	health -= damage
	$AnimationPlayer.play("damage")
	$AudioStreamPlayer2D.stream = sound_damage
	$AudioStreamPlayer2D.play()
	is_dead()


func is_dead():
	if health <= 0:
		_killed = true
		collision_shape2d.set_deferred("disabled", true)
		PlayerData.Add_Score(score)
		$AnimationPlayer.play("die")
	if position.x <= out_range:
		_killed = true
		collision_shape2d.set_deferred("disabled", true)
		self.queue_free()


# 攻撃モーション後にAnimationPlayerから呼ばれる
func return_to_idle():
	$AnimationPlayer.play("idle")


# AnimationPlayerで死亡モーション後に呼ばれる
func on_dead(_body):
	self.queue_free()
	pass
