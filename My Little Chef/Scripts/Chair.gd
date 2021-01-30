extends Area2D

signal player_sitting
signal player_not_sitting


onready var is_sitting = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sitting.hide()
	#testing
	print("1. is_sitting  ", is_sitting)

func get_input():
	var bodies = get_overlapping_bodies()
	var player_is_in = false
	# check if user is pressing e whle overlapping area if true emit signal to 
	# change the sprite appearance
	for bod in bodies:
		if bod.is_in_group("player"):
			player_is_in = true
			break
	if player_is_in and Input.is_action_just_pressed("exit"):
		if !is_sitting:
			sit_down(is_sitting)
			#testing
			print("2. is_sitting  ", is_sitting)
		else:
			pass
	else:
		pass




func _process(delta):
	get_input()


func change_sitting(is_sit):
	#testing
	print("3. is_sitting  ", is_sitting)
	if is_sit:
		#testing
		print("4. is_sitting  ", is_sitting)
		get_up(is_sit)
		#testing
		print("5. is_sitting  ", is_sitting)
	elif !is_sit:
		#testing
		print("6. is_sitting  ", is_sitting)
		sit_down(is_sit)
		#testing
		print("7. is_sitting  ", is_sitting)


func get_up(is_sit):
	#testing
	print("8. is_sitting  ", is_sitting)
	$Sitting.stop()
	$Sitting.hide()
	emit_signal("player_not_sitting")
	is_sitting = false
	#return is_sitting

func sit_down(is_sit):
	#testing
	print("9. is_sitting  ", is_sitting)
	$Sitting.show()
	$Sitting.play()
	emit_signal("player_sitting")
	is_sitting = true
	#return is_sitting


func _on_Chair_body_exited(body):
	#testing
	print("10. is_sitting  ", is_sitting)
	if is_sitting:
		get_up(is_sitting)
		#change_sitting(is_sitting)
		#testing
		print("11. is_sitting  ", is_sitting)
