from godot import *
import sympy as sym


@exposed
class polynomial_question(Node):

	numerator = export(str)
	denumerator = export(str)
	question = export(str)
	answer = export(str)
	
	question_created = signal()
	
	possible_numbers = [1,2,3,4,5,6,7,8,-1,-2,-3,-4,-5,-6,-7,-8]
	
	def _ready(self):
		rng = RandomNumberGenerator()
		rng.randomize()
		x = sym.symbols('x')
		
		str_expr = ""
		size = rng.randi_range(1,4)
		for i in range(size,-1,-1):
			coeff = self.possible_numbers[rng.randi_range(0,15)]
			if coeff < 0:
				str_expr += str(coeff) + "*x**" + str(i)
			elif coeff > 0:
				if str_expr != "":
					str_expr += "+" + str(coeff) + "*x**" + str(i)
				else:
					str_expr += str(coeff) + "*x**" + str(i)
		expr_equation_numerator = sym.sympify(str_expr)
		self.numerator = str(expr_equation_numerator)
		
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
		expr_equation_denumerator = sym.sympify(str_expr)
		self.denumerator = str(expr_equation_denumerator)
		
		fraction_question = expr_equation_numerator / expr_equation_denumerator
		self.question = str(fraction_question)
		right_fraction_answer = sym.diff(fraction_question,x)
		simplified_answer = sym.factor(right_fraction_answer)
		self.answer = str(simplified_answer)
		self.call("emit_signal","question_created")
