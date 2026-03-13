class_name PlayerStateJump extends PlayerState

@export var jump_velocity: float = 450.0



func init() -> void:
	print("init! ", name)
	
func enter() -> void:
	player.animation_player.play("jump")
	
	player.add_debug_indicator(Color.LIGHT_GREEN)
	player.velocity.y = -jump_velocity
	
func exit() -> void:
	print("exit! ", name)
	player.add_debug_indicator(Color.YELLOW)
	
func handle_inpud(_event: InputEvent) -> PlayerState:
	if _event.is_action_released("JUMP"):
		player.velocity.y *= 0.5
		return fall
	return next_state

func process(_delta: float) -> PlayerState:
	return next_state
	
func physics_process(_delta: float) -> PlayerState:
	if player.is_on_floor():
		return idle
	if player.velocity.y >= 0:
		return fall
	player.velocity.x = player.direction.x * player.move_speed
		
	return next_state
