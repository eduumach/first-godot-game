extends Node2D

@onready var player: Sprite2D = $Player

func _ready() -> void:
	player.position.x = 50
	player.position.y = 50
	
	

func _process(delta: float) -> void:
	var speed = 4
	const screen_w = 640
	const screen_h = 360 
	var direction_x = Input.get_axis("ui_left", "ui_right")
	var direction_y = Input.get_axis("ui_up", "ui_down")
	
	if direction_x != 0 and direction_y !=0:
		speed = 3
	
	player.position.x += direction_x * speed
	player.position.y += direction_y * speed
	
	if direction_x > 0:
		player.flip_h = false
	elif direction_x < 0:
		player.flip_h = true
		
	if player.position.x < 8:
		player.position.x = 8
	elif player.position.x > screen_w - 8:
		player.position.x = screen_w - 8
	
	if player.position.y < 8:
		player.position.y = 8
	elif player.position.y > screen_h - 16:
		player.position.y = screen_h - 16
