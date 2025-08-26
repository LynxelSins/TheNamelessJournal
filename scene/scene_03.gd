extends Control

var is_mouse_held_down_on_shape = false
@onready var lever = $switch/lever
@onready var gate = $door/Sprite2D
@onready var gate_start_pos = gate.position
@onready var light = $light_mouse/PointLight2D
@onready var light_player = $CharacterBody2D/PointLight2D2
@onready var light_door = $PointLight2D2
@export var next_scene : PackedScene

var gate_final_pose = Vector2(1226.0,110.0)
var open_speed: float = 20 #you determine
var close_speed: float = 25 # you determine
var lever_speed: float = 8.0 #not use. ai slope did this

var flicker_timer := 0.0
var flicker_delay := 0.08  

func _ready() -> void:
	$CharacterBody2D.is_levelable = true
	

#maybe the lever box. idk , ai did this
func _on_switch_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			print("Mouse button PRESSED on shape.")
			is_mouse_held_down_on_shape = true
		
		if event.button_index == MOUSE_BUTTON_LEFT and not event.is_pressed():
			print("Mouse button RELEASED on shape.")
			is_mouse_held_down_on_shape = false


func _on_switch_mouse_exited() -> void:

	if is_mouse_held_down_on_shape:
		print("Mouse exited shape while held down.")
		is_mouse_held_down_on_shape = false
		
func _physics_process(delta: float) -> void:
	
	
	#flashlight flicker
	flicker_timer -= delta
	if flicker_timer <= 0.0:
		light.energy = randf_range(0.6,0.8)
		light_player.energy = randf_range(0.2,0.23)
		light_door.energy = randf_range(0.2,0.23)
		flicker_timer = flicker_delay  # reset timer
		
	# This is the core logic that runs every frame, handle lever animation and gate open ani
	if is_mouse_held_down_on_shape && gate.position != gate_final_pose:
		gate.position = gate.position.move_toward(gate_final_pose, open_speed * delta)
		lever.rotation = 0
	elif gate.position != gate_final_pose:
		lever.rotation = 110
		gate.position = gate.position.move_toward(gate_start_pos, close_speed * delta)
	else:
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
	light.visible = false
	light_player.visible = false
	light_door.visible = false
	$CanvasModulate.visible = false





func _on_door_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		SceneTransition.load_scene(next_scene)
	
