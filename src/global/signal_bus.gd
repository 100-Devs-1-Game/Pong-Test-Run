# autoload SignalBus
extends Node

#signal foo()


## Controls whether or not the SignalBus prints its logs.
var do_log:bool = false


## Connect to a bus signal. Use this instead of [method Signal.connect].
func bus_connect(sig:Signal, method:Callable) -> void:
    assert(sig.get_object() == self, "Attempted to bus connect to a foreign signal")
    _log("method &\"%s\" on Object %s connected to SignalBus signal %s" % [
        method.get_method(), method.get_object(), sig.get_name()
    ])
    sig.connect(method)


## Emit a bus signal. Use this instead of [method Signal.emit].
func bus_emit(sig:Signal, arguments:Array) -> void:
    assert(sig.get_object() == self, "Attempted to bus emit a foreign signal")
    _log("SignalBus signal %s emitted with arguments %s" % [
        sig.get_name(), arguments
    ])
    # godot doesn't have varargs, *yet*, so Array it is.
    # TODO: Convert to vararg
    sig.emit.callv(arguments)


func _log(message:String):
    if not do_log:
        return
    print("SignalBus: ", message)