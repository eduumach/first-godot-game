extends Node2D

class_name Checkpoint

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

signal checkpoint

func _ready() -> void:
	animated_sprite_2d.play("default")
	animated_sprite_2d.animation_finished.connect(_on_animation_finished)

func _on_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "flag_out":
		animated_sprite_2d.play("idle")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		animated_sprite_2d.play("flag_out")
		checkpoint.emit()
