extends TileMap

# Tile ID used to highlight cells
var highlight_tile_id: int = 1  
# Atlas coordinates for the highlight tile
var highlight_atlas_coords: Vector2 = Vector2(3, 0)
# Tracks the currently highlighted cell and layer
var current_highlighted_cell: Vector2i = Vector2i(-999, -999)
var current_highlighted_layer: int = -1

# Array of building types
var buildings = ["Grass", "Water", "Red Building", "Gray Building", "Grass Ramp", "Water Ramp", "Road 1", "Road 2", "Intersection", "Road 3", "Road 4", "Road 5", "Road 6", "Sand", "Pink Building"]

# Selected building index
var selected_building = buildings.find("")

# Handles unprocessed input events
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion or Input.is_action_just_released("rotate"):
		highlight_cell_under_mouse()
	elif event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var local_mouse_pos = to_local(get_global_mouse_position())
		var cell_coords = local_to_map(local_mouse_pos)
		place_on_next_free_layer(cell_coords, highlight_tile_id, highlight_atlas_coords)
		remove_highlight()

# Highlights the cell under the mouse cursor
func highlight_cell_under_mouse() -> void:
	var local_mouse_pos = to_local(get_global_mouse_position())
	var cell_coords = local_to_map(local_mouse_pos)

	# Remove the previous highlight
	remove_highlight()

	# Get the next free layer and highlight the cell
	var layer_id = get_next_free_layer_id(cell_coords)
	if layer_id != -1:
		set_cell(layer_id, cell_coords, 0, Vector2(selected_building, 0))
		current_highlighted_cell = cell_coords
		current_highlighted_layer = layer_id

# Removes the highlight from the previously highlighted cell
func remove_highlight() -> void:
	if current_highlighted_layer != -1:
		set_cell(current_highlighted_layer, current_highlighted_cell, -1)
	current_highlighted_cell = Vector2i(-999, -999)
	current_highlighted_layer = -1

# Finds the next free layer ID for the given cell coordinates
func get_next_free_layer_id(cell_coords: Vector2i) -> int:
	var total_layers = get_layers_count()
	for layer_id in range(total_layers - 1, -1, -1):  
		if get_cell_source_id(layer_id, cell_coords) == -1:
			return layer_id
	return -1  

# Places a tile on the next available layer at the given cell coordinates
func place_on_next_free_layer(cell_coords: Vector2i, _tile_id: int, _atlas_coords := Vector2(0, 0)) -> void:
	var total_layers = get_layers_count()
	for layer_id in range(total_layers - 1, -1, -1): 
		if get_cell_source_id(layer_id, cell_coords) == -1:
			set_cell(layer_id, cell_coords, 1, Vector2(selected_building, 0))
			print("Placed tile on layer:", layer_id)
			return
	print("No free layer available at:", cell_coords)
