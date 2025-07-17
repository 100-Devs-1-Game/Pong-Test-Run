# autoload Logger
extends Node

#region ======================== PUBLIC METHODS ================================

func add_log(source: String, message: String):
    print("%s: %s" % [source, message])

#endregion
