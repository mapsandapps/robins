extends CharacterBody2D

const SPEED = 0
const JUMP_VELOCITY = 0

const POSSIBLE_MOVES = ['hop', 'walk', 'turn']

# any of the possible bird movements
func move():
	# TODO: pick a movement
	var move = POSSIBLE_MOVES.pick_random()
	print(move)

	# TODO: move bird
	if move == 'hop':
		hop()
	elif move == 'walk':
		walk()
	elif move == 'turn':
		turn()

func hop():
	print('hop')

func walk():
	print('walk')

func turn():
	print('turn')

func _physics_process(delta):
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
