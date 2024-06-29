from godot import exposed, export, Node
from godot import *
import sympy as sym
from sympy.simplify.fu import TR22

@exposed
class equation_generator(Node):
	
	# This array is for storing all possible answer forms from the function called all_form_of_answers below
	all_answer_forms = []
	# This creates a custom signal
	question_created = signal()
	# These are the possible numbers to be selected. There is no 0 in the array on purpose to prevent 0*x**c or c*x**0 where c is any other numbers
	possible_numbers = [1,2,3,4,5,6,7,8,9,-1,-2,-3,-4,-5,-6,-7,-8,-9]
	possible_numbers_with_zero = [1,2,3,4,5,6,7,8,9,-1,-2,-3,-4,-5,-6,-7,-8,-9,0]
	# This function generates the equation randomly depending on the level
	def generate_new_equation(self,level_number):
		# Generates the RandomNumberGenerator built in Godot
		rng = RandomNumberGenerator()
		# Randomize the seed 
		rng.randomize()
		x = sym.symbols('x')
		level_question = ""
		if level_number == 1:
			level_equation = "a*x**n"
			level_equation = level_equation.replace('a',str(self.possible_numbers[rng.randi_range(0,17)]))
			level_equation = level_equation.replace('n',str(rng.randi_range(2,5)))
		elif level_number == 2:
			level_question = "a*x**2 + b*x"
			level_equation = level_equation.replace('a',str(self.possible_numbers[rng.randi_range(0,17)]))
			level_equation = level_equation.replace('b',str(self.possible_numbers[rng.randi_range(0,17)]))
		elif level_number == 3:
			size = rng.randi_range(2,4)
			level_question = "a*x**2 + b*x + c"
			if size == 3:
				level_question = "a*x**3 + b*x**2 + c*x + d"
				level_equation = level_equation.replace('d',str(self.possible_numbers[rng.randi_range(0,17)]))
			elif size == 4:
				level_question = "a*x**4 + b*x**3 + c*x**2 + d*x + e"
				level_equation = level_equation.replace('d',str(self.possible_numbers[rng.randi_range(0,17)]))
				level_equation = level_equation.replace('e',str(self.possible_numbers[rng.randi_range(0,17)]))
			level_equation = level_equation.replace('a',str(self.possible_numbers[rng.randi_range(0,17)]))
			level_equation = level_equation.replace('b',str(self.possible_numbers[rng.randi_range(0,17)]))
			level_equation = level_equation.replace('c',str(self.possible_numbers[rng.randi_range(0,17)]))
		elif level_number == 4:
			level_question = "(a*x + b)*(c*x + d)"
			level_equation = level_equation.replace('a',str(self.possible_numbers[rng.randi_range(0,17)]))
			level_equation = level_equation.replace('b',str(self.possible_numbers[rng.randi_range(0,17)]))
			level_equation = level_equation.replace('c',str(self.possible_numbers[rng.randi_range(0,17)]))
			level_equation = level_equation.replace('d',str(self.possible_numbers[rng.randi_range(0,17)]))
		elif level_number == 5:
			possible_choice = rng.randi_range(0,1)
			level_question = "(a*x + b)*(c*x + d)"
			if possible_choice == 0:
				# GENERATE (ax+b)(cx+d)
				level_equation = level_equation.replace('a',str(self.possible_numbers[rng.randi_range(0,17)]))
				level_equation = level_equation.replace('b',str(self.possible_numbers[rng.randi_range(0,17)]))
				level_equation = level_equation.replace('c',str(self.possible_numbers[rng.randi_range(0,17)]))
				level_equation = level_equation.replace('d',str(self.possible_numbers[rng.randi_range(0,17)]))
			elif possible_choice == 1:
				# GENERATE (ax^2 + bx + c)(dx + e)
				level_question = "(a*x**2 + b*x + c)*(d*x + e)"
				level_equation = level_equation.replace('a',str(self.possible_numbers[rng.randi_range(0,17)]))
				level_equation = level_equation.replace('b',str(self.possible_numbers[rng.randi_range(0,17)]))
				level_equation = level_equation.replace('c',str(self.possible_numbers[rng.randi_range(0,17)]))
				level_equation = level_equation.replace('d',str(self.possible_numbers[rng.randi_range(0,17)]))
				level_equation = level_equation.replace('e',str(self.possible_numbers[rng.randi_range(0,17)]))
		elif level_number == 6:
			level_question = "(a*x + b)/(c*x + d)"
			level_equation = level_equation.replace('a',str(self.possible_numbers[rng.randi_range(0,17)]))
			level_equation = level_equation.replace('b',str(self.possible_numbers[rng.randi_range(0,17)]))
			level_equation = level_equation.replace('c',str(self.possible_numbers[rng.randi_range(0,17)]))
			level_equation = level_equation.replace('d',str(self.possible_numbers[rng.randi_range(0,17)]))
		elif level_number == 7:
			possible_choice = rng.randi_range(0,2)
			level_question = "(a*x + b)/(c*x + d)"
			if possible_choice == 1:
				level_question = "(a*x**2 + b*x + c)/(d*x + e)"
				level_equation = level_equation.replace('e',str(self.possible_numbers[rng.randi_range(0,17)]))
			elif possible_choice == 2:
				level_question = "(a*x + b)/(c*x**2 + d*x + e)"
				level_equation = level_equation.replace('e',str(self.possible_numbers[rng.randi_range(0,17)]))
			level_equation = level_equation.replace('a',str(self.possible_numbers[rng.randi_range(0,17)]))
			level_equation = level_equation.replace('b',str(self.possible_numbers[rng.randi_range(0,17)]))
			level_equation = level_equation.replace('c',str(self.possible_numbers[rng.randi_range(0,17)]))
			level_equation = level_equation.replace('d',str(self.possible_numbers[rng.randi_range(0,17)]))
		elif level_number == 8:
			level_question = "(a*x + b)**c"
			level_equation = level_equation.replace('a',str(self.possible_numbers[rng.randi_range(0,17)]))
			level_equation = level_equation.replace('b',str(self.possible_numbers[rng.randi_range(0,17)]))
			level_equation = level_equation.replace('c',str(rng.randi_range(4,8)))
		elif level_number == 9:
			possible_choice = rng.randi_range(0,2)
			level_question = "(a*x + b)**c"
			if possible_choice == 1:
				level_question = "d*(a*x + b)**c"
				level_equation = level_equation.replace('d',str(self.possible_numbers[rng.randi_range(0,17)]))
			elif possible_choice == 2:
				level_question = "(a*x**2 + b*x + d)**c"
				level_equation = level_equation.replace('d',str(self.possible_numbers[rng.randi_range(0,17)]))
			level_equation = level_equation.replace('a',str(self.possible_numbers[rng.randi_range(0,17)]))
			level_equation = level_equation.replace('b',str(self.possible_numbers[rng.randi_range(0,17)]))
			level_equation = level_equation.replace('c',str(rng.randi_range(4,8)))
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
