from godot import exposed, export, Node
from godot import *
import sympy as sym
from sympy.simplify.fu import TR22

@exposed
class test_node(Node):
	
	# This array is for storing all possible answer forms from the function called all_form_of_answers below
	all_answer_forms = []
	# This creates a custom signal
	question_created = signal()
	# These are the possible numbers to be selected. There is no 0 in the array on purpose to prevent 0*x**c or c*x**0 where c is any other numbers
	possible_numbers = [1,2,3,4,5,6,7,8,9,-1,-2,-3,-4,-5,-6,-7,-8,-9]

	# This function generates the equation randomly depending on the level
	def generate_new_equation(self,level_number):
		# Generates the RandomNumberGenerator built in Godot
		rng = RandomNumberGenerator()
		# Randomize the seed 
		rng.randomize()
		x = sym.symbols('x')
		level_question = ""
		if level_number == 1:
			size = rng.randi_range(2,5)
			# Select a random number from the array
			coeff = self.possible_numbers[rng.randi_range(0,17)]
			# This creates the equation in string format
			level_question = str(coeff) + "*x**" + str(size)
		elif level_number == 2:
			coeff = self.possible_numbers[rng.randi_range(0,17)]
			coeff_2 = self.possible_numbers[rng.randi_range(0,17)]
			level_question = str(coeff) + "*x**2 +" + str(coeff_2) + "*x"
		return level_question

	
	# Generates all possible form of answers
	def all_derivative_answers(self,question):
		x = sym.symbols('x')
		answer_expr = str(sym.diff(question,x))
		all_possible_answers = Array()
		all_possible_answers.append(answer_expr)
		# Find all possible answers according to all possible ways to simplify the equation using SymPy
		for func in [sym.simplify, sym.expand, sym.factor, lambda expr: sym.collect(expr, x), sym.cancel, sym.apart]:
			temp = str(func(answer_expr))
			if temp not in all_possible_answers:
				all_possible_answers.append(temp)
		return all_possible_answers
	# This code converts the equation into a proper sympy format
	def sympify_equation(self,equation_string):
		x = sym.symbols('x')
		answer_expr = sym.sympify(str(equation_string))
		str_answer = str(answer_expr)
		return str_answer
