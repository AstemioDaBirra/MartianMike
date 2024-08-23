extends StaticBody2D

var color_type = 0
@export var object_color = clampi(color_type, 0, 3)

@onready var color_sprite = $ColorSprite

func set_color(color: int):
	object_color = color

func change_object_color_sprite(color: int):
	if color == 1:
		color_sprite.modulate = Color(1,0,0,1) #modulate the ColorSprite to Red
		#add_to_group("Red")
		#print(get_groups())
	elif color == 2:
		color_sprite.modulate = Color(0,0,1,1) #modulate the ColorSprite to Blue
		#add_to_group("Blue")
		#print(get_groups())
	elif color == 3:
		color_sprite.modulate = Color(1,1,0,1) #modulate the ColorSprite to Yellow
		#add_to_group("Yellow")
		#print(get_groups())
	else:
		print("Invalid value. Must be either 0 for neutral, 1 for Red, 2 for Blue or 3 for Yellow.")
		color_sprite.set_visible(false) #set the visibility to false
