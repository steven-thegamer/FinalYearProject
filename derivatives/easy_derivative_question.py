from godot import exposed, export
from godot import *
import sympy as sym
from sympy.simplify.fu import TR22

@exposed
class easy_derivative_question(Node):

	question = export(str)
	answer = export(str)
	
	question_created = signal()
	
	logarithm_function = ["log","exp"]
	trigonometry_type = ['sin','cos','tan']
	possible_numbers = [1,2,3,4,5,6,7,8,9,-1,-2,-3,-4,-5,-6,-7,-8,-9]
	
	def _ready(self):
		rng = RandomNumberGenerator()
		rng.randomize()
		x = sym.symbols('x')
		str_expr = ""
		question_type = rng.randi_range(0,2)
		if question_type % 3 == 0: # Polynomial
			size = rng.randi_range(1,3)
			for i in range(size,-1,-1):
				coeff = self.possible_numbers[rng.randi_range(0,17)]
				if coeff < 0:
					str_expr += str(coeff) + "*x**" + str(i)
				elif coeff > 0:
					if str_expr != "":
						str_expr += "+" + str(coeff) + "*x**" + str(i)
					else:
						str_expr += str(coeff) + "*x**" + str(i)
		elif question_type % 3 == 1: # Trigonometry
			trigonometry_function = self.trigonometry_type[rng.randi_range(0,2)]
			coeff = self.possible_numbers[rng.randi_range(0,17)]
			size = rng.randi_range(1,2)
			equation_in_trig_function = ""
			for i in range(size,-1,-1):
				coeff = self.possible_numbers[rng.randi_range(0,17)]
				if coeff < 0:
					equation_in_trig_function += str(coeff) + "*x**" + str(i)
				elif coeff > 0:
					if equation_in_trig_function != "":
						equation_in_trig_function += "+" + str(coeff) + "*x**" + str(i)
					else:
						equation_in_trig_function += str(coeff) + "*x**" + str(i)
			exponential_value = 1
			str_expr = str(coeff) + "*" + trigonometry_function + "(" + str(equation_in_trig_function) + ")"
		else: # Logarithm
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
		if question_type % 3 == 1 and trigonometry_function == "tan":
			self.answer = str(TR22(sym.sympify(self.answer)))
		self.call("emit_signal","question_created")
	
	def sympify_equation(self,equation_string):
		x = sym.symbols('x')
		answer_expr = sym.sympify(str(equation_string))
		str_answer = str(answer_expr)
		return str_answer
