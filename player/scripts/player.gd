class_name  Player extends CharacterBody2D

const DEBUG_JUMP_INDICATOR = preload("uid://cn3pv6slcb2b2")

#region //onready 
@onready var sprite: Sprite2D = $Sprite2D
@onready var collision_stand: CollisionShape2D = $CollisionStand
@onready var collision_crouch: CollisionShape2D = $CollisionCrouch
@onready var on_way_platform_shape_cast: ShapeCast2D = $OnWayPlatformShapeCast
@onready var animation_player: AnimationPlayer = $AnimationPlayer
#endregion

#region //export variables
@export var move_speed: float  = 300
@export var max_fall_velocity : float = 600.0
#endregion


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
var gravity_multiplier: float = 1.0
#endregion


func _ready() -> void:
	floor_snap_length = 10
	#Engine.time_scale = 0.5
	initialize_states()
	
func _unhandled_input(event: InputEvent) -> void:
	change_state(current_state.handle_inpud(event))

func _process(_delta: float) -> void:	
	update_direction()
	change_state(current_state.process(_delta))
	
func _physics_process(_delta: float) -> void:	
	velocity.y += gravity * gravity_multiplier * _delta
	velocity.y = clampf(velocity.y, -1000.0, max_fall_velocity)
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
	$Label.text = current_state.name
		
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
	$Label.text = current_state.name

func update_direction() -> void:	
	var prev_direction: Vector2 = direction
	var x_axis = Input.get_axis("LEFT", "RIGHT")
	var y_axis = Input.get_axis("UP", "DOWN")	
	direction = Vector2(x_axis, y_axis)
	
	if prev_direction.x != direction.x && direction.x != 0:
		sprite.flip_h = false if direction.x > 0 else true
	
func add_debug_indicator(color: Color = Color.RED) -> void:
	#var d: Node2D = DEBUG_JUMP_INDICATOR.instantiate()
	#get_tree().root.add_child(d)
	#d.global_position = global_position
	#d.modulate = color
	#await get_tree().create_timer(3.0).timeout
	#d.queue_free()
	pass
	
	
