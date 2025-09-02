extends Control

@export var inv : Inv


func _ready() -> void:
	
	
	#global stuff
	AudioManager.audio_before_start.play()
	GameStateManager.is_flashlight_enable = false
	AudioManager.audio_while_game.stop()
	GameStateManager.is_loop_ending = false
	GameStateManager.clear_inv = true


	#scene no.1 stuff
	GameStateManager.Office_Light = false
	GameStateManager.Office_puzzle_slot_1 = 0
	GameStateManager.Office_puzzle_slot_2 = 0
	GameStateManager.Office_puzzle_slot_3 = 0
	GameStateManager.Office_puzzle_slot_4 = 0
	GameStateManager.Office_Linchuck_open = false
	GameStateManager.Office_noteTaken = false
	GameStateManager.Office_From_Scene_2 = false
	GameStateManager.is_tutorial_done = false


	#scene no.2 stuff
	GameStateManager.Corridor_NoteTaken = false
	GameStateManager.Corridor_FromScene_3 = false

	#scene no.3 stuff
	GameStateManager.is_stair_finish = false
	GameStateManager.Stair_From_Scene_4 = false
	GameStateManager.is_tutorial_stair_done = false

	#scene no.4 stuff

	GameStateManager.is_from_scene_5 = false
	GameStateManager.is_safe_scene_4_opened = false
	GameStateManager.is_safe_key_scene_4_takend = false
	GameStateManager.is_light_scene_4 = false
	GameStateManager.is_scene_4_storage_opened = false
	GameStateManager.is_scene_4 = false 
	GameStateManager.is_scene_4_note_taken = false
	GameStateManager.is_door_right_opened = false

	#scene no.5 stuff
	GameStateManager.is_Storage_light = false
	GameStateManager.Storage_puzzle_slot_1 = 0
	GameStateManager.Storage_puzzle_slot_2 = 0
	GameStateManager.Storage_puzzle_slot_3 = 0
	GameStateManager.Storage_puzzle_slot_4 = 0 
	GameStateManager.is_Storage_locker_opened = false
	GameStateManager.is_Storage_item_note_taken = false
	GameStateManager.is_Storage_item_Key_taken = false


func _on_button_button_down() -> void:
	AudioManager.audio_before_start.stop()
	AudioManager.audio_while_game.play()
	SceneTransition.load_scene("res://scene/scene_01.tscn")
	
