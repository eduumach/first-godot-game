extends Node2D

class_name FruitRandom
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D

signal fruit_eaten

@export var list_fruits: Array[Texture2D]


func _ready() -> void:
	var n = randi_range(0, list_fruits.size()-1)
	sprite_2d.texture = list_fruits[n]
	


func _process(delta: float) -> void:
	animation_player.play("apple")
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	fruit_eaten.emit()
	queue_free()
