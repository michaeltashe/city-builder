extends CanvasLayer

var buildings = ["Grass", "Water", "Red Building", "Gray Building", "Grass Ramp", "Water Ramp", "Road 1", "Road 2", "Intersection", "Road 3", "Road 4", "Road 5", "Road 6", "Sand", "Pink Building"]

var buildables = ["Red Building", "Gray Building", "Road 1", "Road 3", "Intersection", "Pink Building"]

@onready var hbox_container = $Panel/HBoxContainer

var currency = 1000

# Whether placement is allowed
var can_place = true

# Called when the node enters the scene tree for the first time.
func _ready():
	$Panel/HBoxContainer2/Label.text = str(currency)
	for building_name in buildings:
		if buildables.find(building_name) != -1:
			var filename = building_name.replace(" ", "-").to_lower()
			var button = TextureButton.new()
			button.set_texture_normal(load("res://Sprites/" +  filename + ".png"))
			button.button_down.connect(self._on_button_down.bind())
			button.button_up.connect(self._on_button_up.bind(building_name))
			button.mouse_filter = Control.MOUSE_FILTER_STOP
			button.focus_mode = Control.FOCUS_NONE
			hbox_container.add_child(button)

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_released("rotate"):
		print("rotate pressed")
		print("selected building: ", $"..".selected_building)
		# for straight roads
		if $"..".selected_building == 6:
			$"..".selected_building += 1
		elif $"..".selected_building == 7:
			$"..".selected_building -= 1
		# for L-shaped roads
		elif $"..".selected_building == 9:
			$"..".selected_building = 10
		elif $"..".selected_building == 10:
			$"..".selected_building = 12
		elif $"..".selected_building == 11:
			$"..".selected_building = 9
		elif $"..".selected_building == 12:
			$"..".selected_building = 11
		print("selected building: ", $"..".selected_building)

# Callback for button press
func _on_button_down():
	can_place = false
	
func _on_button_up(building_name):
	$"..".selected_building = buildings.find(building_name)
	can_place = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
