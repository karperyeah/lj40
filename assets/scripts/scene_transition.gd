extends CanvasLayer


func change_scene(scene: String) -> void:
	$AnimationPlayer.play("Fade")
	yield($AnimationPlayer, 'animation_finished')
	get_tree().change_scene(scene)
	$AnimationPlayer.play_backwards("Fade")
