extends Path2D
class_name MovingObject

# this script is for all objects that move along a line such as traps, doors, moving platforms etc.
# The settings allow you to decide whether or not the object is active, moves back and forth, waits for some time before moving. 
@export var object = Node2D # THIS MUST ALWAYS BE THE OBJECT THE OBJECT THAT WILL MOVE 

var color_type = 0
@export var object_color = clampi(color_type, 0, 3) ## Determines the color of the object. 0 = No Color, 1 = Red, 2 = Blue, 3 = Yellow.

@export var is_active = false #toggles whether or not the object is active or not.
@export var loops = false #toggles wether or not the object will move back and forth
@export var movement_direction = true #TRUE means the direction will be additive, FALSE that it will be subtractive.

@export var move_speed = 0.25 #the movement speed of the object
@export var time_before_activation = 0.5 # the amount of time that passes before the object starts moving.

@onready var path_follow = $PathFollow2D

func _ready():
	#print(name + ": " + str(object_color))
	#object.set_color(object_color)
	#object.change_object_color_sprite(object_color)
	#add_to_color_group(object_color)
	pass

func _physics_process(delta):
	if is_active == true:
		if movement_direction == true:
			path_follow.progress_ratio += move_speed * delta
		if movement_direction == false:
			path_follow.progress_ratio -= move_speed * delta
	
	if path_follow.progress_ratio <= 0:
		#print("True End Reached")
		if loops == true: 
			set_direction(true)
	elif path_follow.progress_ratio >= 1:
		#print("False End Reached")
		if loops == true: 
			set_direction(false)

func set_color(color: int): #this sets the value
	object_color = color
	print(name + " color: " + str(object_color))

func set_active(active: bool): #this toggles the active variable.
	is_active = active

func set_progress_ratio(ratio): #this modifies the progress ratio by the amount specified.
	path_follow.progress_ratio = ratio

func set_direction(direction: bool):
	await get_tree().create_timer(time_before_activation).timeout
	movement_direction = direction

func add_to_color_group(color: int):
	if object_color == 0:
		pass
	elif object_color == 1:
		add_to_group("Red")
		print(get_groups())
	elif object_color == 2:
		add_to_group("Blue")
		print(get_groups())
	elif object_color == 3:
		add_to_group("Yellow")
		print(get_groups())
	else:
		print("Invalid value. Must be either 0 for Neutral, 1 for Red, 2 for Blue or 3 for Yellow.")
