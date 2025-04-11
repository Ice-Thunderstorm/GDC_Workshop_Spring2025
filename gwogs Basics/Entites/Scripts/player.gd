extends CharacterBody2D

# When you put export before a var it apears on the side to edit ->
@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0

# A point tracker
var points = 0

# Sometimes a game is too percise, this var allows a slight delay after a 
# player leaves an edge to still jump
var coyote_jummp:bool = true 

# The function that is called every game tic
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Coyote jump logic
	if !is_on_floor() and coyote_jummp and $JumpTimer.is_stopped():
		$JumpTimer.start()
	elif is_on_floor() and !coyote_jummp:
		coyote_jummp = true

	#Handle Down Movement
	if Input.is_action_just_pressed("Down"):
		# In games, +y is down and -y is up, I have no idea why
		position.y += 1
		coyote_jummp = false

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and coyote_jummp:
			velocity.y = JUMP_VELOCITY
			coyote_jummp = false

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	# The Animation we function made
	animation()
	move_and_slide()

# This function sets what animations our character plays depedning on what they do
func animation():
	# Checks if player is moving by comparing the player's velocity vector to the zero vector
	if velocity == Vector2.ZERO:
		$AnimatedSprite2D.play("default")
		return
	
	# Set the direction the player is moving
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
	elif velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
	
	# Checks if playet is falling/Jumping
	if abs(velocity.y) > 0:
		if $AnimatedSprite2D.animation != "jump":
			$AnimatedSprite2D.play("jump")
	elif $AnimatedSprite2D.animation != "Walk":
		$AnimatedSprite2D.play("Walk")



func _on_jump_timer_timeout() -> void:
	# When timer runs out coyote jump is no longer possible
	coyote_jummp=false


func _on_detector_area_entered(area: Area2D) -> void:
	pass # Replace with function body.
