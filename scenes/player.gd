extends CharacterBody2D

var direction_x := 0
@export var speed = 150

var can_shoot = true

func _process(delta):
	get_input()
	apply_gravity()
	velocity.x = direction_x * speed
	move_and_slide()
	
func get_input():
	direction_x = Input.get_axis("left","right")
	
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y = -200
	
	if Input.is_action_pressed("shoot") && can_shoot:
		print("shoot")
		can_shoot = false
		$Timers/CoolDownTimer.start()

func apply_gravity():
	velocity.y += 20


func _on_cool_down_timer_timeout():
	can_shoot = true
