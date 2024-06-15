extends KinematicBody2D

onready var sprite = $Sprite
onready var animation_player = $AnimationPlayer
onready var hat_sprite = get_node("Sprite/HatPosition/").get_child(0)

onready var coyote_time = $CoyoteTime

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
	if Input.is_action_pressed("action"):
		if is_on_floor() or coyote_time.time_left > 0.0:
			velocity.y = -jump_velocity
			coyote_time.stop()
			
			animation_player.play("Jump")
			$JumpSound.pitch_scale = rand_range(0.7, 1.3)
			$JumpSound.play()


func _coyote_time(was_on_floor: bool) -> void:
	if was_on_floor and not is_on_floor() and velocity.y >= 0.0:
		coyote_time.start()


func _animation(direction: float) -> void:
	if direction:
		sprite.flip_h = direction < 0
		hat_sprite.scale.x = direction

	if velocity.y > 0:
		animation_player.play("Fall")

	if velocity.x == 0 and velocity.y == 0:
		animation_player.play("Idle")
	
	if velocity.x != 0 and is_on_floor():
		animation_player.play("Run")


func _process(delta: float) -> void:
	direction = Input.get_axis("left", "right")
	
	_animation(direction)
	_jump(delta)


func _physics_process(delta: float) -> void:
	var was_on_floor = is_on_floor()
	
	_gravity(delta)
	_movement(delta)
	
	_coyote_time(was_on_floor)
	print(coyote_time.time_left)
