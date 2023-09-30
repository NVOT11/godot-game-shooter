class_name Switcher
extends Control

signal toggled(value : bool)

@export var button : TouchScreenButton
@export var Rect : TextureRect
@export var sprite_on : Texture
@export var sprite_off : Texture
@export var initial := false

var isOn := false


func _ready():
	button.pressed.connect(toggle.bind())
	isOn = initial	
	update_icon(isOn)


func forced(check:bool):
	isOn = check
	update_icon(isOn)


func toggle():
	isOn = !isOn
	toggled.emit(isOn)
	update_icon(isOn)


func update_icon(check : bool):
	if check:
		Rect.set_texture(sprite_on)
	else:
		Rect.set_texture(sprite_off)
