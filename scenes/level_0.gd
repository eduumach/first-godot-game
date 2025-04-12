extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var itens: Node2D = $Itens

var num_fruit:int = 0
var initial_position = Vector2(60, 179)

func _ready() -> void:
	for item in itens.get_children():
		if item is Fruit or FruitRandom:
			item.fruit_eaten.connect(_on_fruit_eaten)


func _on_fruit_eaten():
	num_fruit += 1
	player.global_position = initial_position
	print("Já comeu ", num_fruit)
