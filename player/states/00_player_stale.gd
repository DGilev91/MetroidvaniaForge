@icon("res://player/states/state.svg")
class_name PlayerState extends Node


var player: Player
var next_state: PlayerState

#region /// state references
# references to all states
@onready var idle: PlayerStateIdle = %Idle
@onready var run: PlayerStateRun = %Run
@onready var jump: PlayerStateJump = %Jump
@onready var fall: PlayerStateFall = %Fall
@onready var crouch: PlayerStateCrouch = %Crouch
#endregion

func init() -> void:
	print("init! ", name)
	
func enter() -> void:
	print("enter! ", name)
	
func exit() -> void:
	print("exit! ", name)
	
func handle_inpud(_event: InputEvent) -> PlayerState:
	return next_state

func process(_delta: float) -> PlayerState:
	
	return next_state
	
func physics_process(_delta: float) -> PlayerState:
	return next_state
