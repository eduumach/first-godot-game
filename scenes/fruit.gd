extends Node2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed ti me since the previous frame.
func _process(delta: float) -> void:
	animation_player.play("apple")
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("Pegou fruta")
	queue_free()
