extends Node2D

onready var explosion_effect_scene = preload("res://assets/scenes/fx/explosion.tscn")

func _ready():
	$TV.visible = false

func _process(delta):
	pass

func _on_play_button_press():
	$AnimationPlayer.play("DoorExplodeCutscene")

func _on_settings_button_press():
	pass # Replace with function body.

func _spawn_explosion(): # literally just for the opening cutscene
	var explosion = explosion_effect_scene.instance()
	explosion.position = $Door.position
	add_child(explosion)
	$Player.position = $Door.position
	print("Boom!")

func _shake_screen(amount : float):
	Globals.shakyness += amount
