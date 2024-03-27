from godot import *
import sympy as sym


@exposed
class trigonometry_question(Node):

	# member variables here, example:
	question = export(str)
	answer = export(str)
	
	question_created = signal()
	
	trigonometry_type = ['sin','cos','tan','csc','sec','cot']
	
	possible_numbers = [1,2,3,4,5,6,7,8,-1,-2,-3,-4,-5,-6,-7,-8]

	def _ready(self):
		rng = RandomNumberGenerator()
		rng.randomize()
		x = sym.symbols('x')
		str_expr = ""
		coeff = rng.randi_range(1,5)
		trigonometry_function = self.trigonometry_type[rng.randi_range(0,5)]
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
		exponential_value = rng.randi_range(1,2)
		expr_equation = str(coeff) + "*" + trigonometry_function + "(" + str(str_expr) + ")" + "**" + str(exponential_value)
		expr_equation = sym.sympify(expr_equation)
		self.question = str(expr_equation)
		diff_answer = sym.diff(expr_equation,x)
		new_diff_answer = sym.simplify(diff_answer)
		self.answer = str(new_diff_answer)
		self.call("emit_signal","question_created")
