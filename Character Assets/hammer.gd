extends KinematicBody2D
var velocity := Vector2.ZERO
var speed = 100
var direction = 1
var wtf
var jump_height : float = 100
var jump_time_to_peak : float = 0.5
var jump_time_to_descent : float = 1.0

var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

func _physics_process(delta):
	velocity.x = speed * direction
	velocity.y += get_gravity() * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	velocity = move_and_slide(velocity, Vector2.UP)
	if position.y >= 1000:
		queue_free()
	
func _enter_tree():
	$Area2D/AnimationPlayer.play("rotate")
	jump()
		
func get_gravity() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity

func jump():
	velocity.y = jump_velocity
func movement():
 pass
