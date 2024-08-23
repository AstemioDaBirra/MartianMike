extends Area2D

var color_type = 0
@export var object_color = clampi(color_type, 0, 3) ## Determines the color of the object. 1 = Red, 2 = Blue, 3 = Yellow.
@export var is_activated = false
@export var linked_objects : Array[MovingObject]

@onready var color_sprite = $ColorSprite
@onready var collision_shape = $CollisionShape2D
@onready var animation_player = $AnimationPlayer

func _ready():
	change_object_color_sprite(object_color) #changes the color of the switch's color sprite
	change_linked_objects_color(object_color) #change the color value of the linked objects
	activate_linked_objects(is_activated) #change the active state of the linked objects
	#activate_animation()

func activate_animation():
	animation_player.play("activate")

func change_active_state(state: bool): #changes the state of the switch, then activates the linked objects.
	is_activated = state
	activate_linked_objects(state)

func activate_linked_objects(state: bool):
	for i in linked_objects:
		i.set_active(state)

func change_linked_objects_color(color: int):
		for i in linked_objects:
			i.set_color(color)
			print("Changed color of " + str(i.name) + " to " + str(i.object_color))
			i.object.change_object_color_sprite(color)
			i.add_to_color_group(color)
			print(str(i.name) + " is part of groups: " + str(i.get_groups()))

func change_object_color_sprite(color: int):
	if object_color == 1:
		color_sprite.modulate = Color(1,0,0,1) #modulate the ColorSprite to Red
		#add_to_group("Red")
		#print(get_groups())
	elif object_color == 2:
		color_sprite.modulate = Color(0,0,1,1) #modulate the ColorSprite to Blue
		#add_to_group("Blue")
		#print(get_groups())
	elif object_color == 3:
		color_sprite.modulate = Color(1,1,0,1) #modulate the ColorSprite to Yellow
		#add_to_group("Yellow")
		#print(get_groups())
	else:
		print("Invalid value. Must be either 1 for Red, 2 for Blue or 3 for Yellow.")
		color_sprite.set_visible(false) #set the visibility to false

func _on_body_entered(body):
	if body is Player && is_activated == false:
		activate_animation()
