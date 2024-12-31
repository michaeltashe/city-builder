extends "res://Scenes/World/tile_manager.gd"

var rng = RandomNumberGenerator.new()
var size = 128

const MAX_INT = 9223372036854775807

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	var texture = NoiseTexture2D.new()
	texture.height = size
	texture.width = size
	texture.noise = FastNoiseLite.new()
	texture.noise.set_seed(rng.randi_range(0, MAX_INT ))
	texture.noise.set_noise_type(FastNoiseLite.TYPE_PERLIN)
	await texture.changed

	var image = texture.get_image()

	var center = Vector2(size / 2, size / 2)
	var max_distance = center.distance_to(Vector2(0, 0))

	for y in range(size):
		for x in range(size):
			var pixel_color = image.get_pixel(x, y)
			var pixel_value = pixel_color.r * 255

			var distance = Vector2(x, y).distance_to(center)
			var falloff = 1.0 - (distance / max_distance)
			var adjusted_value = pixel_value * falloff

			var tile_x = x - (size / 2)
			var tile_y = y - (size / 2)

			if adjusted_value >= 90:
				$".".set_cell(0, Vector2(tile_x, tile_y), 1, Vector2(0, 0))  # Grass
			elif adjusted_value >= 75:
				$".".set_cell(0, Vector2(tile_x, tile_y), 1, Vector2(13, 0))  # Sand
