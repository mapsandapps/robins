extends CharacterBody2D

const SPEED = 0
const JUMP_VELOCITY = 0
const MIN_ROTATION = 0.1 # radians
const MAX_ROTATION = 1 # radians
const ROTATION_SPEED = 2 # radians / second

#const POSSIBLE_MOVES = ['hop', 'walk', 'turn']
const POSSIBLE_MOVES = ['turn']

var current_move: String = ''
var remaining_move_duration = 0 # seconds
var turn_direction = 1 # 1 or -1

func get_is_moving():
	return remaining_move_duration > 0

func on_move_ended():
	remaining_move_duration = 0
	current_move = ''

# any of the possible bird movements
func move():
	print(remaining_move_duration)
	# if the bird is already moving, don't move it
	if get_is_moving():
		print('tried to move but was already moving')
		return
	
	# TODO: pick a movement
	current_move = POSSIBLE_MOVES.pick_random()
	print(current_move)

	# TODO: move bird
	if current_move == 'hop':
		hop()
	elif current_move == 'walk':
		walk()
	elif current_move == 'turn':
		begin_turn()

func hop():
	print('hop')

func walk():
	print('walk')

func begin_turn():
	# set the move duration, then delta will handle rotating for that amount of time
	var rotation_radians = randf_range(MIN_ROTATION, MAX_ROTATION)

	remaining_move_duration = rotation_radians / ROTATION_SPEED

	turn_direction = [-1, 1].pick_random()

	print("bird will turn ", rotation_radians * turn_direction, " radians")

func _physics_process(delta):
	if remaining_move_duration <= 0:
		on_move_ended()
		return

	if current_move == 'turn':
		self.rotate(turn_direction * delta * ROTATION_SPEED)

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

	remaining_move_duration -= delta
