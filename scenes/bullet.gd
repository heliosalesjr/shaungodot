extends Area2D

var direction: int  = 1
@export var speed = 300

func _process(delta):
	position.x += speed * direction * delta 
