extends KinematicBody2D


export var speed = 100
var screen_size
var velocity = Vector2()
var UseSpriteHere
var HiddenSpriteHere
onready var player_is_sitting = false
var is_chef = Player.is_chef
# Called when the node enters the scene tree for the first time.


func _ready():
	screen_size = get_viewport_rect().size
	
	if is_chef == false:
			UseSpriteHere = $PlainSprite
			HiddenSpriteHere = $ChefSprite
	elif is_chef == true:
		UseSpriteHere = $ChefSprite
		HiddenSpriteHere = $PlainSprite
	
	UseSpriteHere.show()
	UseSpriteHere.play("idle_toward")
	HiddenSpriteHere.hide()
	
	### Connect to chair objects to enable sitting
	for chair in get_tree().get_nodes_in_group("chairs"):
		var _sit_chair = chair.connect("player_sitting", self, "_my_on_player_sitting")
		var _getup_chair = chair.connect("player_not_sitting", self, "_my_on_player_not_sitting")
	
	for wardrobes in get_tree().get_nodes_in_group("wardrobe"):
		SignalManager.connect("change_player_sprite", self, "_on_change_sprite")


func _on_change_sprite():
	print("playermovement is receiving wardrobe signal")
	if is_chef == false:
		UseSpriteHere = $ChefSprite
		UseSpriteHere.show()
		HiddenSpriteHere = $PlainSprite
		HiddenSpriteHere.hide()
		is_chef = true
		return is_chef
	elif is_chef == true:
		UseSpriteHere = $PlainSprite
		UseSpriteHere.show()
		HiddenSpriteHere = $ChefSprite
		HiddenSpriteHere.hide()
		is_chef = false
		return is_chef



# Sit in chair
func _my_on_player_sitting():
	print("RECEIVED SIGNAL _my_on_player_sitting()")
	self.hide()
	print("player_is_sitting : ", player_is_sitting)


#Get up from Chair
func _my_on_player_not_sitting():
	print("RECEIVED SIGNAL _my_on_player_not_sitting")
	self.show()


func start(pos):
	#position = Player.player_position
	show()


func get_input():
	
	# set velocity
	velocity = Vector2()
	#get input if user wants to run
	if Input.is_action_pressed("run"):
		speed = 200
	if Input.is_action_just_released("run"):
		speed = 100
	
	# Detect direction input from player and play corresponding animation
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
		if speed == 200:
			UseSpriteHere.play("run_right")
		else:
			UseSpriteHere.play("walk_right")
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1
		if speed == 200:
			UseSpriteHere.play("run_left")
		else:
			UseSpriteHere.play("walk_left")
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
		if speed == 200:
			UseSpriteHere.play("run_toward")
		else:
			UseSpriteHere.play("walk_toward")
	if Input.is_action_pressed('ui_up'):
		velocity.y -= 1
		if speed == 200:
			UseSpriteHere.play("run_away")
		else:
			UseSpriteHere.play("walk_away")
		
	# Detect released key to idle in direction of last released key
	if Input.is_action_just_released("ui_right"):
		UseSpriteHere.play("idle_right")
	if Input.is_action_just_released("ui_left"):
		UseSpriteHere.play("idle_left")
	if Input.is_action_just_released("ui_down"):
		UseSpriteHere.play("idle_toward")
	if Input.is_action_just_released("ui_up"):
		UseSpriteHere.play("idle_away")
	velocity = velocity.normalized() * speed
	
	
	
	var player_hands = Player.hands_full
	if player_hands == true:
		$Holding.texture = load(Player.holding)
		$Holding.show()
	elif player_hands == false:
		$Holding.hide()



func _physics_process(delta):
	# Move Player around
	get_input()
	move_and_collide(velocity * delta)
	
	#cannot walk off screen
	position.x = clamp(position.x, 0, screen_size.x) 
	position.y = clamp(position.y, 0, screen_size.y)
