extends CharacterBody3D

@export var speed: float = 5

func _process(delta: float) -> void:
	var input_vector = Vector2.ZERO

	if Input.is_action_pressed("up"):
		input_vector.y -= 1
		input_vector.x -= 1
	if Input.is_action_pressed("down"):
		input_vector.y += 1
		input_vector.x += 1
	if Input.is_action_pressed("left"):
		input_vector.y += 1
		input_vector.x -= 1
	if Input.is_action_pressed("right"):
		input_vector.y -= 1
		input_vector.x += 1
	if Input.is_action_just_released("zoomin"):
		if $Camera3D.size > 5:
			$Camera3D.size -= 1
	if Input.is_action_just_released("zoomout"):
		if $Camera3D.size < 20:
			$Camera3D.size += 1

	if input_vector != Vector2.ZERO:
		input_vector = input_vector.normalized()

		var movement_direction = Vector3(input_vector.x, 0, input_vector.y)
		var target_rotation = atan2(movement_direction.x, movement_direction.z)

		$Car.rotation.y = lerp_angle($Car.rotation.y, target_rotation, speed * delta)
		velocity = movement_direction * speed
	else:
		velocity = Vector3.ZERO
	move_and_slide()
