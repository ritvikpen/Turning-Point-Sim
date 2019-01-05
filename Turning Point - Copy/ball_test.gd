extends KinematicBody2D

var speed = 5
var rotation_speed = 1.5
var velocity = Vector2()
var rotation_dir = 0

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func get_input():
	
	rotation_dir = 0
	velocity = Vector2()
	
	if Input.is_action_pressed('ui_right'):
		rotation_dir += 1
	
	if Input.is_action_pressed('ui_left'):
		rotation_dir -= 1
	
	if Input.is_action_pressed('ui_down'):
		velocity = Vector2(-speed, 0).rotated(rotation)
	
	if Input.is_action_pressed('ui_up'):
		velocity = Vector2(speed, 0).rotated(rotation)

func _process(delta):
	get_input()
	position = get_node("/root/GameScene/B_bot").position
