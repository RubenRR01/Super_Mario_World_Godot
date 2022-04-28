extends Position2D

onready var hammer_toad = preload("res://Assets/Character Assets/Hammer_Toad.tscn")
var list = ["Hammer_Toad", "enemy"]
var is_colliding = false
func _ready():
	set_physics_process(true)

	
func _physics_process(delta):

	var enemy = hammer_toad.instance()
	if get_child_count() >= 3 or is_colliding == true:
		return
	elif get_child_count() <= 3:
		add_child(enemy)
		enemy.position = get_parent().position



func _on_Area2D_body_entered(body):
	is_colliding = true


func _on_Area2D_body_exited(body):
	is_colliding = false
