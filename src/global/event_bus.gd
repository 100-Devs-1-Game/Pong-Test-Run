extends Node
# autoload EventBus

# the place for all global signals
# add individual regions for modules


#region UI
# Updates the score shown on the UI.
#
# This function sets the score values for both players.
# If a `global_score_position` is provided, a short animation is played starting from that position.
# This can be used to show where the score came from (e.g. the ball position).
# If `global_score_position` is `Vector2.INF`, no animation is played.
#
# @param left:int Score for the left player.
# @param right:int Score for the right player.
# @param global_score_position:Vector2 (optional) The viewport position to start the score animation from. Use `Vector2.INF` to skip the animation.
signal ui_set_score(left: int, right: int, pos: Vector2)

#Hide the Score UI
signal ui_hide_score()

#Show thr Score UI
signal ui_show_score()
#endregion
