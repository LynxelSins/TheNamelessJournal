extends Control


@onready var player = $CharacterBody2D
@onready var locker = $Locker_puzzle
var flicker_timer := 0.0
var flicker_delay := 0.08
@export var next_scene : String = "res://scene/scene_04.tscn"
var is_door = false


func _ready() -> void:
	player.is_levelable = false
	if GameStateManager.is_Storage_light:
		$CanvasModulate.visible = false
	else:
		$CanvasModulate.visible = true
	if GameStateManager.is_Storage_locker_opened:
		locker.code_correct()
		if GameStateManager.is_Storage_item_Key_taken:
			locker.noKey()
		if GameStateManager.is_Storage_item_note_taken:
			locker.noNote()
		
func _process(delta: float) -> void:
	if !locker.visible:
		player.setMoveable(true)
	else:
		if locker.get_current_code() == "2317":
			locker.code_correct()
			GameStateManager.is_Storage_locker_opened = true

func _on_light_switch_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("ui_leftMouseClick"):
		while not player.get_is_destination():
			await  get_tree().process_frame
		if !$CanvasModulate.visible:
			$CanvasModulate.visible = true
			GameStateManager.is_Storage_light = false
		else:
			$CanvasModulate.visible = false
			GameStateManager.is_Storage_light = true


func _on_key_box_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("ui_leftMouseClick"):
		while not player.get_is_destination():
			await  get_tree().process_frame
		player.setMoveable(false)
		locker.set_visible(true)


func _on_door_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		is_door = true


func _on_door_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		is_door = false


func _on_door_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("ui_leftMouseClick") && is_door:
		SceneTransition.load_scene(next_scene)
