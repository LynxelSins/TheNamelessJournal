extends Control

@onready var player = $CharacterBody2D
@export var inv : Inv
@export var note_1 : InvItem

func _on_note_1_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("ui_leftMouseClick"):
		while not player.get_is_destination():
			await  get_tree().process_frame
		inv.insert(note_1)	
		$note_1.visible = false
