extends Node

class_name Tetro

var Points = Array()
var color

func down():
	for p in Points:
		p.i+=1
