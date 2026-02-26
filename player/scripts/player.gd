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
	
func _unhandled_input(event: InputEvent) -> void:
	change_state(current_state.handle_inpud(event))

func _process(_delta: float) -> void:	
	update_direction()
	change_state(current_state.process(_delta))
	
func _physics_process(_delta: float) -> void:	
	velocity.y += gravity * _delta
	move_and_slide()
	change_state(current_state.physics_process(_delta))

func initialize_states() -> void:
	states = []
	for n in states_node.get_children():
		if n is PlayerState:
			n.player = self
			states.append(n)
			
	for state in states:
		state.init()
		
	change_state(current_state)
	current_state.enter()
		
func change_state(new_state: PlayerState) -> void:
	if new_state == null:
		return
	elif new_state == current_state:
		return
	
	if current_state:
		current_state.exit()
	states.push_front(new_state)
	current_state.enter()
	states.resize(states.size() - 1)

func update_direction() -> void:
	#var prev_direction: Vector2 = direction
	direction = Input.get_vector("LEFT", "RIGHT", "UP", "DOWN") 
	
