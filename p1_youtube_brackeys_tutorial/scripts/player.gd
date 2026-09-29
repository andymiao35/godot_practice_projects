extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var coyote_timer: Timer = $CoyoteTimer
@onready var jump_sound_effect: AudioStreamPlayer2D = $JumpSoundEffect


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Section: Handle jump
	if Input.is_action_just_pressed("jump") and (is_on_floor() or not coyote_timer.is_stopped()):
		velocity.y = JUMP_VELOCITY
		jump_sound_effect.play()



	# Section: Handle sprite direction
	# Get the input direction: -1, 0, 1
	var direction := Input.get_axis("move_left", "move_right")
	
	if direction == 1:
		animated_sprite_2d.flip_h = false
	elif direction == -1:
		animated_sprite_2d.flip_h = true
	
	
	
	
	# Section: Handle animation
	if  is_on_floor():
		if direction == 0:
			animated_sprite_2d.play("idle")
		else:
			animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("jumping")
	
		
	# Section: Handle movement
	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)


	var was_on_floor = is_on_floor()
	move_and_slide()
	
	if was_on_floor and not is_on_floor() and velocity.y >= 0:
		coyote_timer.start()
	
