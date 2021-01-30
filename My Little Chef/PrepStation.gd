extends Node2D


var workspaces = ["empty", "empty"]
var interacting = false

# Dictionary to track what is on the prepstation
var workspaces_dict = {
	workspace_one = {
		"fill" : "empty",
		"holding" : null
	},
	workspace_two = {
		"fill" : "empty",
		"holding" : null
	}
}
# Called when the node enters the scene tree for the first time.
func _ready():
	print(workspaces)
	#$Table/Space1.hide()
	#$Table/Space2.hide()

func get_input():
	if Input.is_action_just_pressed("exit"):
		interacting = true


func _process(delta):
	get_input()

func _on_WorkspaceTwo_body_entered(body):
	print("Workspace Two Entered")
	



