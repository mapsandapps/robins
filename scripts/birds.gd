extends Node2D

@export var bird_scene: PackedScene

var birds: Array = []
var click_position = Vector2()

var screenSize: Vector2 = DisplayServer.window_get_size()
#get_viewport().get_visible_rect().size

func get_random_position():
	return Vector2(randf_range(0, screenSize.x), randf_range(0, screenSize.y))

func spawn_bird(pos: Vector2 = get_random_position()):
	var bird = bird_scene.instantiate()
	bird.position = pos
	bird.rotation = randf_range(0, 2 * PI)
	birds.append(bird)
	add_child(bird)

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in 10:
		spawn_bird()
	#birds = get_children()
	#for i in birds.size():
		#birds[i].position = Vector2(randf_range(0, screenSize.x), randf_range(0, screenSize.y))
		#
		#birds[i].rotation = randf_range(0, 2 * PI)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("tap"):
		spawn_bird(get_global_mouse_position())
		
