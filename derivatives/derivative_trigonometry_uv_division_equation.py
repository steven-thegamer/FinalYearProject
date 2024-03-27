from godot import *
import sympy as sym


@exposed
class polynomial_question(Node):

	numerator = export(str)
	denumerator = export(str)
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
		exponential_value = 1
		expr_equation = str(coeff) + "*" + trigonometry_function + "(" + str(str_expr) + ")" + "**" + str(exponential_value)
		expr_equation_numerator = sym.sympify(expr_equation)
		self.numerator = str(expr_equation_numerator)
		
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
		exponential_value = 1
		expr_equation = str(coeff) + "*" + trigonometry_function + "(" + str(str_expr) + ")" + "**" + str(exponential_value)
		expr_equation_denumerator = sym.sympify(expr_equation)
		self.denumerator = str(expr_equation_denumerator)
		
		fraction_question = expr_equation_numerator / expr_equation_denumerator
		self.question = str(fraction_question)
		right_fraction_answer = sym.diff(fraction_question,x)
		simplified_answer = sym.factor(right_fraction_answer)
		self.answer = str(simplified_answer)
		self.call("emit_signal","question_created")
