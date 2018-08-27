extends Node



func _ready():
	#change_background()
	pass
	
func animate_background():
	$AnimationPlayer.play("flashRed")
	
	


func _on_MathDisplay_wrongAnswer():
	$AnimationPlayer.play("flashRed")
	
	
	

func _on_MathDisplay_correctAnswer():
	$AnimationPlayer.play("flashGreen")
	var point = $Node2D.get_global_mouse_position()
	var explosionScene = load("res://ExplodingChevrons.tscn")
	var node = explosionScene.instance()
	node.chevronColor = Color(0,1,0,1)
	node.transform.origin = point
	add_child(node)
