# In kupu_test_ui.gd
extends Control

@onready var question_label = %GuessWordLabel # To display the Maori word
@onready var feedback_label = %FeedbackLabel # To show "Correct!" or "Incorrect!"

@onready var answer_line_edit = %LineEdit
@onready var submit_answer_button = %Button

# Assuming KupuManager is set up as an AutoLoad
var current_maori_word = "" # To keep track of the word currently being tested

func _ready():
	# Connect signals
	if answer_line_edit:
		answer_line_edit.text_submitted.connect(_on_submit_answer)
	if submit_answer_button:
		submit_answer_button.pressed.connect(_on_submit_answer)

	# Initialize feedback label
	feedback_label.visible = false # Start with feedback hidden

	# Display the first word
	_display_new_word()

func _display_new_word():
	current_maori_word = KupuManager.get_random_maori_word()
	question_label.text = current_maori_word # Display the Maori word for translation
	answer_line_edit.clear()
	answer_line_edit.grab_focus()
	feedback_label.visible = false # Hide previous feedback

	print("Current word to translate: ", current_maori_word)

func _on_submit_answer():
	var user_input = answer_line_edit.text
	var is_correct = KupuManager.check_answer(current_maori_word, user_input)

	feedback_label.visible = true # Show the feedback label

	if is_correct:
		feedback_label.text = "Tika! (" + current_maori_word.capitalize() + " means " + KupuManager.get_english_translation(current_maori_word).capitalize() + ")"
		feedback_label.modulate = Color("00ff00") # Green color for correct
		await get_tree().create_timer(1.5).timeout # Wait for 1.5 seconds
		_display_new_word() # Move to the next word
	else:
		feedback_label.text = "Hē! Try again. (" + KupuManager.get_english_translation(current_maori_word).capitalize() + ")" # Give a hint
		feedback_label.modulate = Color("ff0000") # Red color for incorrect
		answer_line_edit.clear()
		answer_line_edit.grab_focus()


func _on_finish_btn_pressed() -> void:
	pass # Replace with function body.


func _on_return_btn_pressed() -> void:
	queue_free() # Removes this test_ui scene from its parent
	# And then you might need to tell the parent to show its elements again
	get_parent().main_menu_ui.show() # Replace with function body.
	print("GAME UI scene UNloaded")
