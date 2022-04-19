extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _enter_tree():
	$AnimationPlayer.play("jump")
	


func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free() # Replace with function body.
