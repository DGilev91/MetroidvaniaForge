class_name  Player extends CharacterBody2D

@onready var states_node: Node = $States

#region //State Machine Variables
var states: Array[PlayerState]
var current_state: PlayerState:
	get: return states.front()
var previous_state: PlayerState:
	get: return states[1]
#endregion

#region /// standart variables
var direction: Vector2 = Vector2.ZERO
var gravity: float = 980
#endregion


func _ready() -> void:
	initialize_states()

func _process(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:	
	pass

func initialize_states() -> void:
	states = []
	for n in states_node.get_children():
		if n is PlayerState:
			n.player = self
			states.append(n)
			
	for state in states:
		state.init()
