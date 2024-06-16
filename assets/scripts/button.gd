extends Area2D

export var color : Color = Color(255, 255, 255)
onready var button_sprite : Sprite = $Button
signal on_press

func _ready():
	button_sprite.modulate = color
	$AnimationPlayer.play("Idle")
	$Base/AnimationPlayer.play("Idle")
	$Button/AnimationPlayer.play("Idle")

func _on_Button_area_entered(area):
	$AnimationPlayer.play("Press")
	$Sound.pitch_scale = rand_range(0.8, 1.2)
	$Sound.play()
	emit_signal("on_press")
