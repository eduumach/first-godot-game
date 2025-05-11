extends Node2D
class_name Fruit

@onready var animation_player: AnimationPlayer = $AnimationPlayer

signal fruit_eaten

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed ti me since the previous frame.
func _process(delta: float) -> void:
	animation_player.play("apple")
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	fruit_eaten.emit() 
	queue_free()
