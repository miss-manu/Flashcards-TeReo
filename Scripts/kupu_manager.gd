#kupu_manager.gd
extends Node

var vocabulary = {}
var current_word = ""
var correct_translation = ""

func _ready() -> void:
	# Load vocabulary when this singleton is ready
	load_words_from_file("res://tereokupu.txt")
	print("KupuManager: Vocabulary loaded and ready!")
	
func load_words_from_file(file_path):
	var file = FileAccess.open(file_path, FileAccess.READ)
	
	if file:
		while not file.eof_reached():
			var line = file.get_line()
			var parts = line.split(",")
			
			if parts.size() == 2:
				vocabulary[parts[0]] = parts[1]
		
		file.close()
		print("KupuManager: Total words loaded: ", vocabulary.size())
	else:
		printerr("KupuManager Error: Could not open file ", file_path) # Use printerr for errors!
		printerr("Check if 'tereokupu.txt' is in your project root or adjust the path.")


# --- Helper functions for your game scenes ---
func get_random_maori_word() -> String:
	if vocabulary.is_empty():
		printerr("KupuManager Error: Vocabulary is empty!")
		return ""
	var words = vocabulary.keys()
	return words[randi() % words.size()]


func get_english_translation(maori_word: String) -> String:
	return vocabulary.get(maori_word, "") # Returns "" if word not found


func check_answer(maori_word: String, user_input: String) -> bool:
	var correct_answer = get_english_translation(maori_word)
	return user_input.strip_edges().to_lower() == correct_answer.strip_edges().to_lower()


func get_random_english_word() -> String:
	if vocabulary.is_empty():
		printerr("KupuManager Error: Vocabulary is empty!")
		return ""
	var words = vocabulary.values() # Get a list of all English words
	return words[randi() % words.size()]


func get_maori_translation(english_word: String) -> String:
	# Correct GDScript syntax for iterating dictionary key-value pairs
	for maori in vocabulary: # 'maori' will be the key (Maori word)
		var english = vocabulary[maori] # Get the value (English translation) using the key
		if english == english_word:
			return maori
	return "" # Not found
