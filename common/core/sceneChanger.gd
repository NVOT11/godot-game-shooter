# SceneChanger.gd
extends Node

# シーン変更、常にMasterシーンがルートになる
func change_scene(current,scene_enum):
	var master_node = get_master_node(current)

	if not master_node:
		# 全シーンを削除して、Masterシーンをロードしてルートにする
		master_node = clear_and_load_master(current)
	else:
		# Masterシーン以下、全ノードを削除する
		clear_all_children(master_node)

	var path = scene_to_path(scene_enum)
	if path:
		var scene = load(path).instantiate()
		master_node.add_child(scene)
	else:
		print("Invalid scene enum: ", scene_enum)


# 親ノードを辿ってMasterノードを返す、見つからなければnullを返す
func get_master_node(node):
	var current = node
	while current.get_name() != Scenes.Master_Node_Name:
		current = current.get_parent()
		if current == null:
			return null
	return current


# エディタでのテストプレイで、Masterシーン以外から開始した場合に使う
# 全ノードを削除して、Masterシーンをロードし、ルートとする
func clear_and_load_master(current):
	var master_path = scene_to_path(Scenes.MASTER)
	if master_path:
		current.queue_free()
		var master_node =  load(master_path).instantiate()
		get_tree().get_root().add_child(master_node)
		return master_node
	else:
		print("No MasterScene found")
	return null


# 子ノードを全て削除する 	
func clear_all_children(node):
	for child in node.get_children():
		child.queue_free()


# シーンenumからパスを探して返す		
func scene_to_path(scene_enum):
	if Scenes.scene_paths.has(scene_enum):
		return Scenes.scene_paths[scene_enum]
	else:
		print("Invalid scene enum: ", scene_enum)
		return null
