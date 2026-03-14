class_name PlayerStateFall extends PlayerState

@export var ciyote_time: float = 0.125
@export var fall_gravity_multiplier: float = 1.165
@export var jump_buffer_time: float = 0.2

var coyote_timer: float = 0;
var jump_buffer_timer: float = 0;

func init() -> void:
	print("init! ", name)
	
func enter() -> void:
	player.animation_player.play("fall")
	#player.animation_player.pause()
	
	player.gravity_multiplier = fall_gravity_multiplier
	if player.previous_state == jump:
		coyote_timer = 0
	else:
		coyote_timer = ciyote_time
	
func exit() -> void:
	print("exit! ", name)
	player.gravity_multiplier = 1.0
	
func handle_inpud(_event: InputEvent) -> PlayerState:
	if _event.is_action_pressed("JUMP"):
		if coyote_timer > 0:
			return jump
		else:
			coyote_timer = ciyote_time		
	return next_state

func process(_delta: float) -> PlayerState:
	player.velocity.x = player.direction.x * player.move_speed
	coyote_timer -= _delta
	jump_buffer_timer -= _delta
	#set_jump_frame()
	return next_state
	
func physics_process(_delta: float) -> PlayerState:
	if player.is_on_floor():
		player.add_debug_indicator(Color.RED)
		if jump_buffer_timer > 0:
			return jump	
			
		return idle
	
	return next_state
	
func set_jump_frame() -> void:
	var frame : float = remap(player.velocity.y, 0.0, player.max_fall_velocity, 0, 0.5)
	player.animation_player.seek(frame, true)
	pass
