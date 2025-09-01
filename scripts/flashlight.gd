extends Area2D

var flicker_timer := 0.0
var flicker_delay := 0.08 
@onready var light = $light



func _ready() -> void:
	light.visible = false
	if GameStateManager.is_flashlight_enable:
		light.visible = true
	else: 
		light.visible = false

func _process(delta: float) -> void:
	position = get_global_mouse_position()
	if Input.is_action_just_pressed("flashlight_button"):
		if !GameStateManager.is_flashlight_enable:
			AudioManager.switch_light_on.play()
			GameStateManager.is_flashlight_enable = true
			light.visible = true
		else: 
			GameStateManager.is_flashlight_enable = false
			AudioManager.light_switch.play()
			light.visible = false
	
	
func _physics_process(delta: float) -> void:
	flicker_timer -= delta
	if flicker_timer <= 0.0:
		light.energy = randf_range(0.6,0.8)
		flicker_timer = flicker_delay  # reset timer	
