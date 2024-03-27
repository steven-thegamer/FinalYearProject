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
		expr_equation_1 = "(" + str(str_expr) + ")"

		str_expr = ""
		size = rng.randi_range(1,2)
		for i in range(size,-1,-1):
			coeff = rng.randi_range(0,10) - 5
			if coeff < 0:
				str_expr += str(coeff) + "*x**" + str(i)
			elif coeff > 0:
				if str_expr != "":
					str_expr += "+" + str(coeff) + "*x**" + str(i)
				else:
					str_expr += str(coeff) + "*x**" + str(i)
		expr_equation_2 = "(" + str(str_expr) + ")"
		combine_equation = expr_equation_1 + "*" + expr_equation_2
		expr_equation = sym.sympify(combine_equation)
		self.question = str(expr_equation)
		simplified_equation = sym.simplify(expr_equation)
		differentiate_answer = sym.diff(simplified_equation,x)
		simplified_answer = sym.simplify(differentiate_answer)
		self.answer = str(simplified_answer)
		self.call("emit_signal","question_created")
