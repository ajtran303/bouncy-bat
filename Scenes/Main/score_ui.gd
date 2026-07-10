extends CanvasLayer

@onready var score_label: Label = $ScoreLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score_label.text = str(GameManager.score)
	GameManager.score_changed.connect(_on_score_changed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_score_changed(new_score: int) -> void:
	score_label.text = str(new_score)
