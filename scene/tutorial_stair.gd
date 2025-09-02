extends CanvasLayer


func _ready() -> void:
	if !GameStateManager.is_tutorial_stair_done:
		$AnimationPlayer.play("start_up")
	else:
		visible = false


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	GameStateManager.is_tutorial_stair_done = true
