from godot import exposed, export
from godot import *
# This is importing the sympy library
import sympy as sym
# This is actually for tangents when derivating, but I like to just keep it here
# This thing has no purpose on this equation
from sympy.simplify.fu import TR22

@exposed
class equation_generator(Node):
	
	polynomial_equations = ['a*x**n','a*x+b','a*x**2+b*x+c','a*x**3+b*x**2+c*x+d']
	
	rng = None
	
	question = export(str)
	answer = export(str)
	# This array is for storing all possible answer forms from the function called all_form_of_answers below
	all_answer_forms = []
	# This creates a custom signal
	question_created = signal()
	
	possible_numbers = [1,2,3,4,5,6,7,8,9,-1,-2,-3,-4,-5,-6,-7,-8,-9]
	
	def _ready(self):
		rng = RandomNumberGenerator()
		rng.randomize()
	
	def generate_level_1(self):
		question = ''
		answer = ''
		x = sym.symbols('x')
		str_expr = polynomial_equations[0]
		size = rng.randi_range(2,5)
		# Select a random number from the array
		coeff = self.possible_numbers[rng.randi_range(0,17)]

		str_expr = str_expr.replace('a',str(coeff))
		str_expr = str_expr.replace('a',str(size))

		# This converts the string into a sympy format
		expr_equation = sym.sympify(str_expr)
		# Converts the sympy format back into a string and set as the equation
		self.question = str(expr_equation)
		# Derivate the sympy format into its derivative form, setting as the objective of the player
		self.answer = str(sym.diff(expr_equation,x))
		self.all_form_of_answers()
		# Emits a signal called question_created
		self.call("emit_signal","question_created")

	def sympify_equation(self,equation_string):
		x = sym.symbols('x')
		answer_expr = sym.sympify(str(equation_string))
		str_answer = str(answer_expr)
		return str_answer

	def all_form_of_answers(self):
		all_possible_answers = []
		x = sym.symbols('x')
		answer_expr = self.answer
		# Find all possible answers according to all possible ways to simplify the equation using SymPy
		for func in [sym.simplify, sym.expand, sym.factor, lambda expr: sym.collect(expr, x), sym.cancel, sym.apart]:
			temp = str(func(answer_expr))
			if temp not in all_possible_answers:
				all_possible_answers.append(temp)
		self.all_answer_forms = all_possible_answers
