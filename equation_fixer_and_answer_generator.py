from godot import exposed, export, Node
from godot import *
import sympy as sym
from sympy.simplify.fu import TR22

@exposed
class equation_fixer_and_answer_generator(Node):

	# Generates all possible form of answers
	def all_derivative_answers(self,question):
		x = sym.symbols('x')
		answer_expr = str(sym.diff(question,x))
		all_possible_answers = Array()
		all_possible_answers.append(answer_expr)
		# Find all possible answers according to all possible ways to simplify the equation using SymPy
		for func in [sym.simplify, sym.expand, sym.factor, lambda expr: sym.collect(expr, x), sym.cancel, sym.apart]:
			temp = str(func(answer_expr))
			if temp not in all_possible_answers:
				all_possible_answers.append(temp)
		return all_possible_answers
	
	# This code converts the equation into a proper sympy format
	def sympify_equation(self,equation_string):
		x = sym.symbols('x')
		answer_expr = sym.sympify(str(equation_string))
		str_answer = str(answer_expr)
		return str_answer
