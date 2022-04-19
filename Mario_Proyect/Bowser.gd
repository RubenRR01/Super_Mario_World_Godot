extends KinematicBody2D

export var move_speed = 200.0

var velocity := Vector2.ZERO

signal se_acabo
signal bote
signal pausar
export var jump_height : float
export var jump_time_to_peak : float
export var jump_time_to_descent : float

onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

#func _on_AnimationPlayer_animation_finished(Nueva_Animacion):
#	 emit_signal("animation_finished")
#func _on_Bowser_animation_finished():
#	print("a")
func _physics_process(delta):
	velocity.y += get_gravity() * delta
	velocity.x = get_input_velocity() * move_speed
	if Input.is_action_just_pressed("move_up") and is_on_floor():
		jump()
	
	velocity = move_and_slide(velocity, Vector2.UP)

	
	pipe()
func get_gravity() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity

func jump():
	velocity.y = jump_velocity

func get_input_velocity() -> float:
	var horizontal := 0.0
	
	if Input.is_action_pressed("left"):
		horizontal -= 1.0
	if Input.is_action_pressed("move_right"):
		horizontal += 1.0
	
	return horizontal

func pipe():
	if Input.is_action_pressed("move_down"):
		$AnimationPlayer.play("Nueva_Animacion")
		
		

func _on_AnimationPlayer_animation_started(Nueva_Animacion):
	if $AnimationPlayer.get_current_animation() == "Crecer":
		set_physics_process(false)


func _on_AnimationPlayer_animation_finished(Nueva_Animacion):
	emit_signal("se_acabo")
	if $AnimationPlayer.get_current_animation() != "Crecer":
		set_physics_process(true)
		print("a")
func _on_StaticBody2D_body_entered(body):
	if is_on_ceiling():
		emit_signal("bote")


func _on_Timer_timeout():
	$AnimationPlayer.play("Crecer")
	emit_signal("pausar")


func Animaciones():
	if $AnimationPlayer.get_assigned_animation() == "Crecer":
		set_physics_process(false)
	else:
		set_physics_process(true)
	
