extends Area2D


#hard code, store position that monster supposed to be
var pos1 = Vector2(952.0,609.0)
var pos2 = Vector2(667.0,555.0)
var pos3 = Vector2(335.0,446.0)
var pos4 = Vector2(533.0,348.0)
var pos5 = Vector2(759.0,214.0)

@onready var this_sprite = $Sprite2D
signal stair_end


var sprite : Array[String] = [
	"res://assets/charaters/Ghost1Picture/GhostIdle2.png",
	"res://assets/charaters/Ghost1Picture/GhostWark_1.png",
	"res://assets/charaters/Ghost1Picture/GhostIdle2.png",
	"res://assets/charaters/Ghost1Picture/GhostWark_2.png",
	"res://assets/charaters/Ghost1Picture/GhostSprint2.png"
]

#array <--- use this one
var location : Array[Vector2] = [
	Vector2(952.0, 609.0),
	Vector2(667.0, 555.0),
	Vector2(335.0, 426.0),
	Vector2(533.0, 338.0),
	Vector2(759.0, 214.0)
]
var is_light = false
var curr_pos = 0


func _ready() -> void:
	randomize()
	position = location[0]
	this_sprite.flip_h = true
	
	
	
func _physics_process(delta: float) -> void:
	pass
	#if randi() % 5 + 1 == 1 && !is_light:
		#if curr_pos < 5:
			#curr_pos +=1
			#position = location[curr_pos]
	#elif is_light && randi() %3 +1 == 1:
		#if curr_pos >= 0:
			#curr_pos -= 1
			#position = location[curr_pos]
			
			
			
			
func set_light(status : bool):
	is_light = status

	
	

#handle mosnter movement using timer and random
func _on_timer_timeout() -> void:
	# Your random logic now lives here.
	if randi() % 5 + 1 == 1 and not is_light:
		if curr_pos < location.size() - 1: # Safer check
			curr_pos += 1
			if curr_pos >= 2:
				this_sprite.flip_h = false
			else:
				this_sprite.flip_h = true
		else:
			emit_signal("stair_end")
			#play_video_then_quit()

			
	elif is_light && randi() %3 +1 == 1:
		if curr_pos > 0: # Safer check
			curr_pos -= 1
	
	# Clamp the value to be safe and prevent crashes
	curr_pos = clamp(curr_pos, 0, location.size() - 1)
	
	# Update the position after the logic is done
	position = location[curr_pos]
	this_sprite.texture = load(sprite[curr_pos])
	
	#print("Timer ticked! Current Position Index: ", curr_pos)
	
	
#on finsih the minigame. use to disable the monster	
func finish():
	$Timer.stop()
	visible = false
	$CollisionShape2D.disabled
	
func play_video_then_quit():
	$VideoStreamPlayer.loop = false
	$VideoStreamPlayer.play()
	$CanvasModulate.visible = false
	
	# The key change is here:
	# 'await' tells the function to PAUSE at this line...
	# ...until the timer's 'timeout' signal is received.
	await get_tree().create_timer(3.0).timeout
	
	# This line will ONLY be executed after the 5-second wait is over.
	SceneTransition.load_scene("res://scene/loopend.tscn")


func _on_video_stream_player_finished() -> void:
	print("finish")
