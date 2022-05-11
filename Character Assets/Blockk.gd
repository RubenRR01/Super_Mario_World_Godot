extends StaticBody2D
onready var Used_Block = preload("res://Assets/Character Assets/Used_Block.tscn")
onready var Coin = preload("res://Assets/Character Assets/Coin.tscn")
signal finished
var coin_number = 0
var play_animation = false
func _physics_process(delta):
	if play_animation == true:
		$AnimationPlayer.play("bote")  
		$AnimationPlayer.animation_set_next("bote", "bote2")
func _on_Area2D_body_entered(body):
	play_animation = true
	
	

func _on_Area2D_body_exited(body):
	play_animation = false
	
func _on_AnimationPlayer_animation_started(bote):
	pass
	

func _on_AnimationPlayer_animation_finished(bote2):
	var block = Used_Block.instance()
	if coin_number >= 1:
		get_parent().add_child(block)
		block.position = self.position
		queue_free()


func _on_AnimationPlayer_animation_changed(bote, bote2):
	
	if coin_number < 1:
		var coin = Coin.instance()
		add_child(coin)	
		coin.position = get_parent().position + Vector2(0, -8)
	coin_number += 1

	


func _on_Area2D_tree_entered():
	pass





