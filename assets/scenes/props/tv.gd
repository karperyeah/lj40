extends Node2D

func _ready():
	$AnimationPlayer.play("Idle")
	$Agent/AnimationPlayer.play("Talk")
