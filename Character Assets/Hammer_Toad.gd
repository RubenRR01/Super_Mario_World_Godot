extends KinematicBody2D
var motion = Vector2.ZERO
var direction = 1
var speed = 35
export var pixels_moved : float
onready var hammer = preload("res://Assets/Character Assets/Hammer.tscn")
var player_position: int
var enemie_spawn = false
var enemie = false
export var jump_height : float = 50.0
export var jump_time_to_peak : float = 1.0
export var jump_time_to_descent : float = 0.5

onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0



func _ready():
	if get_parent().get_node("../../Enemies"):
		enemie_spawn = true
		$CollisionShape2D.set_disabled(true)
		$Area2D/CollisionShape2D.set_disabled(true)
		$AnimatedSprite.position = self.position + Vector2(0, 20)
		set_physics_process(false)
		$Spawn_Timer.set_wait_time(1.0)
		$Spawn_Timer.set_one_shot(true)
		$Spawn_Timer.start()
	if get_parent().get_node("../Node2D"):
		$Hammer_Timer.set_wait_time(1.0)
		$Hammer_Timer.start()
		enemie = true
	
func _physics_process(delta):
	#loop_movement()
	motion.y += get_gravity() * delta
	motion = move_and_slide(motion, Vector2.UP)
	chase()
	print($AnimatedSprite.get_frame())
	
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
	if enemie == true:
		player_position = get_parent().get_node("Bowser").position.x
	elif enemie_spawn == true:
		player_position = get_node("../../../Bowser").position.x
	var my_position: int = self.global_position.x
	var distance = my_position - player_position
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

func _on_Hammer_Timer_timeout():
	var proyectile = hammer.instance()
	if $AnimatedSprite.flip_h == false:
		proyectile.direction = 1
	else:
		proyectile.direction = -1
	
	add_child(proyectile)
	proyectile.position.y = get_position_in_parent()
	proyectile.position.x = get_position_in_parent()

func _on_Position2D_do_animation():
	pass


func _on_Spawn_Timer_timeout():
	$AnimationPlayer.play("spawn")
	
func _on_AnimationPlayer_animation_finished(anim_name):
	set_physics_process(true)
	$Hammer_Timer.set_wait_time(1.0)
	$Hammer_Timer.start()
	$CollisionShape2D.set_disabled(false)
	$Area2D/CollisionShape2D.set_disabled(false)

func _exit_tree():
	emit_signal("tree_exiting")
	





func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.get_animation() == "die":
		queue_free()


func _on_Area2D_area_entered(area):
	$Hammer_Timer.stop()
	$Spawn_Timer.stop()
	$CollisionShape2D.queue_free()
	$Area2D/CollisionShape2D.queue_free()
	set_physics_process(false)
	$AnimatedSprite.play("die")
	

