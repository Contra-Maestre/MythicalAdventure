extends Node


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://World/world.tscn")
	


func _on_exit_button_pressed() -> void:
	get_tree().quit()

func _on_full_screen_button_pressed() -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
