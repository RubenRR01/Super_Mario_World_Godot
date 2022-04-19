extends StaticBody2D
onready var Used_Block = preload("res://Assets/Character Assets/Used_Block.tscn")
onready var Coin = preload("res://Assets/Character Assets/Coin.tscn")
signal finished
var coin_number = 0

func _physics_process(delta):
	if $RayCast2D.is_colliding():
		$AnimationPlayer.play("bote")  
		$AnimationPlayer.animation_set_next("bote", "bote2")
		print()

func _on_AnimationPlayer_animation_started(bote):
	pass
	

func _on_AnimationPlayer_animation_finished(bote2):
	var block = Used_Block.instance()
	if coin_number >= 2:
		get_parent().add_child(block)
		block.position = self.position
		queue_free()


func _on_AnimationPlayer_animation_changed(bote, bote2):
	
	if coin_number < 2:
		var coin = Coin.instance()
		get_parent().add_child(coin)	
		coin.position = self.position + Vector2(0, -8)
	coin_number += 1

	


func _on_Area2D_tree_entered():
	pass
