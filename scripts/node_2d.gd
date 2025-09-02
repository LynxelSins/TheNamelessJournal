extends Node2D

func _ready() -> void:
	$AnimationPlayer.play("start_up")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	SceneTransition.load_scene("res://scene/gameover.tscn")
