extends Node2D

func _ready():
	$TV.visible = false

func _process(delta):
	pass

func _on_play_button_press():
	$AnimationPlayer.play("IntroCutscene")

func _on_settings_button_press():
	pass # Replace with function body.
