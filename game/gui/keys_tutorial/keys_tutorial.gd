extends Control

func _on_start_game_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://gui/initial_dialog/initial_dialog.tscn")
