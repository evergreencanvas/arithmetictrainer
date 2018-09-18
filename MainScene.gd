extends Node

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	var stage1 = load("res://stages/stage1/Stage1.tscn")
	var node = stage1.instance()
	add_child(node)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
