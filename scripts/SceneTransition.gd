# This script is an autoload, that can be accessed from any other script!

extends CanvasLayer

@onready var scene_transition_anim = $SceneTransitionAnim
@onready var dissolve_rect = $DissolveRect

# Scene Transition can be changed from the inspector(Currently only 2, fade and scale. You can add more!)
enum state {FADE, SCALE}
@export var transition_type : state

func _ready():
	dissolve_rect.hide() # Hide the dissolve rect

# You can call this function from any script by doing SceneTransition.load_scene("res://path/to/scene.tscn")
func load_scene(target_scene_path: String):
	# Check if the path is valid before proceeding
	if target_scene_path.is_empty():
		print("Scene transition failed: target_scene_path is empty.")
		return

	match transition_type:
		state.FADE:
			# Pass the string path along to the animation function
			transition_animation("fade", target_scene_path)
		state.SCALE:
			# Pass the string path along to the animation function
			transition_animation("scale", target_scene_path)

# This function handles the transition animation
func transition_animation(animation_name: String, scene_path: String):
	scene_transition_anim.play(animation_name)
	await scene_transition_anim.animation_finished
	
	# The most important change: use change_scene_to_file with the string path
	get_tree().change_scene_to_file(scene_path)
	
	# This line might not be reached if the scene changes instantly. 
	# For a fade-in on the new scene, that logic should be in the new scene's _ready() function.
	# However, if your CanvasLayer persists, this will work.
	scene_transition_anim.play_backwards(animation_name)
