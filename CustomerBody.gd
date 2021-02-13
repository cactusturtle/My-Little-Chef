extends KinematicBody2D

enum states {WALK, ORDER}
var state = states.WALK
onready var ordered = false
var targets
var targets_dict = {}

# target id is an int so that iterating through the dictionary of 
# points will be easier 
onready var target_id = 0
var customer_target 


func _ready():
	# create dictionary to hold the targets for movement
	create_targets()
	# start the customer moving towards the first official point in the dictionary
	customer_target = targets_dict[target_id]["target"]
	move(customer_target)
	SignalManager.connect("ordering", self, "_on_ordering")
	SignalManager.connect("serve_customer", self, "_on_serve_customer")

func create_targets():
	targets = PoolVector2Array([
		Vector2(get_node("../EntryArea2D/CollisionShape2D").get_position()),
		Vector2(get_node("../TurnArea2D/CollisionShape2D").get_position()),
		Vector2(get_node("../OrderArea2D/CollisionShape2D").get_position())
	])
	print(targets)
	print(self.position)
	"""
	targets.append(get_node("../EntryArea2D").get_position())
	targets.append(get_node("../TurnArea2D").get_position())
	targets.append(get_node("../OrderArea2D").get_position())
	"""
	targets_dict[0] = {target = Vector2(get_node("../EntryArea2D/CollisionShape2D").get_position())}
	targets_dict[1] = {target = Vector2(get_node("../TurnArea2D/CollisionShape2D").get_position())}
	targets_dict[2] = {target = Vector2(get_node("../OrderArea2D/CollisionShape2D").get_position())}
	
	# check keys are integers
	for key in targets_dict.keys():
		print(typeof(key) == TYPE_INT)
	
	var id = 0
	print(targets_dict.has(id))

func move(target):
	var move_tween = get_node("CustomerTween")
	move_tween.interpolate_property(self, "position", position, Vector2(target), 3)
	move_tween.start()

func _physics_process(delta):
	choose_action()

func choose_action():
	if targets == null:
		return
	
	match state:
		
		states.WALK:
			$Sprite2.hide()
			#Customer leaving
			if ordered == true:
				# flip target order after cusotmer has ordered and been served
				if target_id == 2:
					target_id -= 1
					print("target_id : ", target_id)
					customer_target = targets_dict[target_id]["target"]
					move(customer_target)
				else:
					if self.position.distance_to(Vector2(customer_target)) < 5:
						target_id -= 1
						print("target_id : ", target_id)
						customer_target = targets_dict[target_id]["target"]
						move(customer_target)
			#customer walking towards cash register
			else:
				if self.position.distance_to(Vector2(customer_target)) < 5:
					if target_id < 2:
						target_id += 1
						print("target_id : ", target_id)
						customer_target = targets_dict[target_id]["target"]
						move(customer_target)
		
		states.ORDER:
			$AnimatedSprite.play("idle_toward")
			$Sprite2.show()
			var stop_tween = get_node("CustomerTween")
			stop_tween.stop_all()


#will cause cutomer to stop and wait for order to be fulfilled
func _on_ordering():
	state = states.ORDER
	ordered = true


#will start customer to leave
func _on_serve_customer():
	state = states.WALK
