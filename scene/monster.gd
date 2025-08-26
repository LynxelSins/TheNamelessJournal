extends Area2D


#hard code, store position that monster supposed to be
var pos1 = Vector2(952.0,609.0)
var pos2 = Vector2(667.0,555.0)
var pos3 = Vector2(335.0,446.0)
var pos4 = Vector2(533.0,348.0)
var pos5 = Vector2(759.0,214.0)


#array <--- use this one
var location : Array[Vector2] = [
	Vector2(952.0, 609.0),
	Vector2(667.0, 555.0),
	Vector2(335.0, 446.0),
	Vector2(533.0, 348.0),
	Vector2(759.0, 214.0)
]
var is_light = false
var curr_pos = 0


func _ready() -> void:
	randomize()
	position = location[0]
	
	
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
			
	elif is_light && randi() %3 +1 == 1:
		if curr_pos > 0: # Safer check
			curr_pos -= 1
	
	# Clamp the value to be safe and prevent crashes
	curr_pos = clamp(curr_pos, 0, location.size() - 1)
	
	# Update the position after the logic is done
	position = location[curr_pos]
	#print("Timer ticked! Current Position Index: ", curr_pos)
	
	
#on finsih the minigame. use to disable the monster	
func finish():
	$Timer.stop()
	visible = false
	$CollisionShape2D.disabled
