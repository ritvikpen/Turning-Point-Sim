extends Sprite

var shooting = false
var shooting_dir = Vector2()

func _ready():
	hide()

func _process(delta):
	if Input.is_action_just_pressed("ui_shoot"):
		shooting = true
		position = get_node("/root/GameScene/B_bot").position
		shooting_dir = Vector2(10,-10).rotated(get_node("/root/GameScene/B_bot").rotation + 0.8)
	if get_node("/root/GameScene/Shoot Button").is_pressed():
		shooting = true
		position = get_node("/root/GameScene/B_bot").position
		shooting_dir = Vector2(10,-10).rotated(get_node("/root/GameScene/B_bot").rotation + 0.8)
		print('shoot_ball();')
	if shooting:
		show()
		position.y += shooting_dir.y
		position.x += shooting_dir.x
