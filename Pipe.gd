extends Area2D

export var next_scene : PackedScene
onready var player = get_node("Bowser")

func _on_Bowser_se_acabo():
	if get_overlapping_bodies():
			teleport()


func teleport():
	get_tree().change_scene_to(next_scene)



