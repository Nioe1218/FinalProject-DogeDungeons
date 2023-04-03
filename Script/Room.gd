extends Node2D

const SPAWN_explosion_scene: PackedScene = preload("res://Object/SpawnExplosion.tscn")

const ENEMY_SCENES: Dictionary= {
	"BATENEMY": preload("res://Object/BATEnemy.tscn"),
	"RANGENEMY":preload("res://Object/rangenemy.tscn")
}

var num_enemies: int 

onready var tilemap:TileMap = get_node("TileMap2")

onready var entrance: Node2D = get_node("Entrance")

onready var door_container: Node2D = get_node("Doors")

onready var enemy_position_container: Node2D = get_node("EnemyPositions")

onready var player_detector:Area2D = get_node("Player Detector")

func _ready():
	num_enemies = enemy_position_container.get_child_count()
	
	
func _on_enemy_killed():
	num_enemies -=1
	if num_enemies == 0:
		_open_doors()
	
func _open_doors():
	for door in door_container.get_children():
		door.open()
		
func _close_entrance():
	for entry_position in entrance.get_children():
		tilemap.set_cellv(tilemap.world_to_map(entry_position.position),1)
		tilemap.set_cellv(tilemap.world_to_map(entry_position.position)+Vector2.DOWN,2)
		
func _spawn_enemies():
	for enemy_position in enemy_position_container.get_children():
		var enemy: KinematicBody2D
		if randi()% 2 ==0:
			enemy = ENEMY_SCENES.BATENEMY.instance()
		else:
			enemy = ENEMY_SCENES.RANGENEMY.instance()
		var __ = enemy.connect("tree_exited",self,"_on_enemy_killed")
		enemy.position= enemy_position.position
		call_deferred("add_child",enemy)
		
		var spawn_explosion: AnimatedSprite = SPAWN_explosion_scene.instance()
		spawn_explosion.position = enemy_position.position 
		call_deferred("add_child",spawn_explosion)

func _on_Player_Detector_body_entered(_body:KinematicBody2D):#check if there are enemies in the room
	player_detector.queue_free()
	if num_enemies>0:
		_close_entrance()
		_spawn_enemies()
	else:
		_open_doors()
