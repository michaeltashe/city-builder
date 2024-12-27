extends CharacterBody2D

@export var speed = 160

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")

	if (Input.is_action_pressed("sprint")):
		velocity = input_direction * speed * 3
	else:
		velocity = input_direction * speed

func _physics_process(delta):
	get_input()
	move_and_slide()
