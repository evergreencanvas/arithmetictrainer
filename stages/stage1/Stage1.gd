extends Node

var a
var b
var input = ''
var countRight = 0
var countWrong = 0
var stage = 0
var operationIndex = 0
var operations = [' + ', ' - ', ' x ', ' / ']
var inputAllowed = true

var additionInputStrings = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10']
var subtractInputStrings = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0']
var multiplyInputStrings = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0']

var inputStrings = additionInputStrings

signal correctAnswer
signal wrongAnswer
signal nextStage

func _ready():
	randomize()
	set_stage(0)
	get_new_problem()
	
func set_stage(stageNumber):
	stage = stageNumber
	match stageNumber:
		0:
			operationIndex = 0
			set_input_strings(additionInputStrings)
		1:
			operationIndex = 1
			set_input_strings(subtractInputStrings)
		2:
			operationIndex = 2
			set_input_strings(multiplyInputStrings)
		
	

func check_range(a, b):
	# put here the comparison that tests for a and b creating an undesirable answer
	match stage:
		0:
			return a + b > 10
		1:
			return a - b < 0
		2:
			return a * b > 20
	return true

func generate_new_ab():
	match stage:
		0:
			a = randi() % 6
			b = randi() % 6
		1:
			a = randi() % 10
			b = randi() % 10
		2:
			a = randi() % 10
			b = randi() % 10
	return [a, b]

func get_new_problem():
	# keep generating problems until the inputanswer is 10 or less
	var oldA = a
	var oldB = b
	#a = randi() % 6
	#b = randi() % 6
	[a, b] = generate_new_ab()
	while check_range(a,b) or (a == oldA or b == oldB) or (a == 0 and b == 0):
		#a = randi() % 6 + 1
		#b = randi() % 6 + 1
		[a, b] = generate_new_ab()
	
	$VBoxContainer/CalcDisplay/VBoxContainer/HBoxContainer/ProblemLabel.text = str(a) + operations[operationIndex] + str(b)
	$VBoxContainer/CalcDisplay/VBoxContainer/HBoxContainer/AnswerLabel.text = ''
	input = ''
	inputAllowed = true
	
	match stage:
		0:
			pass
		1:
			pass
		2:
			randomize_input_strings(get_answer(a, b))
	
	
func get_answer(x, y):
	var ans
	match operationIndex:
		0:
			ans = x + y
		1:
			ans = x - y
		2:
			ans = x * y
		3:
			ans = x / y
	return ans

func check_answer():
	# first check if the answer has same number of digits as input, 
	# check answer when the user has entered the right number of digits
	var answer = get_answer(a, b)
	
	if input.length() >= str(answer).length():
		var inputInt = int(input)
		if answer == inputInt:
			countRight += 1
			# emit_signal('correctAnswer')
			on_correctAnswer()
		else:
			countWrong += 1
			# emit_signal('wrongAnswer')
			on_wrongAnswer()
		update_count_labels()
		inputAllowed = false
		$Timer.start()
		
func give_input(numberChar):
	if inputAllowed:
		input += numberChar
		$VBoxContainer/CalcDisplay/VBoxContainer/HBoxContainer/AnswerLabel.text = str(input)
	
		check_answer()
	
func on_correctAnswer():
	$AnimationPlayer.play("flashGreen")
	var point = $Node2D.get_global_mouse_position()
	var explosionScene = load("res://effects/ExplodingChevrons.tscn")
	var node = explosionScene.instance()
	node.chevronColor = Color(0,1,0,1)
	node.transform.origin = point
	add_child(node)

func on_wrongAnswer():
	$AnimationPlayer.play("flashRed")

func update_count_labels():
	$VBoxContainer/HBoxContainer/RightCount.text = str(countRight)
	$VBoxContainer/HBoxContainer/WrongCount.text = str(countWrong)

func _on_Button1_button_down():
	give_input(inputStrings[0])
	

func _on_Button2_button_down():
	give_input(inputStrings[1])


func _on_Button3_button_down():
	give_input(inputStrings[2])


func _on_Button4_button_down():
	give_input(inputStrings[3])


func _on_Button5_button_down():
	give_input(inputStrings[4])


func _on_Button6_button_down():
	give_input(inputStrings[5])


func _on_Button7_button_down():
	give_input(inputStrings[6])


func _on_Button8_button_down():
	give_input(inputStrings[7])


func _on_Button9_button_down():
	give_input(inputStrings[8])


func _on_Button0_button_down():
	give_input(inputStrings[9])


func _on_Timer_timeout():
	get_new_problem()
	$Timer.stop()
	
func set_input_strings(stringList):
	inputStrings = stringList
	$VBoxContainer/CalcDisplay/VBoxContainer/GridContainer/Button1.text = stringList[0]
	$VBoxContainer/CalcDisplay/VBoxContainer/GridContainer/Button2.text = stringList[1]
	$VBoxContainer/CalcDisplay/VBoxContainer/GridContainer/Button3.text = stringList[2]
	$VBoxContainer/CalcDisplay/VBoxContainer/GridContainer/Button4.text = stringList[3]
	$VBoxContainer/CalcDisplay/VBoxContainer/GridContainer/Button5.text = stringList[4]
	$VBoxContainer/CalcDisplay/VBoxContainer/GridContainer/Button6.text = stringList[5]
	$VBoxContainer/CalcDisplay/VBoxContainer/GridContainer/Button7.text = stringList[6]
	$VBoxContainer/CalcDisplay/VBoxContainer/GridContainer/Button8.text = stringList[7]
	$VBoxContainer/CalcDisplay/VBoxContainer/GridContainer/Button9.text = stringList[8]
	$VBoxContainer/CalcDisplay/VBoxContainer/GridContainer/Button0.text = stringList[9]

func randomize_input_strings(answer):
	#first choose which button to put the answer on
	var answerButton = randi() % 10
	
	
	for i in range(0,len(inputStrings)):
		var x = 0
		var y = 0
		var newvals = generate_new_ab()
		x = newvals[0]
		y = newvals[1]
		inputStrings[i] = str(get_answer(x, y))
	set_input_strings(inputStrings)
	
	match answerButton:
		0:
			$VBoxContainer/CalcDisplay/VBoxContainer/GridContainer/Button1.text = str(answer)
		1:
			$VBoxContainer/CalcDisplay/VBoxContainer/GridContainer/Button2.text = str(answer)
		2:
			$VBoxContainer/CalcDisplay/VBoxContainer/GridContainer/Button3.text = str(answer)	
		3:
			$VBoxContainer/CalcDisplay/VBoxContainer/GridContainer/Button4.text = str(answer)
		4:
			$VBoxContainer/CalcDisplay/VBoxContainer/GridContainer/Button5.text = str(answer)
		5:
			$VBoxContainer/CalcDisplay/VBoxContainer/GridContainer/Button6.text = str(answer)
		6:
			$VBoxContainer/CalcDisplay/VBoxContainer/GridContainer/Button7.text = str(answer)
		7:
			$VBoxContainer/CalcDisplay/VBoxContainer/GridContainer/Button8.text = str(answer)
		8:
			$VBoxContainer/CalcDisplay/VBoxContainer/GridContainer/Button9.text = str(answer)
		9:
			$VBoxContainer/CalcDisplay/VBoxContainer/GridContainer/Button0.text = str(answer)
