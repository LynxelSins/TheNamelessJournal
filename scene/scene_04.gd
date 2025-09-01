extends Control


@export var inv: Inv
@export var note2:InvItem
@onready var player = $CharacterBody2D
@onready var safe_puzzle = $safe_puzzle
var is_middle_pressable = true

func _ready() -> void:
	GameStateManager.is_scene_4 = true
	AudioManager.close_door.play()
	$CharacterBody2D.is_levelable = true
	if GameStateManager.is_safe_scene_4_opened:
		safeOpened()
		safe_puzzle.code_correct()
		if GameStateManager.is_safe_key_scene_4_takend:
			safe_puzzle.noKey()
			
	if GameStateManager.is_light_scene_4:
		light_on()
	
	
	
func _process(delta: float) -> void:
	if !safe_puzzle.visible:
		player.setMoveable(true)
		is_middle_pressable = true
	else:
		if safe_puzzle.get_current_code() == "13":
			safe_puzzle.code_correct()
			AudioManager.open_iron_Locker.play()
			GameStateManager.is_safe_scene_4_opened = true
			light_on()
			GameStateManager.is_light_scene_4 = true
			

func light_on():
	$CanvasModulate.visible = false
	$background/base.visible = false
	$background/base_light.visible = true
	
func storage_door():
	$background/storage_door_opened.visible = true
	
func safeOpened():
	$background/safe_opened.visible = true


func _on_door_right_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("ui_leftMouseClick"):
		if $"player UI/Inventory".find_item_by_name("storageRoom key") != -1:
			$"player UI/Inventory".remove_item_by_name("storageRoom key")
			SceneTransition.load_scene("res://scene/scene_05.tscn")
			GameStateManager.is_scene_4 = false
			AudioManager.open_door.play()
		else:
			print("nah")


func _on_door_left_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("ui_leftMouseClick"):

		
		GameStateManager.Stair_From_Scene_4 = true
		GameStateManager.is_scene_4 = false
		SceneTransition.load_scene("res://scene/scene_03.tscn")
			
	


func _on_door_door_middle_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("ui_leftMouseClick"):
		if is_middle_pressable:
			GameStateManager.is_scene_4 = false
			AudioManager.audio_while_game.stop()
			AudioManager.open_door.play()
			print("mid")


func _on_note_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("ui_leftMouseClick"):
		inv.insert(note2)
		$note/Sprite2D.visible = false
		$note/CollisionShape2D.disabled = true


func _on_safe_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("ui_leftMouseClick"):
		player.isMoveable = false
		is_middle_pressable = false
		AudioManager.open_iron_Locker.play()
		safe_puzzle.visible = true
