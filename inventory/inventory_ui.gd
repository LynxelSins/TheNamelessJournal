extends Control


@onready var inv: Inv = preload("res://inventory/items/player_inv.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()
var is_open = false


func _ready():
	inv.update.connect(update_slots)
	update_slots()
	close()
	
	
func update_display_item(item):
	
	## cant access item (see. inv_ui_slot , _on_panel_mouse_entered())
	## okay wait, item can access just fine but somehow it doesnt work, maybe problem with display_item node
	if item.texture != null && item.description != null:
		
		$display_item/display_texture.texture = item.texture
		$display_item/display_dis.text = str(item.description)
		$display_item/Item_name.text = str(item.name)
	
func update_slots():
	for i in range(min(inv.slots.size(),slots.size())):
		slots[i].update(inv.slots[i])
	
	
func open():
	visible = true
	is_open = true
	
func close():
	visible = false
	is_open = false


func _on_back_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("ui_leftMouseClick"):
		close()


func _on_panel_mouse_entered() -> void:
	if $NinePatchRect/GridContainer/Panel.item:
		update_display_item($NinePatchRect/GridContainer/Panel.item)


func _on_panel_2_mouse_entered() -> void:
	if $NinePatchRect/GridContainer/Panel2.item:
		update_display_item($NinePatchRect/GridContainer/Panel2.item)


func _on_panel_3_mouse_entered() -> void:
	if $NinePatchRect/GridContainer/Panel3.item:
		update_display_item($NinePatchRect/GridContainer/Panel3.item)


func _on_panel_4_mouse_entered() -> void:
	if $NinePatchRect/GridContainer/Panel4.item:
		update_display_item($NinePatchRect/GridContainer/Panel4.item)


func _on_panel_5_mouse_entered() -> void:
	if $NinePatchRect/GridContainer/Panel5.item:
		update_display_item($NinePatchRect/GridContainer/Panel5.item)


func _on_panel_6_mouse_entered() -> void:
	if $NinePatchRect/GridContainer/Panel6.item:
		update_display_item($NinePatchRect/GridContainer/Panel6.item)


func _on_panel_7_mouse_entered() -> void:
	if $NinePatchRect/GridContainer/Panel7.item:
		update_display_item($NinePatchRect/GridContainer/Panel7.item)


func _on_panel_8_mouse_entered() -> void:
	if $NinePatchRect/GridContainer/Panel8.item:
		update_display_item($NinePatchRect/GridContainer/Panel8.item)
