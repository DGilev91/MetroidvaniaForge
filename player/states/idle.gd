class_name PlayerStateIdle extends PlayerState

func init() -> void:
	print("init! ", name)
	
func enter() -> void:
	print("enter! ", name)
	
func exit() -> void:
	print("exit! ", name)
	
func handle_inpud(_event: InputEvent) -> PlayerState:
	if _event.is_action_pressed("JUMP"):
		return jump
	return next_state

func process(_delta: float) -> PlayerState:
	if player.direction.x != 0:
		return run
	elif player.direction.y > 0.5:
		return crouch
	
		
	return next_state
	
func physics_process(delta: float) -> PlayerState:
	player.velocity.x = 0
	if not player.is_on_floor():
		return fall
	return next_state
