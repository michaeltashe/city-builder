extends Node

var rng = RandomNumberGenerator.new()

var size = 64
const MAX_INT = 9223372036854775807

func _ready():
	
	var texture = NoiseTexture2D.new()
	texture.height = size
	texture.width = size
	texture.noise = FastNoiseLite.new()
	texture.noise.set_seed(rng.randi_range(0, MAX_INT ))
	texture.noise.set_noise_type(FastNoiseLite.TYPE_PERLIN)
	await texture.changed

	var image = texture.get_image()

	var center = Vector3(size / 2, 0, size / 2)
	var max_distance = center.distance_to(Vector3(0, 0, 0))

	for x in range(size):
		for z in range(size):
			var pixel_color = image.get_pixel(x, z)
			var pixel_value = pixel_color.r * 255

			var distance = Vector3(x, 0, z).distance_to(center)
			var falloff = 1.0 - (distance / max_distance)
			var adjusted_value = pixel_value * falloff

			var tile_x = x - (size / 2)
			var tile_z = z - (size / 2)

			# Grass
			if adjusted_value >= 90:
				var cube = CSGBox3D.new()
				var material = StandardMaterial3D.new()
				material.albedo_color = Color(77 / 255.0, 163 / 255.0, 42 /255.0)
				cube.position = Vector3(x - (size / 2), 0, z - (size / 2))
				cube.material = material
				add_child(cube)
			# Sand
			elif adjusted_value >= 75:
				var cube = CSGBox3D.new()
				var material = StandardMaterial3D.new()
				material.albedo_color = Color(214 / 255.0, 203 / 255.0, 148 /255.0)
				cube.position = Vector3(x - (size / 2), 0, z - (size / 2))
				cube.material = material
				add_child(cube)
