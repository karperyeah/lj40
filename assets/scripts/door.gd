extends Area2D

signal door_activated
var is_player_inside_door : bool = false

func _ready():
	$AnimationPlayer.play("Idle")
	
func _process(delta):
	if is_player_inside_door and Input.is_action_just_pressed("action"):
		$AnimationPlayer.play("Close")
		emit_signal("door_activated")

func _on_Door_area_entered(area):
	if area.is_in_group("Player"):
		is_player_inside_door = true
	$AnimationPlayer.play("Open")

func _on_Door_area_exited(area):
	if area.is_in_group("Player"):
		is_player_inside_door = false
	$AnimationPlayer.play("Close")
