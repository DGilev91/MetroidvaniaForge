class_name PlayerStateIdle extends PlayerState

func init() -> void:
	print("init! ", name)
	
func enter() -> void:
	print("enter! ", name)
	
func exit() -> void:
	print("exit! ", name)
	
func handle_inpud(_event: InputEvent) -> PlayerState:
	return next_state

func process(_delta: float) -> PlayerState:
	if player.direction.x != 0:
		return run
	return next_state
	
func physics_process(delta: float) -> PlayerState:
	player.velocity.x = 0
	return next_state
