extends Node2D

onready var tilemap = $Interactive

const BLOCK = preload("res://Assets/Character Assets/StaticBody2D.tscn") 
const Mushroom_Block = preload("res://Assets/Character Assets/Mushroom_Block.tscn")

func _ready():
	print(tilemap.get_used_cells_by_id(0))
	for cellpos in tilemap.get_used_cells_by_id(0):
		var cell = tilemap.get_cellv(cellpos)
		if cell == 0:
			var object = BLOCK.instance()
			object.position = tilemap.map_to_world(cellpos)
			add_child(object)
			tilemap.set_cellv(cellpos, -1)
	
	for cellpos in tilemap.get_used_cells_by_id(1):
		var cell = tilemap.get_cellv(cellpos)
		if cell == 0:
			var object = BLOCK.instance()
			object.position = tilemap.map_to_world(cellpos)
			add_child(object)
			tilemap.set_cellv(cellpos, -1)


func _on_Bowser_pausar():
	get_tree().set_pause(true)
