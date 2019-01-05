extends KinematicBody2D

func _ready():
	pass

# movement related vars
var speed = 5
var rotation_speed = 1.5
var velocity = Vector2()
var rotation_dir = 0

# timer (diff start and end vars for each dir)
var time_start_r
var time_start_l
var time_start_u
var time_start_d
var time_end_r
var time_end_l
var time_end_u
var time_end_d
var time_elapsed_r
var time_elapsed_l
var time_elapsed_u
var time_elapsed_d

signal flip_cap

func get_input():
	
	# init movement vars
	rotation_dir = 0
	velocity = Vector2()
	
	"""
	code is replicated for each input direction; structure is:
	start timer -> adjust movement vars -> end timer -> print code 
	"""
	if Input.is_action_just_pressed('ui_right'):
		time_start_r = OS.get_unix_time()
	if Input.is_action_pressed('ui_right'):
		rotation_dir += 1
	if Input.is_action_just_released('ui_right'):
		time_end_r = OS.get_unix_time()
		time_elapsed_r = time_end_r - time_start_r
		print("base_rot_right(" + str(time_elapsed_r) + ");")
	
	if Input.is_action_just_pressed('ui_left'):
		time_start_l = OS.get_unix_time()
	if Input.is_action_pressed('ui_left'):
		rotation_dir -= 1
	if Input.is_action_just_released('ui_left'):
		time_end_l = OS.get_unix_time()
		time_elapsed_l = time_end_l - time_start_l
		print("base_rot_left(" + str(time_elapsed_l) + ");")
	
	if Input.is_action_just_pressed('ui_down'):
		time_start_d = OS.get_unix_time()
	if Input.is_action_pressed('ui_down'):
		velocity = Vector2(-speed, 0).rotated(rotation)
	if Input.is_action_just_released('ui_down'):
		time_end_d = OS.get_unix_time()
		time_elapsed_d = time_end_d - time_start_d
		print("base_backwards(" + str(time_elapsed_d) + ");")
		
	if Input.is_action_just_pressed('ui_up'):
		time_start_u = OS.get_unix_time()
	if Input.is_action_pressed('ui_up'):
		velocity = Vector2(speed, 0).rotated(rotation)
	if Input.is_action_just_released('ui_up'):
		time_end_u = OS.get_unix_time()
		time_elapsed_u = time_end_u - time_start_u
		print("base_forward(" + str(time_elapsed_u) + ");")
	
	"""
	non movement inputs: shooting and flipping                   
	no timers used here as motors should rotate constant amounts
	""" 
	if Input.is_action_just_pressed('ui_accept'):
		print('flip_cap();')
		emit_signal('flip_cap')
	
	if Input.is_action_just_pressed('ui_shoot'):
		print('shoot_ball();')
	
	if get_node("/root/GameScene/Up Button").is_pressed():
		velocity = Vector2(speed, 0).rotated(rotation)
		print('base_forward();')
	if get_node("/root/GameScene/Down Button").is_pressed():
		velocity = Vector2(-speed, 0).rotated(rotation)
		print('base_backwards()')
	if get_node("/root/GameScene/Left Button").is_pressed():
		rotation_dir -= 1
		print('base_rot_left();')
	if get_node("/root/GameScene/Right Button").is_pressed():
		rotation_dir += 1
		print('base_rot_right()')
	if get_node("/root/GameScene/Flip Button").is_pressed():
		emit_signal('flip_cap')
		print('flip_cap()')

func _physics_process(delta):
	get_input()
	rotation += rotation_dir * rotation_speed * delta
	move_and_collide(velocity)
