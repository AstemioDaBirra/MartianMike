extends ParallaxBackground

@export var bg_texture: CompressedTexture2D = preload("res://assets/textures/bg/Blue.png") #declaring variables like this forces the variable to be of this type, essentially like declaring variables in C#

@onready var sprite = $ParallaxLayer/Sprite2D
@onready var scroll_speed = 15

func _ready():
	sprite.texture = bg_texture

func _process(delta):
	sprite.region_rect.position += delta * Vector2(scroll_speed, scroll_speed)
	if sprite.region_rect.position >= Vector2(64,64):
		sprite.region_rect.position = Vector2()
