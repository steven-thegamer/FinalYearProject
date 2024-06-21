from godot import exposed, export
from godot import *
import sympy as sym
from sympy.simplify.fu import TR22

@exposed
class level_equation(Node):

	def sympify_equation(self,equation_string):
		x = sym.symbols('x')
		answer_expr = sym.sympify(str(equation_string))
		str_answer = str(answer_expr)
		return str_answer
