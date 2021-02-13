extends Node2D


onready var the_player = preload("res://Player/PlayerCharacter.tscn")
onready var the_customer = preload("res://Assets/Art/SpriteSheets/objects/Customer.tscn")

onready var served_customer = false
onready var customer_called = false
var customer_
# for randomizing wait time of timer
var rng = RandomNumberGenerator.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	print("This is", self.name) # Replace with function body.
	
	var player_ = the_player.instance()
	add_child(player_)
	
	#set the instanced player scene to tbe same position as the bed
	player_.position = Vector2(470, 100)
	
	SignalManager.connect("serve_customer", self, "_on_customer_served_")
	
	
	#customer_ = the_customer.instance()
	check_for_customer()
	print(customer_called)
	print(!customer_called)


func _physics_process(delta):
	
	if !customer_called:
		if !check_for_customer():
			customer_called = true
			$WaitForCustomerTimer.wait_time = rng.randi_range(1, 10)
			$WaitForCustomerTimer.start()
	else:
		pass




func check_for_customer():
	if !has_node("Customer"):
		print("no has customer")
		return false
	else:
		print("has customer")
		return true


func add_customer():
	customer_ = the_customer.instance()
	add_child(customer_)
	#add_child(customer_)
	#customer_.position = Vector2(180, 350)
	#var patrol_points = get_node("Path2D").curve.get_baked_points()
	#customer_.position = Vector2(192,432)
	print("ATTEMPTED TO ADD CUSTOMER TO SCENE")


func remove_customer():
	remove_child(customer_)
	served_customer = false
	customer_called = false


func _on_WaitForCustomerTimer_timeout():
	$WaitForCustomerTimer.stop()
	add_customer()


func _on_customer_served_():
	served_customer = true


func _on_EntryArea2D_body_entered(body):
	if body == customer_ and served_customer == true:
		remove_customer()
	else:
		pass


func _on_OrderArea2D_body_entered(body):
	if body == customer_:
		SignalManager.emit_signal("ordering")
