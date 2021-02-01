extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#onready var item_id = Global.new_inst._dict["basic_dough"]
onready var item_id = "basic_dough"

# Called when the node enters the scene tree for the first time.
func _ready():
	self.hide()

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
		if get_parent().workspaces[1] == "full":
			if Player.player_inventory._dict.empty():
				SignalManager.emit_signal("pick_up", item_id)
				_empty_workspace()
			else:
				print("you can't pick anyting else up")
		elif get_parent().workspaces[1] == "empty":
			if Player.player_inventory._dict.has("basic_dough"):
				SignalManager.emit_signal("put_down")
				print("WORKSPACE TWO EMITTING SIGNAL PUT DOWN")
				_fill_workspace()
			else:
				print("You can't put that down here")
		else:
			pass


func _process(delta):
	get_input()


func _fill_workspace():
	self.show()
	get_parent().workspaces[1] = "full"


func _empty_workspace():
	self.hide()
	get_parent().workspaces[1] = "empty"
