# Bullet.gd
class_name Bullet
extends Node2D

@export var attack_power:int = 10
@export var move_direction:Vector2 = Vector2(1, 0) 
@export var move_speed:int = 400
@export var duration:float = 1.7

# 時間で消滅
var elapsed_time := 0.0


func initialize():
	$Area2D.body_entered.connect(detect_body.bind())
	$Area2D.area_entered.connect(detect_area.bind())
	$AnimationPlayer.play("idle")


func _process(delta):
	position += move_direction * move_speed * delta
	elapsed_time += delta
	if elapsed_time > duration:
		self.queue_free()


func detect_body(_body):
	pass


func detect_area(area):
	var current = area.get_parent()
	while current != null:
		if current.has_method("apply_damage"):
			current.apply_damage(attack_power)
			self.queue_free()
			return
		current = current.get_parent()
