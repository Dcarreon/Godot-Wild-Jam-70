extends CharacterBody2D

signal possessed_hare()

@onready var sprite = $AnimatedSprite2D
@export var tortoise: CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _ready() -> void:
	tortoise.possessed_tortoise.connect(_unpossess)
	set_physics_process(false)

func _unpossess() -> void:
	set_physics_process(false)

func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("mouse_left"):
		possessed_hare.emit()
		set_physics_process(true)
		print("You clicked the Hare!")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if direction > 0:
		sprite.flip_h = false;
	elif direction < 0:
		sprite.flip_h = true;

	move_and_slide()
