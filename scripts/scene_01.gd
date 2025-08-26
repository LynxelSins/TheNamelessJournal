extends Control


@onready var LinChuck = $CanvasLayer
@onready var player = $CharacterBody2D
@export var lighttexture: Texture2D

func _on_lin_shuck_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("ui_leftMouseClick"):
		wait_for_destination()

func _process(delta: float) -> void:
	if !LinChuck.visible:
		player.setMoveable(true)
	else:
		if LinChuck.get_current_code() == "1234":
			LinChuck.code_correct()
	
func wait_for_destination():
	while not player.get_is_destination():
		await get_tree().process_frame
	player.setMoveable(false)
	LinChuck.set_visible(true)
	


func _on_light_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("ui_leftMouseClick"):
		while not player.get_is_destination():
			await  get_tree().process_frame
		$Scene/Background.texture = lighttexture
		$CharacterBody2D.modulate = Color("#ffffff")
