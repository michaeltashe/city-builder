extends "res://Scenes/World/tile_manager.gd"

# Random number generator instance
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	# Make the mouse pointer visible
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	# Generate a procedural texture
	var texture = NoiseTexture2D.new()
	texture.height = 64
	texture.width = 64
	texture.noise = FastNoiseLite.new()
	texture.noise.set_seed(rng.randi_range(0, 1000))
	texture.noise.set_noise_type(FastNoiseLite.TYPE_PERLIN)
	await texture.changed

	# Extract image data from the generated texture
	var image = texture.get_image()
	var data = image.get_data()

	# Fill the tilemap based on the texture data
	var count = 0
	var y = 0
	var x = 0

	for i in len(data):
		if count % 64 == 0:
			y += 1
			x = 0
		if data[i] >= 96:
			$".".set_cell(0, Vector2(x, y), 1, Vector2(0, 0))
		elif data[i] >= 80:
			$".".set_cell(0, Vector2(x, y), 1, Vector2(13, 0))
		count += 1
		x += 1
