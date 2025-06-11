class_name State
extends Node

var stateMachine = null


func StateInput(_event : InputEvent):
	pass

func StateProcess(delta):
	pass

func StatePhysicsProcess(delta):
	pass

func StateReady():
	pass

func StateEnter(msg := {}):
	pass

func StateExit():
	pass
