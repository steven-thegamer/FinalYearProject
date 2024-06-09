from godot import *
import sympy as sym


@exposed
class polynomial_question(Node):

	# member variables here, example:
	question = export(str)
	answer = export(str)
	
	question_created = signal()
	
	possible_numbers = [1,2,3,4,5,6,7,8,-1,-2,-3,-4,-5,-6,-7,-8]

	def _ready(self):
		rng = RandomNumberGenerator()
		rng.randomize()
		x = sym.symbols('x')
		str_expr = ""
		size = rng.randi_range(1,2)
		for i in range(size,-1,-1):
			coeff = self.possible_numbers[rng.randi_range(0,15)]
			if coeff < 0:
				str_expr += str(coeff) + "*x**" + str(i)
			elif coeff > 0:
				if str_expr != "":
					str_expr += "+" + str(coeff) + "*x**" + str(i)
				else:
					str_expr += str(coeff) + "*x**" + str(i)
		expr_equation = sym.sympify(str_expr)
		self.question = str(expr_equation)
		self.answer = str(sym.diff(expr_equation,x))
		self.call("emit_signal","question_created")
