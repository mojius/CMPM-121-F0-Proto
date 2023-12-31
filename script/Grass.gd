class_name Grass extends Node

const aboveIsSunny = 49;
const belowIsWet = 33;
const aboveIsDry = 66;

var sunlight_amt: int = 0;
var water_amt: int = 0;

var tile_type: grass_type

var sunny: bool = false;

enum grass_type {
	WET_GRASS = 0,
	NORMAL_GRASS = 1,
	DRY_GRASS = 2
};

func _init():
	var rnd = RandomNumberGenerator.new();
	water_amt = rnd.randi_range(0,100);
	sunlight_amt = rnd.randi_range(0,100);
	
	set_wetness(water_amt);
	set_sunlight(sunlight_amt);

func set_wetness(water):
	water_amt = water;
	if (water_amt < belowIsWet):
		tile_type = grass_type.WET_GRASS;
	elif (water_amt >= belowIsWet && water_amt <= aboveIsDry):
		tile_type = grass_type.NORMAL_GRASS;
	elif (water_amt > aboveIsDry):	
		tile_type = grass_type.DRY_GRASS;
	
func set_sunlight(sun):
	sunlight_amt = sun;
	if (sunlight_amt > aboveIsSunny):
		sunny = true;

