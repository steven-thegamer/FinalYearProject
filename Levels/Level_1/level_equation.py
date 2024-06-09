from godot import exposed, export
from godot import *
import sympy as sym
from sympy.simplify.fu import TR22

@exposed
class level_equation(Node):

	question = export(str)
	answer = export(str)
	
	question_created = signal()
	
	possible_numbers = [1,2,3,4,5,6,7,8,9,-1,-2,-3,-4,-5,-6,-7,-8,-9]
	
	def _ready(self):
		rng = RandomNumberGenerator()
		rng.randomize()
		x = sym.symbols('x')
		str_expr = ""
		size = rng.randi_range(1,5)
		coeff = self.possible_numbers[rng.randi_range(0,17)]
		str_expr = str(coeff) + "*x**" + str(size)
		expr_equation = sym.sympify(str_expr)
		self.question = str(expr_equation)
		self.answer = str(sym.diff(expr_equation,x))
		self.call("emit_signal","question_created")
	
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
		size = rng.randi_range(1,5)
		coeff = self.possible_numbers[rng.randi_range(0,17)]
		str_expr = str(coeff) + "*x**" + str(size)
		expr_equation = sym.sympify(str_expr)
		self.question = str(expr_equation)
		self.answer = str(sym.diff(expr_equation,x))
		self.call("emit_signal","question_created")
