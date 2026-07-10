extends CharacterBody2D

@export var gravity: float = 900.0
@export var flap_strength: float = -300.0

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta

	if Input.is_action_just_pressed("ui_accept"):
		$AnimatedSprite2D.play("flap")
		velocity.y = flap_strength

	move_and_slide()
	
	var target_rotation = clamp(velocity.y / 400.0, -0.5, 1.2)
	rotation = lerp_angle(rotation, target_rotation, 5.0 * delta)


func _on_bat_spawn_timer_timeout() -> void:
	print("Tick: bat y position: ", position.y)


func _on_animated_sprite_2d_animation_finished() -> void:
	$AnimatedSprite2D.frame = 0
