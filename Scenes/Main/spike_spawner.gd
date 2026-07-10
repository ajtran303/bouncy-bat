extends Node2D

@export var spike_scene: PackedScene
@export var spawn_x: float = 550.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_spawn_timer_timeout() -> void:
	var spike := spike_scene.instantiate()
	spike.position.x = spawn_x
	spike.oscillates = randf() < 0.33
	spike.scored.connect(_on_spike_scored)
	add_child(spike)

func _on_spike_scored() -> void:
	GameManager.add_score(1)
