extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var itens: Node2D = $Itens
@onready var enemis: Node2D = $Enemy
@onready var checkpoints: Node2D = $Checkpoints

@onready var hud: CanvasLayer = $HUD
@onready var finish: Finish = $Finish

@export var next_level: PackedScene

var num_fruit:int = 0
var initial_position = Vector2(60, 179)

func _ready() -> void:
	for item in itens.get_children():
		if item is Fruit or FruitRandom:
			item.fruit_eaten.connect(_on_fruit_eaten)
	
	# Colisão de dano
	var dangerous = get_tree().get_nodes_in_group("Damage")
	
	for danger in dangerous:
		danger.get_parent().enemy_lean.connect(_on_enemy_lean)
	
	for chekpoint in checkpoints.get_children():
		if chekpoint is Checkpoint:
			chekpoint.checkpoint.connect(_on_checkpoint)
	finish.finish.connect(_on_finish)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("reset"):
		player.global_position = initial_position

func _on_checkpoint():
	initial_position = player.global_position
	
func _on_enemy_lean():
	print("Morreu")
	player.global_position = initial_position

func _on_finish():
	if next_level:
		get_tree().change_scene_to_packed(next_level)

func _on_fruit_eaten(quantity):
	hud.eat_fruit(quantity)
