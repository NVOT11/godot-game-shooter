# title.gd
extends Node

@export var AButton : TouchScreenButton
@export var KeyHelp : Label

@export var Switcher : Switcher


func _ready():
	Switcher.toggled.connect(_on_toggled.bind())
	Switcher.forced(PlayerData.OnMobile)
	_on_toggled(PlayerData.OnMobile)

	AButton.pressed.connect(_ok.bind())


func _input(_event):
	if Input.is_action_just_pressed("fire"):
		_ok()


func _ok():
		SceneChanger.change_scene(self,Scenes.MAIN)


func _on_toggled(_is_on):
	if _is_on:
		PlayerData.OnMobile = true
		KeyHelp.visible = false
		AButton.visible = true
	else:
		PlayerData.OnMobile = false
		KeyHelp.visible = true
		AButton.visible = false
