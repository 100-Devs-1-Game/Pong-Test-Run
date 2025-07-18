extends Node
# autoload EventBus

# the place for all global signals
# add individual regions for modules

#region physics
signal update_ball_position(pos: Vector2)
signal update_ball_velocity(vel: Vector2)
signal update_player_paddle_position(pos: Vector2)
signal update_opponent_paddle_position(pos: Vector2)
signal update_player_paddle_rotation(rot: float)
signal update_opponent_paddle_rotation(rot: float)
#endregion
