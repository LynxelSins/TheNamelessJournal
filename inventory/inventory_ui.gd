extends Control


@onready var inv: Inv = preload("res://inventory/items/player_inv.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()
var is_open = false


func _ready():
	inv.update.connect(update_slots)
	update_slots()
	close()
	
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Inventory"):
		if !is_open:
			open()
		else:
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
		
		
		
func find_item_by_name(item_name: String) -> int:
	for i in range(inv.slots.size()):
		var slot_data = inv.slots[i]
		# Check if the slot is valid, has an item, and if the item's name matches.
		if slot_data and slot_data.item and slot_data.item.name == item_name:
			print("Found '", item_name, "' at index: ", i)
			return i # Return the index of the found item
	
	print("Item '", item_name, "' not found.")
	return -1 # Return -1 if the loop finishes without finding the item
	
	
func remove_item_by_name(item_name: String) -> bool:
	# Use our find function to get the index of the item.
	var item_index = find_item_by_name(item_name)
	
	# If item_index is not -1, it means the item was found in the inventory.
	if item_index != -1:
		# To "remove" the item, we replace its slot data with an empty InvSlot object.
		# Setting it to 'null' caused the error because the UI slot script
		# doesn't know how to handle a null value.
		# By creating a new InvSlot, we ensure the slot has a valid object,
		# even if that object contains no item.
		inv.slots[item_index] = InvSlot.new()

		# After modifying the inventory data, we must update the UI to show the change.
		update_slots()
		print("Removed '", item_name, "' from inventory.")
		return true # Indicate that the removal was successful.
		
	# This code runs if the item was not found.
	print("Could not remove '", item_name, "' because it was not in the inventory.")
	return false # Indicate that no item was removed.
