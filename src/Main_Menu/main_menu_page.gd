extends Control

@export var game_scene: PackedScene
@export var setting_scene: PackedScene


# connect to signals for button presses
func _ready() -> void:
    $CenterContainer/VBoxContainer/PlayButton.connect("pressed", _on_play_button_down)
    $CenterContainer/VBoxContainer/SettingsButton.connect("pressed", _on_settings_button_down)


func _on_play_button_down():
    EventBus.main_menu_play_button_clicked.emit()
    print("Play button on main menu clicked")
    if game_scene:
        get_tree().change_scene_to_packed(game_scene)
    else:
        print("no game cene to change to!!")


func _on_settings_button_down():
    EventBus.main_menu_settings_button_clicked.emit()
    print("Settings button on main menu clicked")
    if setting_scene:
        get_tree().change_scene_to_packed(setting_scene)
    else:
        print("no Setting scene to change to!!")
