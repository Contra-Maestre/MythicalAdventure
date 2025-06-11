class_name  StateMachine
extends Node

signal stateChanged(stateName)

@export var initialState := NodePath()

@onready var state : State = get_node(initialState)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await (owner.ready)
	for child in get_children():
		child.stateMachine = self
	state.StateEnter()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	state.StateProcess(delta)

func _physics_process(delta: float) -> void:
	state.StatePhysicsProcess(delta)

func _unhandled_input(event: InputEvent) -> void:
	state.StateInput(event)

func TransitionTo(targetState : String, msg : Dictionary = {}):
	if not has_node(targetState):
		return
	
	state.StateExit()
	state.get_node(targetState)
	state.StateEnter(msg)
	emit_signal("stateChanged", state.name)
	
	
	
	
