extends Area2D

export var color : Color = Color(255, 255, 255)
onready var button_sprite : Sprite = $Button

func _ready():
	button_sprite.modulate = color
	$AnimationPlayer.play("Idle")
	$Base/AnimationPlayer.play("Idle")
	$Button/AnimationPlayer.play("Idle")

func _on_Button_area_entered(area):
	$AnimationPlayer.play("Press")
