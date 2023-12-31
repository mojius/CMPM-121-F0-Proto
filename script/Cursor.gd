extends Node2D

@onready var tile_map = $"../../TileMap"
@onready var player = $"../Player"
@onready var terrainMap = preload("res://script/TerrainMap.gd");
var mapFromMouse = Vector2i(0,0);

var is_visible = true;
var move_player_command = Callable(movePlayer);
var selecting_command = Callable(selecting);
var current_command = Callable(do_nothing);

func _ready():
	current_command = selecting_command;

func _input(event):
	set_new_cursor_location();
	
	if event.is_action_pressed("Select") == true:
		current_command.call();

func set_new_cursor_location():
	if (!is_visible): return;
	var newPos = tile_map.local_to_map(get_global_mouse_position());
	if (mapFromMouse != newPos):
		tile_map.erase_cell(terrainMap.layersIDs.CURSOR, mapFromMouse);
		mapFromMouse = newPos;
	tile_map.set_cell(2, mapFromMouse, 2, Vector2i(0,0));

func do_nothing():
	pass

func selecting():
	var map_from_mouse = tile_map.local_to_map(get_global_mouse_position());
	if (map_from_mouse == tile_map.local_to_map(player.global_position)):
		current_command = move_player_command;
		
func movePlayer():
	player.start_path();
	current_command = selecting_command;
	
