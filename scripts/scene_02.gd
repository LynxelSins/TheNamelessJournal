extends Control

@onready var player = $CharacterBody2D
@export var inv : Inv
@export var note_1 : InvItem

func _ready() -> void:
	$CharacterBody2D.is_levelable = false
	if GameStateManager.Corridor_NoteTaken:
		$note_1.visible = false
	if GameStateManager.Corridor_FromScene_3:
		GameStateManager.Corridor_FromScene_3 = false
		player.position.x = 975.0
		player.destination.x = 975.0


##collect note 1 into inv
func _on_note_1_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("ui_leftMouseClick"):
		while not player.get_is_destination():
			await  get_tree().process_frame
		inv.insert(note_1)	
		$note_1.visible = false
		GameStateManager.Corridor_NoteTaken = true
