class_name InputPaddleController
extends PaddleController

enum ControlScheme { KEYBOARD, KEYBOARD_AND_MOUSE, GAMEPAD }

@export var control_scheme: ControlScheme


func get_movement_direction() -> float:
    return Input.get_action_raw_strength("move_down") - Input.get_action_raw_strength("move_up")


func get_tilt_direction() -> float:
    return Input.get_action_strength("tilt_down") - Input.get_action_strength("tilt_up")


func get_look_direction(from_position: Vector2) -> Vector2:
    match control_scheme:
        ControlScheme.KEYBOARD_AND_MOUSE:
            var mouse_position := get_viewport().get_mouse_position()
            return (mouse_position - from_position).normalized()
        ControlScheme.GAMEPAD:
            return Input.get_vector("look_left", "look_right", "look_up", "look_down")

    return Vector2.ZERO
