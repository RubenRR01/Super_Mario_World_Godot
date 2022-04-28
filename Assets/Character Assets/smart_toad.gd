extends KinematicBody2D


var speed = 50
var direction = -1
var motion : Vector2
var gravity = 50


func _physics_process(delta):
	$RayCast2D.position.x = $CollisionShape2D.shape.get_extents().x * direction
	if is_on_wall() or not $RayCast2D.is_colliding() and is_on_floor():
		direction = direction * -1
	motion.x = speed * direction
	motion.y = gravity
	
	motion = move_and_slide(motion, Vector2.UP)




func _on_Area2D_body_entered(body):
	$CollisionShape2D.queue_free()
	$Area2D/CollisionShape2D.queue_free()
	set_physics_process(false)
	$AnimatedSprite.play("die")
	



func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.get_animation() == "die":
		queue_free()
