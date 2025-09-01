extends CanvasLayer


func _ready() -> void:
	if !GameStateManager.is_tutorial_done:
		$AnimationPlayer.play("start_up")
	else:
		visible = false
