extends CharacterBody2D

@export var speed = 150
var destination = Vector2()
var snap_position = Vector2()
var direction = Vector2()
var isMoveable = true
var is_destination : bool = true
var is_levelable = false
var is_walking: bool = false


@export var inv: Inv

@onready var nav2D : NavigationAgent2D = $NavigationAgent2D

func _ready() -> void:
	destination = position
	$Player_Sprite.play("idle")
	AudioManager.walking.stop()

func _process(delta: float) -> void:
	
	# This first 'if' block is your main movement logic. It remains unchanged.
	if position.distance_to(destination) > 2:
		
		# --- AUDIO FIX START ---
		# We only play the sound if the state is CHANGING from not-walking to walking.
		if not is_walking:
			if !GameStateManager.is_scene_4:
				AudioManager.walking.play()
		# --- AUDIO FIX END ---

		nav2D.target_position = destination
		
		if !is_levelable:
			nav2D.target_position.y = position.y
		
		var direction = nav2D.get_next_path_position() - global_position
		direction = direction.normalized()

		velocity = velocity.lerp(direction * speed, delta * 10)
		$Player_Sprite.play("walk")
		is_walking = true # This line tells us the character is now walking
		move_and_slide()

		if direction.x > 0:
			$Player_Sprite.flip_h = false
		elif direction.x < 0:
			$Player_Sprite.flip_h = true
			
	# This second 'if' block is your main stopping logic. It also remains unchanged.
	if nav2D.is_navigation_finished():
		
		# --- AUDIO FIX START ---
		# We only stop the sound if the state is CHANGING from walking to not-walking.
		if is_walking:
			AudioManager.walking.stop()
		# --- AUDIO FIX END ---
		
		direction = Vector2.ZERO
		destination = position
		is_destination = true
		is_walking = false # This line tells us the character is now idle
		$Player_Sprite.play("idle")

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("ui_leftMouseClick") && isMoveable && is_destination:
		is_destination = false
		destination = get_global_mouse_position()
		
		snap_position.x = destination.x
		snap_position.y = position.y
		
		
func setMoveable(status : bool):
	isMoveable = status
	
	
func get_is_destination():
	return is_destination
	
	
func collect(item):
	inv.insert(item)
