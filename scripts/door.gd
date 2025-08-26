extends Area2D


@export var next_scene : PackedScene



## to next scene
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		SceneTransition.load_scene(next_scene)
