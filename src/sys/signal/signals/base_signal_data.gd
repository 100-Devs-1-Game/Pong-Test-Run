class_name BaseSignalData
extends RefCounted

#region ------------------------ PUBLIC VARS -----------------------------------

## Flag that tells if signal has args
var has_args: bool

#endregion

#region ------------------------ PRIVATE VARS ----------------------------------

## Signal from SignalBus that will be emitte
var _base_signal: Signal

#endregion

#region ======================== SET UP METHODS ================================

func _init(
            new_base_signal: Signal = SignalBus.signal_with_data,
    ) -> void:
    
    _base_signal = new_base_signal

#endregion

#region ======================== PUBLIC METHODS ================================

## Proper emit of signal bus signal
func emit() -> void:
    SignalBus.bus_emit(_base_signal, self)

## Return array of args that signal has. Can be overwritten
func get_args() -> Array:
    return []

#endregion

#region ======================== PRIVATE METHODS ===============================

func _set_has_args() -> void:
    has_args = true

#endregion
