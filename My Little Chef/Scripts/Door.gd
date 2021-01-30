extends Area2D

signal player_leaving(string)

export var going_to = ""
#var my_name = ""
export (int) var my_id

# Called when the node enters the scene tree for the first time.
func _ready():
	$DoorClosed/DoorOpen.hide()
	#add_to_group("doors")
	#my_name = [str(self.name)]

###TESTING
func get_input():
	# check if player is overlapping area
	var bodies = get_overlapping_bodies()
	var player_is_in = false
	# check if user is pressing e whle overlapping area if true emit signal to 
	# change the sprite appearance
	for bod in bodies:
		if bod.is_in_group("player"):
			player_is_in = true
			break
	if player_is_in and Input.is_action_just_released("exit"):
		send_door_signal()


func _process(delta):
	get_input()
###TESTING


func _on_Door_body_shape_entered(body_id, body, body_shape, area_shape):
	print("We intersected, ", self.name, body)
	$AnimatedSprite.play()


func _on_Door_body_shape_exited(body_id, body, body_shape, area_shape):
	print("We stopped intersecting, ", self.name, body)
	$AnimatedSprite.stop()


func send_door_signal():
	print("sending send_door_signal from  intersected door  :  ", self.name)
	var my_name = [str(self.name)]
	emit_signal("player_leaving", my_name)

###TESTING
func _on_Door_body_entered(body):
	return true # Replace with function body.
