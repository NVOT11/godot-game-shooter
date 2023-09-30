# Scenes.gd
extends Node

# Masterシーンの最上位Nodeの名前
const Master_Node_Name: String = "master"

enum {
	MASTER,	 # ゲーム開始時にロードされ、常に最上位にある
	TITLE,
	MAIN,
}

const scene_paths = {
	MASTER: "res://scenes//master/master.tscn",
	TITLE: "res://scenes//title/title.tscn",
	MAIN: "res://scenes//main/main.tscn"
}
