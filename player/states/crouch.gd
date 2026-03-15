class_name PlayerStateCrouch extends PlayerState

@export var deceleration_speed: float = 10

func init() -> void:
	#print("init! ", name)
	pass
	
func enter() -> void:
	player.animation_player.play("crouch")
	
	player.collision_stand.disabled = true
	player.collision_crouch.disabled = false
	
func exit() -> void:
	#print("exit! ", name)
	player.collision_stand.disabled = false
	player.collision_crouch.disabled = true
	
func handle_inpud(_event: InputEvent) -> PlayerState:
	if _event.is_action_pressed("JUMP"):
		player.on_way_platform_shape_cast.force_shapecast_update()
		if player.on_way_platform_shape_cast.is_colliding():
			player.position.y += 4
			return fall
		return jump
	return next_state

func process(_delta: float) -> PlayerState:
	if player.direction.y <= 0.5:
		return idle
	return next_state
	
func physics_process(_delta: float) -> PlayerState:
	player.velocity.x -= player.velocity.x * deceleration_speed * _delta
	if not player.is_on_floor():
		print("dsfdsfds");
		return fall
	return next_state
