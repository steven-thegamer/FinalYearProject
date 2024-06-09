extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _ready():
	var test_string := "x**-1"
	var tokenize_test_string = tokenize(test_string)
	var parse_test_string = parse_tokens(tokenize_test_string)
	print(tokenize_test_string)
	print(parse_test_string)

func tokenize(expression : String):
	var regex = RegEx.new()
	var result = []
	regex.compile('(\\d+(\\.\\d+)?)|x|([-\\+\\/]|(\\*){1,2})|([()])|sin|cos|tan|csc|sec|cot|log|exp')
	var arr_found = regex.search_all(expression)
	for discover in arr_found:
		result.append(discover.get_string())
	return result

func parse_tokens(tokens : Array):
	var index = 0
	var new_token_arr = []
	var fraction_indicator = []
	while index < len(tokens):
		if tokens[index] == "/":
			var frac = []
			# WHAT'S INSIDE THE FRAC? AN ARRAY OF THREE ELEMENTS
			# [NUM_INDEX, DENUM_INDEX, FRACTION]
			var numerator = ""
			var denominator = ""
			# STOP CHECKING IF () HITS OR AN OPERATOR +-
			# FIND THE NUMERATOR
			var parenthesis = 0
			for i in range(index-1, -1, -1):
				if tokens[i] == "(":
					parenthesis -= 1
				elif tokens[i] == ")":
					parenthesis += 1
				if ((tokens[i] == "+" or tokens[i] == "-") and parenthesis == 0):
					frac.append(i+1)
					break
				elif i == 0:
					numerator = tokens[i] + numerator
					frac.append(0)
					break
				else:
					numerator = tokens[i] + numerator
			# NOW FIND THE DENOMINATOR
			parenthesis = 0
			for i in range(index+1,len(tokens)):
				if tokens[i] == "(":
					parenthesis += 1
				elif tokens[i] == ")":
					parenthesis -= 1
				if (tokens[i] == "+" or tokens[i] == "-") and parenthesis == 0:
					index = i-1
					frac.append(i-1)
					break
				elif i == len(tokens) - 1:
					denominator += tokens[i]
					frac.append(i)
					break
				else:
					denominator += tokens[i]
			var new_token = numerator + "/" + denominator
			frac.append(new_token)
			fraction_indicator.append(frac)
		elif tokens[index] == "exp":
			tokens[index] = "e"
			tokens.insert(index+1,"**")
		elif tokens[index] == "log":
			tokens[index] = "ln"
		index += 1
	var index_2 = 0
	while index_2 < len(tokens):
		if fraction_indicator.size() > 0 and fraction_indicator[0][0] == index_2:
			new_token_arr.append(fraction_indicator[0][2])
			index_2 = fraction_indicator[0][1]
			fraction_indicator.pop_front()
		else:
			new_token_arr.append(tokens[index_2])
		index_2 += 1
	return new_token_arr
