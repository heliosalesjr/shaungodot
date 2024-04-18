extends Area2D

var health := 3

func _on_area_entered(area):
	health -= 1
	area.queue_free()
	if health < 1:
		queue_free()
