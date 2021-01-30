extends Node2D


"""

onready var display_rack = ["empty", "empty"]


# Called when the node enters the scene tree for the first time.
func _ready():
	$FilledDisplayLeft.hide()
	$FilledDisplayRight.hide()


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
		if display_rack[0] == "empty" and (Player.in_hands.has("res://Assets/Art/icons/bakedbread.png")):
			emit_signal("put_down")
			print("DISPLAY EMITTING SIGNAL PUT DOWN")
			_fill_display($FilledDisplayLeft, display_rack[0])
		elif display_rack[1] == "empty" and (Player.in_hands.has("res://Assets/Art/icons/bakedbread.png")):
			emit_signal("put_down")
			print("OVEN EMITTING SIGNAL PUT DOWN")
			_fill_display($FilledDisplayRight, display_rack[1])
		elif display_rack[0] == "full" or display_rack[1] == "full" and !Player.hands_full:
			emit_signal("pick_up", "item_003")
			_empty_display()
		else:
			print("you can't put anything else in the DISPLAY right now")
	
	if display_rack[0] == "empty":
		$FilledDisplayLeft.hide()
	if display_rack[1] == "empty":
		$FilledDisplayRight.hide()
	if display_rack[0] == "full":
		$FilledDisplayLeft.show()
	if display_rack[1] == "full":
		$FilledDisplayRight.show()



func _process(delta):
	get_input()

func _fill_display(display, rack):
	display.show()
	rack = "full"


func _empty_display():
	$FilledDisplayLeft.hide()
	$FilledDisplayRight.hide()
	
	display_rack = ["empty", "empty"]
"""
