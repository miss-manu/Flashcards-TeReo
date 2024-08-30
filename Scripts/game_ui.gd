extends Control

@onready var answer_option1 = $AspectRatioContainer/Answer1_btn
@onready var answer_option2 = $AspectRatioContainer/Answer2_btn
@onready var answer_option3 = $AspectRatioContainer/Answer3_btn
@onready var answer_option4 = $AspectRatioContainer/Answer4_btn
@onready var guess_word = $GuessWordLabel

var words = {}
var current_word = ""
var correct_translation = ""
var score = 0
var incorrect_guesses = 5

# Called when the node enters the scene tree for the first time
func _ready():
	load_words_from_file("res://tereokupu.txt")
	set_new_word()
	update_score()

func load_words_from_file(file_path):
	var file = FileAccess.open(file_path, FileAccess.READ)
	
	if file:
		
		while not file.eof_reached():
			var line = file.get_line()
			var parts = line.split(",")
			
			if parts.size() == 2:
				words[parts[0]] = parts[1]
		
		file.close()

func set_new_word():
	var keys = words.keys()
	current_word = keys[randi() % keys.size()]
	correct_translation = words[current_word]
	
	#styleBox.set("bg_color", Color(0.807, 0.807, 0.797))
	guess_word.text = current_word
	
	 # Shuffle all words and pick incorrect options from them
	var shuffled_words = words.values()
	shuffled_words.shuffle()
	
	# Create a shuffled list of translation options
	var options = [correct_translation]

	# Collect additional incorrect options
	var incorrect_options = []
	for word in shuffled_words:
		if word != correct_translation:
			incorrect_options.append(word)
			if incorrect_options.size() >= 3:
				break
	
	# Add incorrect options to the list, then clear wrong answers
	options += incorrect_options
	incorrect_options.clear()
	
	options.shuffle()
	
	# Assign answer options to buttons
	answer_option1.text = options[0]
	answer_option2.text = options[1]
	answer_option3.text = options[2]
	answer_option4.text = options[3]

func update_score():
	$ScoreLabel.text = "Score: %d" % score
	$LivesLabel.text = "Lives: %d" % incorrect_guesses

func _on_answer_1_btn_pressed():
	check_answer(answer_option1.text)

func _on_answer_2_btn_pressed():
	check_answer(answer_option2.text)

func _on_answer_3_btn_pressed():
	check_answer(answer_option3.text)
	
func _on_answer_4_btn_pressed():
	check_answer(answer_option4.text)

func check_answer(selected_text):
	if selected_text == correct_translation:
		# play a correct tune OR highlight green
		#styleBox.set("bg_color", Color(0.0, 0.961, 0.157))
		score += 1
		# add to a 'fill the stars' bar and then progress up a level?
	else:
		# lose lives?
		incorrect_guesses -= 1
		to_try_again(correct_translation)
	
	set_new_word()
	update_score()

func to_try_again(incorrect_options):
	var incorrect_answers = []
	incorrect_answers.append(incorrect_options)
	
	print(incorrect_answers)
