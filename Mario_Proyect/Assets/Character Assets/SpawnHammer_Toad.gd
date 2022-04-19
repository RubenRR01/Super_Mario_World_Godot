extends KinematicBody2D
var motion = Vector2.ZERO
var direction = 1
var speed = 35
export var pixels_moved : float
onready var hammer = preload("res://Assets/Character Assets/Hammer.tscn")

export var jump_height : float = 50.0
export var jump_time_to_peak : float = 1.0
export var jump_time_to_descent : float = 1.0

onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

signal enter


func _ready():
	set_physics_process(false)
func _enter_tree():
	$Spawn_Timer.set_one_shot(true)
	$Spawn_Timer.set_wait_time(1.0)
	$Spawn_Timer.set_autostart(true)
	emit_signal("enter")
	
func _on_Spawn_Timer_timeout():
	$AnimationPlayer.play("spawn")

	

func _on_AnimationPlayer_animation_finished(spawn):
	set_physics_process(true)
	$Hammer_Timer.set_wait_time(1.0)
	$Hammer_Timer.start()


func _physics_process(delta):
	#loop_movement()
	motion.y += get_gravity() * delta
	motion = move_and_slide(motion, Vector2.UP)
	chase()
	
func _on_Timer_timeout():
	motion.y = jump_velocity
func get_gravity() -> float:
	return jump_gravity if motion.y < 0.0 else fall_gravity
	
func loop_movement():
	motion.x = speed * direction
	pixels_moved =  pixels_moved + motion.x
	if pixels_moved >= 1000 or pixels_moved <= -1000:
		direction *= -1
func chase():
	var player_position : int = get_node("../../Bowser").position.x
	var my_position : int = self.position.x
	var distance = self.position.x - player_position
	print(self.position)
	if distance < -200:
		motion.x = speed
	elif distance > 200:
		motion.x = -speed
	elif distance > -180 and distance < 180:
		loop_movement()
		
	if distance < -0:
		$AnimatedSprite.flip_h = false 
			
	else:
		$AnimatedSprite.flip_h = true
	print(distance)
func _on_Hammer_Timer_timeout():
	var proyectile = hammer.instance()
	if $AnimatedSprite.flip_h == false:
		proyectile.direction = 1
	else:
		proyectile.direction = -1
	
	get_parent().add_child(proyectile)
	proyectile.position.y = self.position.y
	proyectile.position.x = self.position.x + 5 
	

