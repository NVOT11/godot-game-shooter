# Master.gd
# マスターシーンのスクリプト
extends Node

func _ready():
	# エディターかチェック
	var isEditor = OS.has_feature("editor")
	print("IsEditor: " + str(isEditor))

	# 自動的にタイトルシーンに遷移
	SceneChanger.change_scene(self,Scenes.TITLE)
