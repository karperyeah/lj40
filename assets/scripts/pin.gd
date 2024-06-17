extends Area2D

signal pin_Collected

export var scene : String


func _on_Pin_area_entered(area):
	SceneTransition.change_scene(scene)
