extends Node2D

var flipped = false
var entered = false

func _ready():
	get_node("Red Cap").hide()
	pass

func _on_B_bot_flip_cap():
	if not flipped:
		get_node("Blue Cap").hide()
		get_node("Red Cap").show()
		flipped = true
	else:
		get_node("Red Cap").hide()
		get_node("Blue Cap").show()
		flipped = false

func _on_Area2D_body_entered(body):
	pass # replace with function body
