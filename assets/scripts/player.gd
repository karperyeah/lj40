extends KinematicBody2D

onready var sprite = $Sprite
onready var animation_player = $AnimationPlayer

export var gravity = 640.0

export var speed = 150.0
export var acceleration = 800.0
export var deacceleration = 700.0

export var jump_velocity = 275.0

var direction = 0.0
var velocity = Vector2()


func _gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

func _movement(delta: float) -> void:
	if direction:
		velocity.x = move_toward(velocity.x, direction * speed, acceleration * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, deacceleration * delta)
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	
func _jump(delta: float) -> void:
	if Input.is_action_pressed("action") and is_on_floor():
		velocity.y = -jump_velocity
		animation_player.play("Jump")


func _animation(direction: float) -> void:
	if direction:
		sprite.flip_h = direction < 0

	if velocity.y > 0:
		animation_player.play("Fall")

	if velocity.x == 0 and velocity.y == 0:
		animation_player.play("Idle")
	
	if velocity.x != 0 and is_on_floor():
		animation_player.play("Run")


func _process(delta) -> void:
	direction = Input.get_axis("left", "right")
	
	_animation(direction)
	_jump(delta)
	

func _physics_process(delta: float) -> void:
	_gravity(delta)
	_movement(delta)
