extends Node

var hurt_sound = preload("res://assets/audio/hurt.wav")
var jump_sound = preload("res://assets/audio/jump.wav")

func play_sound_effect(sfx_name: String):
	
	var stream = null
	
	if sfx_name == "hurt_sound":
		stream = hurt_sound
	elif sfx_name == "jump_sound":
		stream = jump_sound
	else:
		print("invalid sfx name")
		return
	
	var asp = AudioStreamPlayer.new() # create a new AudioStreamPlayer
	asp.stream = stream # set the stream propertry as the value of the variable declared above
	asp.name = "SFX" #set the hame of the new AudioStreamPlayer
	
	add_child(asp) #add the audiostream as a child
	
	asp.play() # play the audiostream
	
	await asp.finished #await for the "finished()" signal to be emitted.
	asp.queue_free() #destroy the audio stream.
