extends Area2D

#not_use anymore, i switch to path instead because 
#packedscene somehow having problem upon switching back and fouth on the same scene
@export var next_scene : String = "res://scene/scene_02.tscn"



## to next scene
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		SceneTransition.load_scene(next_scene)
