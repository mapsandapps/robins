extends CharacterBody2D

const SPEED = 0
const JUMP_VELOCITY = 0
const MIN_ROTATION = -1 # radians
const MAX_ROTATION = 1

#const POSSIBLE_MOVES = ['hop', 'walk', 'turn']
const POSSIBLE_MOVES = ['turn']

var remaining_move_duration = 0 # seconds
#var is_moving = remaining_move_duration > 0

func get_is_moving():
	return remaining_move_duration > 0

# any of the possible bird movements
func move():
	print(remaining_move_duration)
	# if the bird is already moving, don't move it
	if get_is_moving():
		print('tried to move but was already moving')
		return
	
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
	# TODO: animate
	
	# TODO: set this correctly
	remaining_move_duration = 1

	self.rotate(randf_range(MIN_ROTATION, MAX_ROTATION))

func _process(delta):
	remaining_move_duration = max(0, remaining_move_duration - delta)

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
