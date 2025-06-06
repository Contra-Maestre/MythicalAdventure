extends Node

@onready var fruitSond := $FruitSonido

@export var fruit := 0 :
	set (val):
		fruit = val
		if player != null:
			player.actualizaInterfrazFrutas()
			fruitSond.play()

var player : CharacterBody2D
