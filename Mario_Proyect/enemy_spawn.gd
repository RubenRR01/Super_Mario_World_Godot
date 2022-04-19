extends Position2D

onready var hammer_toad = preload("res://Assets/Character Assets/Spawn_Hammer_Toad.tscn")
var list = ["Hammer_Toad", "enemy"]

func _ready():
	set_physics_process(true)

	
func _physics_process(delta):
	var root_position = get_position_in_parent()
	var enemy = hammer_toad.instance()
	if get_node("Spawn_Hammer_Toad") != null:
		return
	if get_parent().get_node("Spawn_Hammer_Toad") == null:
		get_parent().add_child(enemy)
		enemy.position = self.position

