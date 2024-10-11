extends Node2D

@export var bird_scene: PackedScene

#const BIRD_SPRITE_SCALE = 0.25
const BIRD_SPRITE_SCALE = 0.5
const NUMBER_OF_BIRDS = 1

const MIN_BIRD_TIMING = 0
const MAX_BIRD_TIMING = 2

var birds: Array = []
var click_position = Vector2()
var next_bird_action_timing = randf_range(MIN_BIRD_TIMING, MAX_BIRD_TIMING)

var screenSize: Vector2 = DisplayServer.window_get_size()
#get_viewport().get_visible_rect().size

func get_random_position():
	return Vector2(randf_range(0, screenSize.x), randf_range(0, screenSize.y))

func spawn_bird(pos: Vector2 = get_random_position()):
	var bird = bird_scene.instantiate()
	bird.scale.x = BIRD_SPRITE_SCALE
	bird.scale.y = BIRD_SPRITE_SCALE
	bird.position = pos
	bird.rotation = randf_range(0, 2 * PI)
	birds.append(bird)
	add_child(bird)

# QUESTION: should this be in bird.gd?
# no, but the move command should be
func move_random_bird():
	# TODO: pick a random bird
	var bird_to_move = birds.pick_random()
	
	# TODO: tell that bird to move
	bird_to_move.move()
	
	# set when the next bird will move
	next_bird_action_timing = randf_range(MIN_BIRD_TIMING, MAX_BIRD_TIMING)

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in NUMBER_OF_BIRDS:
		spawn_bird()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("tap"):
		spawn_bird(get_global_mouse_position())

	next_bird_action_timing -= delta

	if next_bird_action_timing <= 0:
		move_random_bird()
