extends Area2D

func _ready():
	$AnimationPlayer.play("Idle")

func _on_Door_area_entered(area):
	$AnimationPlayer.play("Open")

func _on_Door_area_exited(area):
	$AnimationPlayer.play("Close")
