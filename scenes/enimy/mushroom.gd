extends CharacterBody2D
class_name Eminy

@onready var respawn_point: Vector2 = global_position
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

signal enemy_lean

const SPEED = 50
const JUMP_VELOCITY = -300.0
const GRAVITY = 980
var jumps = 0
const MAX_JUMPS = 1

var direction = 1

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	animated_sprite_2d.play("run")
	velocity.y += GRAVITY * delta
	
	velocity.x = direction * SPEED
	
	var was_on_floor = is_on_floor()
	move_and_slide()
	
	if is_on_wall():
		direction *= -1
		
		if animated_sprite_2d:
			animated_sprite_2d.flip_h = (direction > 0)
			
	if was_on_floor and !is_on_floor() and velocity.y >= 0:
		direction *= -1
		if animated_sprite_2d:
			animated_sprite_2d.flip_h = (direction < 0)
		global_position.x -= direction * 10

func _on_area_2d_body_entered(body: Node2D) -> void:
	enemy_lean.emit()
