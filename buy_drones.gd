extends Control

func _ready():
		%buy_drone.connect("pressed",_spawn_drone.bind("base_drone"))
		%increase_drone_speed.connect("pressed",_boost_drone_speed.bind("base_drone"))

		%buy_drill_drone.connect("pressed",_spawn_drone.bind("drill_drone"))
		%increase_drill_drone_speed.connect("pressed",_boost_drone_speed.bind("drill_drone"))
		pass



@onready var world := get_tree().get_first_node_in_group("world")
@onready var base_drone := preload("uid://cv75hi5fwiisu")

func _spawn_drone(drone_type:String):

		var new_drone = base_drone.instantiate()
		world.add_child(new_drone)
		match drone_type:
				"base_drone":
						new_drone.drone_type = drone_type
						new_drone.add_to_group("base_drones")
				"drill_drone":
						new_drone.drone_type = drone_type
						new_drone.add_to_group("drill_drones")
		_update_drone_amount_label(drone_type)

		pass

func _boost_drone_speed(drone_type):
		# var drones = get_tree().get_nodes_in_group("base_drones")
		var drones
		match drone_type:
			"base_drone":
				drones =  get_tree().get_nodes_in_group("base_drones")
			"drill_drone":
				drones = get_tree().get_nodes_in_group("drill_drones")

		if drones.size()>0:
			for drone in drones:
					drone.drone_speed+=10
		pass


func _update_drone_amount_label(drone_type):
	match drone_type:
		"base_drone":
			print("base")
			%base_drone_amount.text = str(get_tree().get_nodes_in_group("base_drones").size())
		"drill_drone":
			print("drill")
			%drill_drone_amount.text = str(get_tree().get_nodes_in_group("drill_drones").size())
