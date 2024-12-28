extends Control

func _ready():
		%buy_drone.connect("pressed",_spawn_drone.bind("base_drone"))
		%increase_drone_speed.connect("pressed",_boost_drone_speed.bind("base_drone"))

		%buy_drill_drone.connect("pressed",_spawn_drone.bind("drill_drone"))
		%increase_drill_drone_speed.connect("pressed",_boost_drone_speed.bind("drill_drone"))

		%buy_defuse_drone.connect("pressed",_spawn_drone.bind("defuse_drone"))
		%increase_defuse_drone_speed.connect("pressed",_boost_drone_speed.bind("defuse_drone"))
		pass



@onready var world := get_tree().get_first_node_in_group("world")
@onready var base_drone := preload("uid://cv75hi5fwiisu")
@onready var utils:=get_tree().get_first_node_in_group("utils")

func _spawn_drone(drone_type:String):
		var new_drone = base_drone.instantiate()
		world.add_child(new_drone)
		match drone_type:
				"base_drone":
						new_drone.drone_type = drone_type
						new_drone.add_to_group("base_drones")
						new_drone.add_to_group("idle_base_drones")
						new_drone.get_node("%drill_sprite").visible=false
						new_drone.get_node("%chasis").texture=preload("uid://bynhiq0uwldpw")
				"drill_drone":

						new_drone.drone_type = drone_type
						new_drone.add_to_group("drill_drones")
						new_drone.add_to_group("idle_drill_drones")
						new_drone.get_node("%drill_sprite").visible=true
						new_drone.get_node("%chasis").texture=preload("uid://dqwlmchhn5dpq")
				"defuse_drone":
						new_drone.drone_type = drone_type
						new_drone.add_to_group("defuse_drones")
						new_drone.add_to_group("idle_defuse_drones")
						new_drone.get_node("%drill_sprite").visible=false
						new_drone.get_node("%chasis").texture=preload("uid://dr8kxi0c0dmgy")
		utils.update_drone_amount_label(drone_type)

		pass

func _boost_drone_speed(drone_type):
		# var drones = get_tree().get_nodes_in_group("base_drones")
		var drones
		match drone_type:
			"base_drone":
				drones =  get_tree().get_nodes_in_group("base_drones")
			"drill_drone":
				drones = get_tree().get_nodes_in_group("drill_drones")
			"defuse_drone":
				drones = get_tree().get_nodes_in_group("defuse_drones")

		if drones.size()>0:
			for drone in drones:
				drone.blade_count+=1
				drone.drone_speed+=10
		pass
