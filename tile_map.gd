extends TileMap

var highlight_tile_id: int = 1  
var highlight_atlas_coords: Vector2 = Vector2(3, 0)
var current_highlighted_cell: Vector2i = Vector2i(-999, -999)
var current_highlighted_layer: int = -1

func _ready() -> void:
	randomize()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		highlight_cell_under_mouse()
	elif event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var local_mouse_pos = to_local(get_global_mouse_position())
		var cell_coords = local_to_map(local_mouse_pos)
		place_on_next_free_layer(cell_coords, highlight_tile_id, highlight_atlas_coords)
		remove_highlight()

func highlight_cell_under_mouse() -> void:
	var local_mouse_pos = to_local(get_global_mouse_position())
	var cell_coords = local_to_map(local_mouse_pos)


	if cell_coords == current_highlighted_cell:
		return

	remove_highlight()

	var layer_id = get_next_free_layer_id(cell_coords)
	if layer_id != -1:
		set_cell(layer_id, cell_coords, highlight_tile_id, highlight_atlas_coords)
		current_highlighted_cell = cell_coords
		current_highlighted_layer = layer_id

func remove_highlight() -> void:
	if current_highlighted_layer != -1:
		set_cell(current_highlighted_layer, current_highlighted_cell, -1)
	current_highlighted_cell = Vector2i(-999, -999)
	current_highlighted_layer = -1

func get_next_free_layer_id(cell_coords: Vector2i) -> int:

	var total_layers = get_layers_count()
	for layer_id in range(total_layers - 1, -1, -1):  
		if get_cell_source_id(layer_id, cell_coords) == -1:
			return layer_id
	return -1  

func place_on_next_free_layer(cell_coords: Vector2i, tile_id: int, atlas_coords := Vector2(0, 0)) -> void:
	var total_layers = get_layers_count()
	for layer_id in range(total_layers - 1, -1, -1): 
		if get_cell_source_id(layer_id, cell_coords) == -1:
			set_cell(layer_id, cell_coords, tile_id, atlas_coords)
			print("Placed tile on layer:", layer_id)
			return
	print("No free layer available at:", cell_coords, "😥")
