extends CanvasLayer

@onready var score_label: Label = $ScoreLabel

func show_game_over(final_score: int) -> void:
	visible = true
	score_label.text = "Game Over\n\nScore: %d" % final_score


func _on_restart_button_pressed() -> void:
	get_tree().paused = false
	GameManager.score = 0
	get_tree().reload_current_scene()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
