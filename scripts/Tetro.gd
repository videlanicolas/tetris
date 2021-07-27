extends Node

class_name Tetro

var Points = Array()
var color

func down():
	for p in Points:
		p.i+=1

func square_belongs(i: int, j: int):
	for p in Points:
		if p.i == i and p.j == j:
			return true
	return false
