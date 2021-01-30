extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func get_input():
	if Input.is_key_pressed(KEY_0):
		SignalManager.emit_signal("test_signal_one")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_input()
