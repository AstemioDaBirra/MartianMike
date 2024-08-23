extends CharacterBody2D
class_name Player # defines the name of the class. This is useful for checking that this class can be used as a condition in statements and functions.

@export var gravity = 400
@export var speed = 125
@export var jump_force = 200

@onready var animated_sprite = $AnimatedSprite2D

var active = true

func _physics_process(delta):
	if is_on_floor() ==  false:
		velocity.y += gravity * delta #multiplying by delta makes this framerate-agnostic
		if velocity.y > 500:
			velocity.y = 500
	
	var direction = 0
	if active == true:
		if Input.is_action_just_pressed("jump") && is_on_floor(): #REACTIVATE THSI WHEN THE GAME IS DONE, THIS UNLOCKS UNLIMITED JUMPS!
			jump(jump_force)
	
		direction = Input.get_axis("move_left","move_right")
	if direction != 0:
		animated_sprite.flip_h = (direction == -1) 
	# when the direction is equal to -1, the funtion will return true  and flip the sprite on  the horizontal axis. 
	# If the direction is not equal to -1, the function returns false and flips the sprite to the original value.
	velocity.x = direction * speed
	move_and_slide()
	update_animations(direction)

func update_animations(direction):
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else: 
		if velocity.y < 0:
			animated_sprite.play("jump")
		else:
			animated_sprite.play("fall")

func jump(force):
	velocity.y  = -force
	AudioPlayer.play_sound_effect("jump_sound")
