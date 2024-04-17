extends CharacterBody2D

var direction_x := 0
var facing_right := true
var has_gun := false
@export var speed = 150
var can_shoot = true

signal shoot(pos: Vector2, direction: bool)

func _process(delta):
	get_input()
	apply_gravity()
	get_facing_direction()
	get_animation()
	velocity.x = direction_x * speed
	move_and_slide()
	
func get_input():
	direction_x = Input.get_axis("left","right")
	
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y = -200
	
	if Input.is_action_pressed("shoot") && can_shoot:
		can_shoot = false
		$Timers/CoolDownTimer.start()
		shoot.emit(global_position, facing_right)

func apply_gravity():
	velocity.y += 10

func get_facing_direction():
	if direction_x != 0:
		facing_right = direction_x >= 0
		
func get_animation():
	var animation = "idle"
	if not is_on_floor():
		animation = "jump"
	elif direction_x != 0:
		animation = "walk"
	if has_gun:
		animation += '_gun'
	$AnimatedSprite2D.animation = animation
	$AnimatedSprite2D.flip_h = not facing_right
	
func _on_cool_down_timer_timeout():
	can_shoot = true
