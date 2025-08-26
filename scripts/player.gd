extends CharacterBody2D

@export var speed = 150
var destination = Vector2()
var snap_position = Vector2()
var direction = Vector2()
var isMoveable = true
var is_destination : bool = true
var is_levelable = false


@export var inv: Inv

@onready var nav2D : NavigationAgent2D = $NavigationAgent2D

func _ready() -> void:
	destination = position
	$Player_Sprite.play("idle")

func _process(delta: float) -> void:
	
	if position.distance_to(destination) > 2:
		
		nav2D.target_position = destination
		
		if !is_levelable:
			nav2D.target_position.y = position.y
		
		direction = nav2D.get_next_path_position() - global_position
		direction = direction.normalized()

		velocity = velocity.lerp(direction * speed, delta * 10)
		$Player_Sprite.play("walk")
		move_and_slide()

		

		if direction.x > 0:
			$Player_Sprite.flip_h = false
		elif direction.x < 0:
			$Player_Sprite.flip_h = true
			
	if nav2D.is_navigation_finished():
		direction = Vector2.ZERO
		destination = position
		is_destination = true
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
