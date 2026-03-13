class_name PlayerStateCrouch extends PlayerState

@export var deceleration_speed: float = 10

func init() -> void:
	print("init! ", name)
	
func enter() -> void:
	player.animation_player.play("crouch")
	
	player.collision_stand.disabled = true
	player.collision_crouch.disabled = false
	player.sprite.scale.y = 0.583
	player.sprite.position.y = -14
	
func exit() -> void:
	print("exit! ", name)
	player.collision_stand.disabled = false
	player.collision_crouch.disabled = true
	player.sprite.scale.y = 1.0
	player.sprite.position.y = -24
	
func handle_inpud(_event: InputEvent) -> PlayerState:
	if _event.is_action_pressed("JUMP"):
		if player.on_way_platform_raycast.is_colliding():
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
		return fall
	return next_state
