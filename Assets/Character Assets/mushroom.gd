extends KinematicBody2D
signal change



func _on_Area2D_body_entered(body):
	print("a")
	self.set_name("item")
	
func _process(delta):
	if self.name == "item":
		emit_signal("change")

