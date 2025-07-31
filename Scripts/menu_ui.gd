#menu_ui.gd
extends Control

@onready var main_menu_ui = %main_panel

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_learning_btn_pressed() -> void:
	var test_screen = load("res://Scenes/kupu_test_ui.tscn").instantiate()
	add_child(test_screen)
	main_menu_ui.hide()  # Hide the menu content
	print("GAME UI scene loaded")


func _on_testing_btn_pressed() -> void:
	pass # Replace with function body.


func _on_score_btn_pressed() -> void:
	pass # Replace with function body.
