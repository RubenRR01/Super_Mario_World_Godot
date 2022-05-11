extends KinematicBody2D

export var move_speed = 200.0

var velocity := Vector2.ZERO
var mi_posicion
signal se_acabo
signal bote
signal pausar
signal despausar
signal dead
export var jump_height : float
export var jump_time_to_peak : float
export var jump_time_to_descent : float
export var mini_jump : float = 20
export var list = ["mamahuevo", "aaaaa"]


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
	detect_item()
	if self.position.y > 500:
		$AnimationPlayer.play("dies")
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
		emit_signal("despausar")
	if $AnimationPlayer.get_assigned_animation() == "dies":
		emit_signal("dead")
		
func _on_StaticBody2D_body_entered(body):
	if is_on_ceiling():
		emit_signal("bote")




func Animaciones():
	if $AnimationPlayer.get_assigned_animation() == "Crecer":
		set_physics_process(false)
	else:
		set_physics_process(true)





func detect_item():
	if get_parent().get_node("item"):
		var item =  get_parent().get_node("item")
		item.connect("change", self, "_change")
	
func _change():
	emit_signal("pausar")
	get_parent().get_node("item").queue_free()
	$AnimationPlayer.play("Crecer")
	


#func _on_Bot_Checker_body_entered(body):
#	if Input.is_action_pressed("move_up"):
#		velocity.y = -mini_jump + jump_velocity
#	else:
#		velocity.y = -mini_jump


func _on_Area2D_body_entered(body):
	set_physics_process(false)
	$AnimationPlayer.play("dies")
	$Damage_Checker/CollisionShape2D.set_disabled(true)
	$Bowser_Hitbox.set_disabled(true)
	$Bot_Checker/CollisionShape2D.set_disabled(true)


func _on_Area2D_area_entered(area):
	$AnimationPlayer.play("dies")
	set_physics_process(false)


func _on_Bot_Checker_area_entered(area):
	if Input.is_action_pressed("move_up"):
		velocity.y = -mini_jump + jump_velocity
	else:
		velocity.y = -mini_jump



func _signal():
	pass



