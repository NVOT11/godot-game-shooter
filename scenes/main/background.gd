class_name Background
extends Node2D
# Background.dg
# 背景スプライトをスクロールさせる

# 背景のスクロール速度
@export var speed := 20.0

# 背景のSpriteノードを参照
@export var bg1: Sprite2D
@export var bg2: Sprite2D 


func _ready():
	# 初期位置を設定
	bg1.position = Vector2(0, 0)
	bg2.position = Vector2(bg1.texture.get_width(), 0)


func _process(delta):
	# 背景を左にスクロール
	bg1.position.x -= speed * delta
	bg2.position.x -= speed * delta

	# 背景が画面外に出たら、右側に戻す
	if bg1.position.x <= -bg1.texture.get_width():
		bg1.position.x = bg2.position.x + bg2.texture.get_width()

	if bg2.position.x <= -bg2.texture.get_width():
		bg2.position.x = bg1.position.x + bg1.texture.get_width()
