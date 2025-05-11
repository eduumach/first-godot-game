extends CharacterBody2D
class_name Player

@onready var player: Sprite2D = $Sprite2D
@onready var respawn_point: Vector2 = global_position
@onready var animation_player: AnimationPlayer = $AnimationPlayer

const SPEED = 250.0
const JUMP_VELOCITY = -300.0
const GRAVITY = 980
var jumps = 0
const MAX_JUMPS = 1

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	# Only process input for the player we control
	if not is_multiplayer_authority(): return
	
	velocity.y += GRAVITY * delta

	# Move
	var direction = Input.get_axis("walk_left", "walk_right")
	velocity.x = direction * SPEED

	if direction > 0:
		player.flip_h = false
		sync_state.rpc(position, velocity, player.flip_h)
	elif direction < 0:
		player.flip_h = true
		sync_state.rpc(position, velocity, player.flip_h)

	if Input.is_action_just_pressed("jump") and jumps < MAX_JUMPS:
		velocity.y = JUMP_VELOCITY
		jumps += 1
		sync_state.rpc(position, velocity, player.flip_h)

	if direction != 0:
		animation_player.play("walk")
	else:
		animation_player.play("idle")

	if is_on_floor():
		jumps = 0
	else:
		if velocity.y < 0:
			animation_player.play("jump")
		else:
			animation_player.play("fall")

	move_and_slide()
	# Sync final position after move_and_slide
	sync_state.rpc(position, velocity, player.flip_h)

@rpc("unreliable", "any_peer")
func sync_state(pos: Vector2, vel: Vector2, flip_h: bool):
	if is_multiplayer_authority(): return
	
	position = pos
	velocity = vel
	player.flip_h = flip_h
	
	# Update animations based on state
	if velocity.x != 0:
		animation_player.play("walk")
	else:
		animation_player.play("idle")
		
	if not is_on_floor():
		if velocity.y < 0:
			animation_player.play("jump")
		else:
			animation_player.play("fall")
