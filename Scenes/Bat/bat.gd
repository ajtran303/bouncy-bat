extends CharacterBody2D

@export var gravity: float = 900.0
@export var flap_strength: float = -300.0

var is_dead := false

func _ready() -> void:
	set_physics_process(false)

func start() -> void:
	set_physics_process(true)

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta

	if Input.is_action_just_pressed("flap"):
		$AnimatedSprite2D.play("flap")
		$FlapSound.play()
		velocity.y = flap_strength

	move_and_slide()
	
	var target_rotation = clamp(velocity.y / 400.0, -0.5, 1.2)
	rotation = lerp_angle(rotation, target_rotation, 5.0 * delta)
	
	if global_position.y < 0 or global_position.y > get_viewport_rect().size.y:
		die()


func _on_bat_spawn_timer_timeout() -> void:
	print("Tick: bat y position: ", position.y)


func _on_animated_sprite_2d_animation_finished() -> void:
	$AnimatedSprite2D.frame = 0


func _on_hurt_box_body_entered(body: Node2D) -> void:
	die()


func die() -> void:
	if is_dead:
		return
	is_dead = true
	set_physics_process(false)
	$AnimatedSprite2D.hide()
	$DeathAnimation.emitting = true
	get_tree().paused = true
	get_tree().call_group("game_over_ui", "show_game_over")
