tool
extends Node2D

onready var paper = $NinePatchRect

export (int) var width = 1024
export (int) var height = 648

func _process(delta):
	paper.rect_size = Vector2(width,height)
