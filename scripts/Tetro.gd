extends Node

class_name Tetro

var Points = Array()
var LimitX
var LimitY
var color

func down():
	for p in Points:
		if p.i >= LimitY:
			return false
		p.i+=1
	return true
