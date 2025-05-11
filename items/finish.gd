extends Node2D

class_name Finish

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

signal finish

func _ready() -> void:
	animated_sprite_2d.play("idle")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		animated_sprite_2d.play("pressed")
		finish.emit()
