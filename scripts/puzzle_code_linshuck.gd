extends CanvasLayer

var first : int = 0
var second : int = 0
var third : int = 0
var fouth : int = 0


@export var inv: Inv
@export var item: InvItem

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


func _on_up_3_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("ui_leftMouseClick"):
		third = (third + 1) % 10
		$Node2D/Label_3.text = str(third)
		print("press")


func _on_down_3_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("ui_leftMouseClick"):
		third = (third - 1) % 10
		if (third <= -1):
			third = 9
		$Node2D/Label_3.text = str(third)
		print("press")


func _on_up_4_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("ui_leftMouseClick"):
		fouth = (fouth + 1) % 10
		$Node2D/Label_4.text = str(fouth)
		print("press")


func _on_down_4_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("ui_leftMouseClick"):
		fouth = (fouth - 1) % 10
		if (fouth <= -1):
			fouth = 9
		$Node2D/Label_4.text = str(fouth)
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
		
func get_current_code():
	return str(first) + str(second) + str(third) + str(fouth)
