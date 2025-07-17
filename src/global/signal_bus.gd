## Autoload for signal bus
extends Node

@warning_ignore("unused_signal")
signal signal_with_data(signal_data: BaseSignalData)
signal scene_unloaded()
signal scene_loaded()

#region ------------------------ PUBLIC VARS -----------------------------------

#TODO remove this when config manager will be added
## Controls whether or not the SignalBus prints its logs.
var do_log := false

#endregion

#region ------------------------ PRIVATE VARS ----------------------------------

## Used to prevent signal emits on no fully loaded scene
var _can_bus_emit := false : 
    set = _set_bus_emit

## Used to prevent calling signals by emit
# Signal bus is always first in signal recievers list so if this flag
# is set to false then signal wasn't coming from bus_emit
var _signal_emitted_from_bus := false

#endregion

#region ======================== SET UP METHODS ================================

func _ready() -> void:
    _set_up()

func _set_up() -> void:
    _connect_ready_signals()

func _connect_ready_signals() -> void:
    # Following loop is used to auto connect to all SignalBus signals to 
    # emit source validation
    # ready signal is the first build in signal so loop ends on it
    for sig in get_signal_list():
        if sig.name == "ready":
            break
        
        var callable = _validate_emit_source
        
        if len(sig.args) > 0:
            callable = _validate_emit_source.unbind(len(sig.args))
        
        connect(
            sig.name, 
            callable
        )
    
    bus_connect(
        scene_unloaded,
        _set_bus_emit.bind(false)
    )
    bus_connect(
        scene_loaded,
        _set_bus_emit.bind(true)
    )

#endregion

#region ======================== PUBLIC METHODS ================================

## Connect to a bus signal. Use this instead of [method Signal.connect].
func bus_connect(sig:Signal, method:Callable) -> void:
    assert(sig.get_object() == self, "Attempted to bus connect to a foreign signal")

    _try_log(
        "method &\"%s\" on Object %s connected to SignalBus signal %s" % [
            method.get_method(), 
            method.get_object(), 
            sig.get_name()
        ]
    )
    
    sig.connect(method)

func bus_emit(
        sig: Signal, 
        signal_data: BaseSignalData = null
    ) -> void:
    assert(sig.get_object() == self, "Attempted to bus emit a foreign signal")
    
    if sig.get_name() != scene_loaded.get_name():
        assert(_can_bus_emit, "Attempted to bus emit on not loaded scene")
    
    if signal_data == null:
        signal_data = EmptySignalData.new()
    
    _signal_emitted_from_bus = true
    
    if not signal_data.has_args:
        _try_log(
            "SignalBus signal %s emitted" % [
                sig.get_name()
            ]
        )
        
        sig.emit()
        return
    
    _try_log(
        "SignalBus signal %s emitted with arguments %s" % [
            sig.get_name(),
            signal_data.get_args()
        ]
    )
    
    sig.emit(signal_data)

#endregion

#region ======================== LOG SYS METHODS ===============================

func _try_log(message: String) -> void:
    if do_log:
        return
    
    _log(message)

func _log(message: String) -> void:
    const LOG_SOURCE_NAME := "SignalBus"
    Logger.add_log(
        LOG_SOURCE_NAME,
        message
    )

#endregion

#region ======================== PRIVATE METHODS ===============================

func _validate_emit_source() -> void:
    assert(_signal_emitted_from_bus, "Signal wasn't emiited from bus")
    _signal_emitted_from_bus = false

func _set_bus_emit(new_val: bool) -> void:
    _can_bus_emit = new_val

#endregion
