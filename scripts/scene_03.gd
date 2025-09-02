extends Control

var is_mouse_held_down_on_shape = false
@onready var lever = $switch/lever
@onready var gate = $door/Sprite2D
@onready var gate_start_pos = gate.position

@onready var light_player = $CharacterBody2D/PointLight2D2
@onready var light_door = $PointLight2D2
@export var next_scene : String = "res://scene/scene_04.tscn"
@onready var monster = $monster

var gate_final_pose = Vector2(1226.0,110.0)
var open_speed: float = 10 #you determine 15
var close_speed: float = 7 # you determine
var lever_speed: float = 8.0 #not use. ai slope did this
var is_door_sound_playing = false

var flicker_timer := 0.0
var flicker_delay := 0.08  

func _ready() -> void:
	monster.connect("stair_end", _on_stair_end)
	$CharacterBody2D.is_levelable = true
	if GameStateManager.is_stair_finish:
		opened_the_gate()
		
	if GameStateManager.Stair_From_Scene_4:
		GameStateManager.Stair_From_Scene_4 = false
		$CharacterBody2D.position = Vector2(1101.0,663.0)
		$CharacterBody2D.destination = Vector2(1101.0,663.0)
	
		
#maybe the lever box. idk , ai did this
func _on_switch_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			print("Mouse button PRESSED on shape.")
			AudioManager.electrical.play()
			is_mouse_held_down_on_shape = true
		
		if event.button_index == MOUSE_BUTTON_LEFT and not event.is_pressed():
			print("Mouse button RELEASED on shape.")
			is_mouse_held_down_on_shape = false


func _on_switch_mouse_exited() -> void:

	if is_mouse_held_down_on_shape:
		print("Mouse exited shape while held down.")
		is_mouse_held_down_on_shape = false
		
func _physics_process(delta: float) -> void:
	
	# Determine if the gate is currently moving
	var is_moving = false
	
	# --- GATE MOVEMENT LOGIC ---
	
	# Condition for OPENING
	if is_mouse_held_down_on_shape and gate.position != gate_final_pose:
		gate.position = gate.position.move_toward(gate_final_pose, open_speed * delta)
		lever.rotation = 0
		is_moving = true
	
	# Condition for CLOSING
	# (The 'else' here prevents this from running if the opening condition is met)
	else:
		# Also, only try to close if it's not already closed
		if gate.position != gate_start_pos && !GameStateManager.is_stair_finish:
			gate.position = gate.position.move_toward(gate_start_pos, close_speed * delta)
			lever.rotation = 110
			is_moving = true
		# This is the "fully closed" state, do nothing related to movement.
		
	# --- AUDIO STATE LOGIC ---
	
	# If the gate is supposed to be moving...
	if is_moving:
		# ...but the sound ISN'T playing yet, then START it.
		if not is_door_sound_playing:
			AudioManager.iron_door.play()
			is_door_sound_playing = true # Remember that the sound is now playing
	
	# If the gate is NOT supposed to be moving...
	else:
		# ...but the sound IS playing, then STOP it.
		if is_door_sound_playing:
			AudioManager.iron_door.stop()
			is_door_sound_playing = false # Remember that the sound is now stopped
			
			# Optional: You can put your one-time "opened_the_gate" call here
			# It will only run on the first frame the gate stops moving.
			if gate.position == gate_final_pose:
				opened_the_gate()
	if gate.position == gate_final_pose:
				opened_the_gate()

## monster and flashlight handling, enter
func _on_monster_area_entered(area: Area2D) -> void:
	if area.is_in_group("Light"):
		$monster.set_light(true)
		print("light is true")

## monster and flashlight handling, exit
func _on_monster_area_exited(area: Area2D) -> void:
	if area.is_in_group("Light"):
		$monster.set_light(false)
		print("light is false")
		
#after the gate fully open. aka finished the minigame
func opened_the_gate():
	$monster.finish()
	
	light_player.visible = false
	light_door.visible = false
	gate.position = gate_final_pose
	$monster/CanvasModulate.visible = false
	GameStateManager.is_stair_finish = true



func _on_stair_end():
	GameStateManager.is_loop_ending = true
	opened_the_gate()

func _on_door_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") && GameStateManager.is_stair_finish:
		
		SceneTransition.load_scene(next_scene)
	
