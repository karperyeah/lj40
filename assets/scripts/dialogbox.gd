class_name DialogBox
extends Control

onready var content : RichTextLabel = $Content
onready var type_timer : Timer
onready var character_sound : AudioStreamPlayer = get_node("DialogueSound")
var playing_voice : bool = false

func _ready():
	type_timer = Timer.new()
	add_child(type_timer)
	type_timer.wait_time = 0.04
	# character_timer.one_shot = true
	type_timer.connect("timeout", self, "_character_timer_timeout")
	type_timer.start()

func _update_message(message : String):
	content.bbcode_text = message
	content.visible_characters = 0
	character_sound.play()
	type_timer.start()

func _process(delta):
	pass

func _character_timer_timeout():
	if content.visible_characters < content.text.length():
		content.visible_characters += 1
		character_sound.pitch_scale = rand_range(0.8, 1.2)
		character_sound.play()
	else:
		type_timer.stop()
