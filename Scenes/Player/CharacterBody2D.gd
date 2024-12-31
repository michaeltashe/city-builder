extends CharacterBody2D

@export var speed = 160
@export var zoom_amount = 0.25



func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	if (Input.is_action_pressed("sprint")):
		velocity = input_direction * speed * 3
	else:
		velocity = input_direction * speed
		
	if (Input.is_action_just_released("zoomin")):
		if $Camera2D.zoom.x < 3:
			$Camera2D.zoom.x += zoom_amount
			$Camera2D.zoom.y += zoom_amount
	if (Input.is_action_just_released("zoomout")):
		if $Camera2D.zoom.x > 1:
			$Camera2D.zoom.x -= zoom_amount
			$Camera2D.zoom.y -= zoom_amount

func _physics_process(_delta):
	get_input()
	move_and_slide()
