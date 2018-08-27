extends Node2D

export (Color) var chevronColor

func _ready():
	$ChevronPolygon1.color = chevronColor
	$ChevronPolygon2.color = chevronColor
	$ChevronPolygon3.color = chevronColor
	$ChevronPolygon4.color = chevronColor
	$AnimationPlayer.play("explode")
	$Particles2D.restart()

func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
	

