extends Area2D
#not_use anymore, i switch to path instead because 
#packedscene somehow having problem upon switching back and fouth on the same scene
@export var next_scene : String = "res://scene/scene_03.tscn"
var is_door = false




func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		is_door = true


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		is_door = true


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("ui_leftMouseClick") && is_door:
		SceneTransition.load_scene(next_scene)
