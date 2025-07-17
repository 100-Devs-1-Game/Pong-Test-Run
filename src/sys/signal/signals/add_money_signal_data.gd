class_name AddMoneySignalData
extends BaseSignalData

#region ------------------------ PUBLIC VARS -----------------------------------

var value: float

#endregion

#region ======================== SET UP METHODS ================================

func _init(
            new_value: float
    ) -> void:
    super()
    
    value = new_value
    
    _set_up()

func _set_up() -> void:
    _set_has_args()

#endregion

#region ======================== PUBLIC METHODS ================================

func get_args() -> Array:
    return [value]

#endregion
