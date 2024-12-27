extends TileMap

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var position = Vector2(rng.randf_range(-20, 20), rng.randf_range(-20, 20))
	
	$".".set_cell(0, position, 1, Vector2(rng.randf_range(0, 4), rng.randf_range(0, 2)))
