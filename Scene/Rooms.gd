extends Navigation2D


const SPAWN_ROOMS: Array =[preload("res://Scene/SpawnRoom1.tscn"),preload("res://Scene/SpawnRoom1.tscn")]

const INTERMEDIATE_ROOMS: Array=[preload("res://Scene/Room0.tscn"),preload("res://Scene/Room1.tscn"),preload("res://Scene/Room4.tscn")]

const BIG_ROOMS :Array = [preload("res://Scene/BigRoom1.tscn"),preload("res://Scene/Bigroom2.tscn")]

const END_ROOM: Array=[preload("res://Scene/EndRoom0.tscn")]

const TILE_SIZE: int = 16

const FLOOR_TILE_INDEX: int =64

const RIGHT_WALL_TILE_INDEX: int =66
const LEFT_WALL_TILE_INDEX: int =68

export (int)var num_levels:int =5

onready var player: KinematicBody2D =get_parent().get_node("Player")

func _ready():
	Savedata.num_floor += 1
	if Savedata.num_floor >1:
		num_levels +1
	_spawn_rooms()
	
func _spawn_rooms():
	var previous_room:Node2D
	var bigroom_spawned:bool = false
	for i in num_levels:
		var room:Node2D
		if i == 0:#spawn the spawnroom first
			room = SPAWN_ROOMS[randi()% SPAWN_ROOMS.size()].instance()
			player.position = room.get_node("PlayerSpawnPosition").position#move the player to the spawn position
		else:
			if i ==num_levels -1:# end room will spawn at the end
				room = END_ROOM[randi()%END_ROOM.size()].instance()
			else:#will spawn bigroom every time
				if (randi() % 3 == 0 and not bigroom_spawned) or (i == num_levels - 2 and not bigroom_spawned):
						room = BIG_ROOMS[randi() % BIG_ROOMS.size()].instance()
						bigroom_spawned = true
				else:
					room = INTERMEDIATE_ROOMS[randi()%INTERMEDIATE_ROOMS.size()].instance()
		
			var previous_room_tilemap:TileMap = previous_room.get_node("TileMap")
			var previous_room_door: StaticBody2D = previous_room.get_node("Doors/Door")
			var exit_tile_pos:Vector2=previous_room_tilemap.world_to_map(previous_room_door.position)+Vector2.UP*1
			
			var corridor_height:int = randi ()%5+3
			for y in corridor_height:#connect each room
				previous_room_tilemap.set_cellv(exit_tile_pos+Vector2(-3,-y),LEFT_WALL_TILE_INDEX)
				previous_room_tilemap.set_cellv(exit_tile_pos+Vector2(-2,-y),FLOOR_TILE_INDEX)
				previous_room_tilemap.set_cellv(exit_tile_pos+Vector2(-1,-y),FLOOR_TILE_INDEX)
				previous_room_tilemap.set_cellv(exit_tile_pos+Vector2(0,-y),FLOOR_TILE_INDEX)
				previous_room_tilemap.set_cellv(exit_tile_pos+Vector2(1,-y),FLOOR_TILE_INDEX)
				previous_room_tilemap.set_cellv(exit_tile_pos+Vector2(2,-y),FLOOR_TILE_INDEX)
				previous_room_tilemap.set_cellv(exit_tile_pos+Vector2(3,-y),RIGHT_WALL_TILE_INDEX)
			
			var room_tilemap:TileMap= room.get_node("TileMap")
			room.position = previous_room_door.global_position+Vector2.UP* room_tilemap.get_used_rect().size.y*TILE_SIZE+Vector2.UP*(0+corridor_height)*TILE_SIZE+Vector2.LEFT*room_tilemap.world_to_map(room.get_node("Entrance/Position2D2").position).x*TILE_SIZE
		add_child(room)
		previous_room = room
