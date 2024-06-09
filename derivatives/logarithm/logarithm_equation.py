from godot import exposed, export
from godot import *
import sympy as sym

@exposed
class logarithm_equation(Node):

	# member variables here, example:
	question = export(str)
	answer = export(str)
	question_created = signal()

	logarithm_function = ["log","exp"]
	possible_numbers = [1,2,3,4,5,6,7,8,-1,-2,-3,-4,-5,-6,-7,-8]

	def _ready(self):
		rng = RandomNumberGenerator()
		rng.randomize()
		x = sym.symbols('x')
		str_expr = ""
		log_function = self.logarithm_function[rng.randi_range(0,1)]
		polynomial_eq = ""
		size = 1
		for i in range(size,-1,-1):
			coeff = self.possible_numbers[rng.randi_range(0,15)]
			if coeff < 0:
				polynomial_eq += str(coeff) + "*x**" + str(i)
			elif coeff > 0:
				if polynomial_eq != "":
					polynomial_eq += "+" + str(coeff) + "*x**" + str(i)
				else:
					polynomial_eq += str(coeff) + "*x**" + str(i)
		str_expr = log_function + "(" + polynomial_eq + ")"
		expr_equation = sym.sympify(str_expr)
		self.question = str(expr_equation)
		self.answer = str(sym.diff(expr_equation,x))
		self.call("emit_signal","question_created")
