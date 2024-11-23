extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
const SPEED = 100.0
const JUMP_VELOCITY = -250.0

# Add this variable to track last direction
var facing_left: bool = false

func _ready() -> void:
	print("Player: Starting setup...")
	add_to_group("player")
	print("Player: Added to group 'player'")
	print("Player: Current groups: ", get_groups())
	print("Player: Position: ", global_position)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		# Update facing direction only when actually moving
		facing_left = (direction < 0)
		animated_sprite.flip_h = facing_left
		velocity.x = direction * SPEED
	else:
		# When stopping, keep the last facing direction
		animated_sprite.flip_h = facing_left
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
