extends CanvasLayer

var first : int = 0
var second : int = 0
var third : int = 0
var fouth : int = 0


@export var inv: Inv
@export var item: InvItem
@export var item2: InvItem

func _on_up_1_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("ui_leftMouseClick"):
		first = (first + 1) % 10
		$Node2D/Label_1.text = str(first)
		print("press")


func _on_down_1_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("ui_leftMouseClick"):
		first = (first - 1) % 10
		if (first <= -1):
			first = 9
		$Node2D/Label_1.text = str(first)
		print("press")


func _on_up_2_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("ui_leftMouseClick"):
		second = (second + 1) % 10
		$Node2D/Label_2.text = str(second)
		print("press")


func _on_down_2_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("ui_leftMouseClick"):
		second = (second - 1) % 10
		if (second <= -1):
			second = 9
		$Node2D/Label_2.text = str(second)
		print("press")





func _on_close_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("ui_leftMouseClick"):
		set_visible(false)
		
		

func code_correct():
	$Node2D.visible = false
	$open.visible = true
	



func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("ui_leftMouseClick"):
		inv.insert(item)
		$open/Area2D.visible = false
		GameStateManager.is_Storage_item_note_taken = true
		

	
func noKey():
	$open/key_area.visible = false	
		
func get_current_code():
	return str(first) + str(second)


func _on_key_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("ui_leftMouseClick"):
		inv.insert(item2)
		$open/key_area.visible = false
		GameStateManager.is_safe_key_scene_4_takend = true
