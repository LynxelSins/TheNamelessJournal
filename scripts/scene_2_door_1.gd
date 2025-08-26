extends Area2D

@export var next_scene : PackedScene
var is_door = false


##check if player is at door then click the door in order to change scene

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("ui_leftMouseClick") && is_door:
		SceneTransition.load_scene(next_scene)


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		is_door = true


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		is_door = false
