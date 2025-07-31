extends Control

@onready var answer_option1 = $ButtonContainer/Answer1_btn
@onready var answer_option2 = $ButtonContainer/Answer2_btn
@onready var answer_option3 = $ButtonContainer/Answer3_btn
@onready var answer_option4 = $ButtonContainer/Answer4_btn
@onready var guess_word = $GuessWordLabel
@onready var game_over_label = $GameOverLabel

#var words = {}
#var current_word = ""
#var correct_translation = ""
var score = 0
var incorrect_guess_count = 5
var max_incorrect = 5

# Called when the node enters the scene tree for the first time
func _ready():
	#load_words_from_file("res://tereokupu.txt")
	set_new_word()
	update_score()
#	game_over_label.is_visible = false

func set_new_word():
	if incorrect_guess_count >= max_incorrect:
#		end_quiz()
		return
	pass

func update_score():
	$ScoreLabel.text = "Score: %d" % score
	$LivesLabel.text = "Lives: %d/%d" % [incorrect_guess_count,max_incorrect]

func _on_answer_1_btn_pressed():
	check_answer(answer_option1.text)

func _on_answer_2_btn_pressed():
	check_answer(answer_option2.text)

func _on_answer_3_btn_pressed():
	check_answer(answer_option3.text)
	
func _on_answer_4_btn_pressed():
	check_answer(answer_option4.text)

func check_answer(selected_text):
	#if selected_text == correct_translation:
		# play a correct tune OR highlight green
		#styleBox.set("bg_color", Color(0.0, 0.961, 0.157))
		#score += 1
		# add to a 'fill the stars' bar and then progress up a level?
	#else:
		# lose lives?
		#incorrect_guess_count -= 1
		#to_try_again(correct_translation)
	
	#set_new_word()
	#update_score()
	pass

func to_try_again(incorrect_options):
	var incorrect_answers = []
	incorrect_answers.append(incorrect_options)
	
	print(incorrect_answers)
	
#func end_quiz():
#	game_over_label.is_visible = true
#	game_over_label.text = "Quiz Over!"
#	$Option1.hide()
#	$Option2.hide()
#	$Option3.hide()
