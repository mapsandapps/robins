extends CharacterBody2D

# TODO: remove these
const SPEED = 0
const JUMP_VELOCITY = 0

# turn
const MIN_ROTATION = 0.1 # radians
const MAX_ROTATION = 1 # radians
const ROTATION_SPEED = 2 # radians / second

# walk
const MIN_WALK_DISTANCE = 10
const MAX_WALK_DISTANCE = 100
const WALK_SPEED = 100 # all robins walk at the same pace

#const POSSIBLE_MOVES = ['hop', 'walk', 'turn']
const POSSIBLE_MOVES = ['turn', 'walk']

var current_move: String = ''
var remaining_move_duration = 0 # seconds
var turn_direction = 1 # 1 or -1

func get_is_moving():
	return remaining_move_duration > 0

func on_move_ended():
	remaining_move_duration = 0
	current_move = ''
	velocity.x = 0
	velocity.y = 0

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
		begin_walk()
	elif current_move == 'turn':
		begin_turn()

func hop():
	print('hop')

func begin_turn():
	# set the move duration, then delta will handle rotating for that amount of time
	var rotation_radians = randf_range(MIN_ROTATION, MAX_ROTATION)

	remaining_move_duration = rotation_radians / ROTATION_SPEED

	turn_direction = [-1, 1].pick_random()

	print("bird will turn ", rotation_radians * turn_direction, " radians")

func begin_walk():
	# set the walk duration, then delta will handle rotating for that amount of time
	var walk_distance = randf_range(MIN_WALK_DISTANCE, MAX_WALK_DISTANCE)

	remaining_move_duration = walk_distance / WALK_SPEED

	print("bird will walk ", walk_distance, " units of distance")

func _physics_process(delta):
	if remaining_move_duration <= 0:
		on_move_ended()
		return

	if current_move == 'turn':
		self.rotate(turn_direction * delta * ROTATION_SPEED)

	if current_move == 'walk':
		velocity.x = cos(rotation - PI / 2) * WALK_SPEED
		velocity.y = sin(rotation - PI / 2) * WALK_SPEED

	move_and_slide()

	remaining_move_duration -= delta
