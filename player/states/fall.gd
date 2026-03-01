class_name PlayerStateFall extends PlayerState

func init() -> void:
	print("init! ", name)
	
func enter() -> void:
	print("enter! ", name)
	
func exit() -> void:
	print("exit! ", name)
	
func handle_inpud(_event: InputEvent) -> PlayerState:
	return next_state

func process(_delta: float) -> PlayerState:
	player.velocity.x = player.direction.x * player.move_speed
	return next_state
	
func physics_process(delta: float) -> PlayerState:
	if player.is_on_floor():
		player.add_debug_indicator(Color.RED)
		return idle
	
	return next_state
