extends Node2D

onready var explosion_effect_scene = preload("res://assets/scenes/fx/explosion.tscn")
var is_dialogue_mode : bool = false
var current_dialog_index : int = 0

var agent_dialogue : Array = [
	"You're late!",
	"We need you to fix the timeline!",
	"Various (former) agents left their jobs in ABHORRENT conditions!",
	"Your presence is actively pissing me off!",
	"Get back to work!"
]

func _ready():
	$TV.visible = false

func _process(delta):
	if is_dialogue_mode:
		if Input.is_action_just_pressed("action"):
			if current_dialog_index < agent_dialogue.size()-1:
				current_dialog_index += 1
				$CanvasLayer/DialogBox._update_message(agent_dialogue[current_dialog_index])
			if current_dialog_index == agent_dialogue.size()-1:
				$AnimationPlayer.play("DoorExplodeCutscene")
				$Player.allow_control = true
				is_dialogue_mode = false

func _on_play_button_press():
	$AnimationPlayer.play("IntroCutscene")
	var explosion1 = explosion_effect_scene.instance()
	explosion1.position = $Button.position
	add_child(explosion1)
	$Door/Spawn.play()
	get_node("Button").queue_free()

func _on_settings_button_press():
	pass

func _spawn_explosion(): # literally just for the opening cutscene
	var explosion = explosion_effect_scene.instance()
	explosion.position = $Door.position
	add_child(explosion)
	# $Player.position = $Door.position
	print("Boom!")

func _shake_screen(amount : float):
	Globals.shakyness += amount

func _dialog_mode(value : bool):
	is_dialogue_mode = value
	$CanvasLayer/DialogBox._update_message(agent_dialogue[0])
