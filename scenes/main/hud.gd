extends Control
class_name HUD

@export var LableTime: Label
@export var LabelScore: Label
@export var Result: Control
@export var LabelResult: Label
@export var EnergyBar: ProgressBar


func _ready():
	Result.visible = false
	set_time(0)
	set_score(0)


func _process(_delta):
	update_gauge()


func set_time(time):
	LableTime.text = "Time: " + str(time)


func set_score(score):
	LabelScore.text = "Score: "+ str(score)


func show_result(score):
	Result.visible = true
	LabelResult.text = "Result: " + str(score)


func update_gauge():
	EnergyBar.value = PlayerData.Energy
