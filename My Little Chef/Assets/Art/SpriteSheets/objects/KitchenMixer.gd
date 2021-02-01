extends Area2D


onready var workspace_location_one = get_parent().workspaces[0]
onready var workspace_name_one = get_parent().get_node("WorkspaceOne")

onready var workspace_location_two = get_parent().workspaces[1]
onready var workspace_name_two = get_parent().get_node("WorkspaceTwo")

#onready var player_is_in_km = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$KitchenMixerAnimated/Particles2D.hide()
	

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
			# Check array "workspaces" 
			if get_parent().workspaces.has("empty"):
				# TIMER HERE : PLAY ANIMATION EMIT PARTICLES THEN FILL WORKSPACE
				start_mixer()
				print("there's an empty space")
			else:
				print("can't prep anything else")
		else:
			print("no interactions available")
	else:
		pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_input()


func start_mixer():
	SignalManager.emit_signal("put_down")
	$KitchenMixerTimer.start()
	$KitchenMixerAnimated.play()
	$KitchenMixerAnimated/Particles2D.show()


func fill_(a):
	
	if a == 0:
		workspace_name_one._fill_workspace()
	if a == 1:
		workspace_name_two._fill_workspace()
	else:
		print("error", a)




func _on_KitchenMixer_body_entered(body):
	#if body.is_in_group("player"):
		#player_is_in_km = true
	pass


func _on_KitchenMixerTimer_timeout():
	print("Kitchen Timer TIMEOUT")
	$KitchenMixerTimer.stop()
	$KitchenMixerAnimated.stop()
	$KitchenMixerAnimated/Particles2D.hide()
	var x = get_parent().workspaces.find("empty")
	fill_(x)

func _on_KitchenMixer_body_exited(body):
	#if body.is_in_group("player"):
		#player_is_in_km = false
		pass
