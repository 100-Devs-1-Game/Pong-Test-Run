extends Node2D

@onready var paddle: Paddle = $Paddle


func _process(delta: float) -> void:
    var dir: float = Input.get_axis("ui_up", "ui_down")
    paddle.current_direction = dir
