class_name Main
extends Node


@export var HUD: HUD
@export var Spawner : Spawner
@export var Player : Player

@export var Switcher: Switcher
@export var VPad: Control
@export var KeyHelp: Label

@export var TitleButton: TouchScreenButton
@export var RetryButton: TouchScreenButton

var _left_time: float = GameData.TIME_LIMIT


func _ready():
	Switcher.toggled.connect(_on_toggled.bind())
	Switcher.forced(PlayerData.OnMobile)
	_on_toggled(PlayerData.OnMobile)

	TitleButton.pressed.connect(title.bind())
	RetryButton.pressed.connect(retry.bind())

	PlayerData.Initialize()
	Player.Initialize()	
	Spawner.Initialize()


func _process(delta):
	if PlayerData.Finished:
		return

	_left_time -= delta
	
	if _left_time <= 0:
		on_end()
		return

	# UIの更新
	HUD.set_time(int(_left_time))
	HUD.set_score(PlayerData.Get_Score())


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("quit"):
		title()
		return

	if Input.is_action_just_pressed("sub") && PlayerData.Finished:
		retry()
		return


func retry():
	SceneChanger.change_scene(self,Scenes.MAIN)


func title():
	SceneChanger.change_scene(self,Scenes.TITLE)


func on_end():
	PlayerData.Finished = true

	HUD.set_time(0)
	HUD.show_result(PlayerData.Get_Score())
	PlayerData.Set_Score(0)


func _on_toggled(_is_on):
	if _is_on:
		PlayerData.OnMobile = true
		KeyHelp.visible = false
		VPad.visible = true
	else:
		PlayerData.OnMobile = false
		KeyHelp.visible = true
		VPad.visible = false
	
