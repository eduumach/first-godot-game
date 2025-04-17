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
	velocity.y += GRAVITY * delta
	
	# Move
	var direction = Input.get_axis("walk_left", "walk_right")
	velocity.x = direction * SPEED
	
	if direction > 0:
		player.flip_h = false
	elif direction < 0:
		player.flip_h = true
	
	if Input.is_action_just_pressed("jump") and jumps < MAX_JUMPS:
		velocity.y = JUMP_VELOCITY
		jumps += 1
	
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
	
