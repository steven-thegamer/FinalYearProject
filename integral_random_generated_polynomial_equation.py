from godot import *
import sympy as sym


@exposed
class polynomial_question(Node):

	# member variables here, example:
	question = export(str)
	answer = export(str)
	
	question_created = signal()

	def _ready(self):
		rng = RandomNumberGenerator()
		rng.randomize()
		x = sym.symbols('x')
		str_expr = ""
		size = rng.randi_range(1,5)
		for i in range(size,-1,-1):
			coeff = rng.randi_range(0,10) - 5
			if coeff < 0:
				str_expr += str(coeff) + "*x**" + str(i)
			elif coeff > 0:
				if str_expr != "":
					str_expr += "+" + str(coeff) + "*x**" + str(i)
				else:
					str_expr += str(coeff) + "*x**" + str(i)
		expr_equation = sym.sympify(str_expr)
		self.question = str(expr_equation)
		self.answer = str(sym.integrate(expr_equation,x)) + " + c"
		self.call("emit_signal","question_created")
