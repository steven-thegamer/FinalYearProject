from godot import exposed, export
from godot import *
import sympy as sym
from sympy.simplify.fu import TR22

@exposed
class level_equation(Node):

	question = export(str)
	answer = export(str)
	all_answer_forms = []
	
	question_created = signal()
	
	possible_numbers = [1,2,3,4,5,6,7,8,9,0,-1,-2,-3,-4,-5,-6,-7,-8,-9]
	
	def _ready(self):
		self.generate_new_question()
	
	def sympify_equation(self,equation_string):
		x = sym.symbols('x')
		answer_expr = sym.sympify(str(equation_string))
		str_answer = str(answer_expr)
		return str_answer

	def generate_new_question(self):
		rng = RandomNumberGenerator()
		rng.randomize()
		x = sym.symbols('x')
		str_expr = ""
		
		possible_choice = rng.randi_range(0,1)
		
		if possible_choice == 0:
			# GENERATE (ax+b)(cx+d)
			for i in range(2):
				coeff = self.possible_numbers[rng.randi_range(0,18)]
				coeff_2 = self.possible_numbers[rng.randi_range(0,18)]
				str_expr_temp = str(coeff) + "*x + " + str(coeff_2)
				if i == 0:
					str_expr = "(" + str_expr_temp + ")*"
				else:
					str_expr += "(" + str_expr_temp + ")"
		elif possible_choice == 1:
			# GENERATE (ax^2 + bx + c)(dx + e)
			coeff = self.possible_numbers[rng.randi_range(0,17)]
			coeff_2 = self.possible_numbers[rng.randi_range(0,17)]
			const = self.possible_numbers[rng.randi_range(0,17)]
			str_expr_temp = str(coeff) + "*x**2 + " + str(coeff_2) + "*x + " + str(const)
			str_expr = "(" + str_expr_temp + ")*"
			
			coeff_3 = self.possible_numbers[rng.randi_range(0,17)]
			const = self.possible_numbers[rng.randi_range(0,17)]
			str_expr_temp = str(coeff_3) + "*x + " + str(const)
			str_expr += "(" + str_expr_temp + ")"
		
		expr_equation = sym.sympify(str_expr)
		self.question = str(expr_equation)
		self.answer = str(sym.diff(expr_equation,x))
		self.all_form_of_answers()
		self.call("emit_signal","question_created")

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
