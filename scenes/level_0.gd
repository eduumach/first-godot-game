extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var itens: Node2D = $Itens

var num_fruit:int = 0

func _ready() -> void:
	for item in itens.get_children():
		if item is Fruit:
			item.fruit_eaten.connect(_on_fruit_eaten)


func _on_fruit_eaten():
	num_fruit += 1
	print("Já comeu ", num_fruit)
