extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func get_input():
	var bodies = get_overlapping_bodies()
	var player_is_in_km = false
	
	for bod in bodies:
		if bod.is_in_group("player"):
			player_is_in_km = true
			break
	
	if player_is_in_km and Input.is_action_just_pressed("exit"):
		print("player attempting interaction")
		print(Player.player_inventory._dict)
		if Player.player_inventory._dict.has("raw_ingredients"):
			if get_parent().workspaces[0] == "empty":
				get_parent().get_node("WorkspaceOne")._fill_workspace()
				SignalManager.emit_signal("put_down")
			elif get_parent().workspaces[1] == "empty":
				get_parent().get_node("WorkspaceTwo")._fill_workspace()
				SignalManager.emit_signal("put_down")
			else:
				print("can't prep anything else")
		else:
			print("no interactions available")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_input()


func _on_KitchenMixer_body_entered(body):
	pass # Replace with function body.
