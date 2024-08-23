extends Node2D

@onready var player = null
@onready var start = $Start
@onready var exit = $Exit
@onready var deathzone = $Deathzone
@onready var ui = $UI
@onready var hud =  $UI/HUD
@onready var win_screen = $UI/WinScreen

@export var  next_level: PackedScene = null
@export var is_final_level: bool = false

var timer_node = null #the timer that keeps track of the time elapsed since the start of the level.
@export var level_time = 5 #the amount of time in seconds in which the player needs to complete the level.
var time_left = null #the amount of time left on the level timer.

var win = false

func _ready():
	player = get_tree().get_first_node_in_group("player") #this sets the player variable as the first node in the tree that has the "player" group
	if player != null: #if the player is not null, set his position to the marker2D of the start node.
		player.global_position = start.get_spawn_position()
	
	player.global_position = start.global_position
	
	var traps = get_tree().get_nodes_in_group("traps")# this gets all the nodes that have the "traps" group(tag). PUT THE GROUP IN THE ROOT NODE ONLY!
	for trap in traps: # for every element "trap" in array "traps", execute the code below.
		trap.touched_player.connect(_on_trap_touched_player) # connect the touched_player signal of all the elements of the array to the _on_trap_touched_player function. 
	
	exit.body_entered.connect(_on_exit_body_entered) # this connects the "body_entered" signal of the exit to the function specified inside the brackets.
	deathzone.body_entered.connect(_on_deathzone_body_entered) # ditto as above
	
	time_left = level_time
	hud.set_time_label(time_left)
	
	timer_node = Timer.new() #creates a new timer node.
	timer_node.name = "Level Timer" #sets the time of the timer node as "Level Timer"
	timer_node.wait_time = 1
	timer_node.timeout.connect(_on_level_timer_timeout)
	add_child(timer_node) #adds the timer node as a child of the level scene
	timer_node.start()

func _on_level_timer_timeout():
	if win == false:
		time_left -= 1
		hud.set_time_label(time_left)
		if time_left < 0:
			AudioPlayer.play_sound_effect("hurt_sound")
			reset_player()
			time_left = level_time
			hud.set_time_label(time_left)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()

func _on_deathzone_body_entered(body):
	if body is Player:
		AudioPlayer.play_sound_effect("hurt_sound")
		reset_player()

func _on_trap_touched_player():
	AudioPlayer.play_sound_effect("hurt_sound")
	reset_player()

func reset_player():
	player.velocity = Vector2.ZERO
	player.global_position = start.global_position
func _on_exit_body_entered(body):
	if body is Player:
		if is_final_level || (next_level!= null):
			exit.animate() #animate the exit
			player.active = false # set the player as not active
			win = true
			await get_tree().create_timer(1.5).timeout #create a new timer, set it to 1,5 seconds, then wait for it to time out before proceding.
			if is_final_level:
				ui.show_win_screen(true)
			else: 
				get_tree().change_scene_to_packed(next_level) #load the new scene
