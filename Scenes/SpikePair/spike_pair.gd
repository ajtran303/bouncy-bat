extends Node2D

signal scored

@export var scroll_speed: float = 200.0

@export var gap_size_min: float = 120.0
@export var gap_size_max: float = 180.0
@export var gap_y_min: float = 150.0
@export var gap_y_max: float = 450.0

@export var oscillates: bool = false
@export var oscillation_speed: float = 2.0
@export var oscillation_range: float = 50.0

var _base_y: float
var _elapsed: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var gap_center := randf_range(gap_y_min, gap_y_max)
	var gap_size := randf_range(gap_size_min, gap_size_max)
	var pipe_height := 320.0
	$TopSpike.position.y = gap_center - gap_size / 2.0 - pipe_height
	$BottomSpike.position.y = gap_center + gap_size / 2.0
	
	var score_shape: RectangleShape2D = $ScoreZone/CollisionShape2D.shape.duplicate()
	score_shape.size.y = gap_size
	$ScoreZone/CollisionShape2D.shape = score_shape
	$ScoreZone.position.y = gap_center - 24.0
	
	_base_y = position.y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _physics_process(delta: float) -> void:
	position.x -= scroll_speed * delta
	if oscillates:
		_elapsed += delta
		position.y = _base_y + sin(_elapsed * oscillation_speed) * oscillation_range
	if position.x < -100.0:
		queue_free()


func _on_score_zone_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		scored.emit()
		$ScoreZone/CollisionShape2D.set_deferred("disabled", true)
