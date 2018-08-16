extends Node

var a
var b
var input = ''
var countRight = 0
var countWrong = 0
var stage = 0
var operation = 'add'
var operations = ['add', 'subtract', 'multiply', 'divide']

func _ready():
	randomize()
	get_new_problem()
	

func get_new_problem():
	# keep generating problems until the inputwer is 10 or less
	var oldA = a
	var oldB = b
	a = randi() % 6
	b = randi() % 6
	while a + b > 10 or (a == oldA or b == oldB):
		a = randi() % 6 + 1
		b = randi() % 6 + 1
	
	$VBoxContainer/CalcDisplay/VBoxContainer/HBoxContainer/ProblemLabel.text = str(a) + ' + ' + str(b)
	$VBoxContainer/CalcDisplay/VBoxContainer/HBoxContainer/AnswerLabel.text = ''
	input = ''

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func check_answer():
	# first check if the answer has same number of digits as input, 
	# check answer when the user has entered the right number of digits
	var answer = str(a + b)
	
	if input.length() >= answer.length():
		var inputInt = int(input)
		if a + b == inputInt:
			countRight += 1
		else:
			countWrong += 1
		update_count_labels()
		$Timer.start()
		
func give_input(numberChar):
	input += numberChar
	$VBoxContainer/CalcDisplay/VBoxContainer/HBoxContainer/AnswerLabel.text = str(input)
	check_answer()

func update_count_labels():
	$VBoxContainer/HBoxContainer/RightCount.text = str(countRight)
	$VBoxContainer/HBoxContainer/WrongCount.text = str(countWrong)

func _on_Button1_button_down():
	give_input('1')
	

func _on_Button2_button_down():
	give_input('2')


func _on_Button3_button_down():
	give_input('3')


func _on_Button4_button_down():
	give_input('4')


func _on_Button5_button_down():
	give_input('5')


func _on_Button6_button_down():
	give_input('6')


func _on_Button7_button_down():
	give_input('7')


func _on_Button8_button_down():
	give_input('8')


func _on_Button9_button_down():
	give_input('9')


func _on_Button0_button_down():
	give_input('10')


func _on_Timer_timeout():
	get_new_problem()
	$Timer.stop()
