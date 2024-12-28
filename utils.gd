extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func get_push_vector(root:Node2D,delta:float,rot_speed:float=2)->void:
	var areas:=[]
	var soft_collision := root.get_node("%soft_collision")
	var push_vector = Vector2.ZERO
	if soft_collision.has_overlapping_areas():
		areas = soft_collision.get_overlapping_areas()
		if areas.size()>0:
			var area = areas[0]
			push_vector = area.global_position.direction_to(soft_collision.global_position)
	root.velocity = push_vector *delta
	root.rotation = lerp_angle(root.rotation, (root.velocity*delta).angle(),delta*rot_speed)
	# root.global_position += root.velocity
	root.move_and_slide()

@onready var drone_state:={
	"base_drone":{"busy":"busy_base_drones","idle":"idle_base_drones"},
	"drill_drone":{"busy":"busy_drill_drones","idle":"idle_drill_drones"},
	"defuse_drone":{"busy":"busy_defuse_drones","idle":"idle_defuse_drones"},
}

@onready var drone_management := get_tree().get_first_node_in_group("drone_management")
func update_drone_amount_label(drone_type):
	match drone_type:
		"base_drone":
			drone_management.get_node("%base_drone_amount").text =generate_new_label("busy_base_drones","base_drones")
			
		"drill_drone":
			drone_management.get_node("%drill_drone_amount").text =generate_new_label("busy_drill_drones","drill_drones")

		"defuse_drone":
			drone_management.get_node("%defuse_drone_amount").text =generate_new_label("busy_drill_drones","drill_drones")

func generate_new_label(group1,group2):
	return str(get_tree().get_nodes_in_group(group1).size())\
	+" / "+str(get_tree().get_nodes_in_group(group2).size())

func update_drone_state_to_busy(drone,drone_type):
	drone.remove_from_group(drone_state[drone_type].idle)
	drone.add_to_group(drone_state[drone_type].busy)
	update_drone_amount_label(drone_type)

func update_drone_state_to_idle(drone,drone_type):
	drone.remove_from_group(drone_state[drone_type].busy)
	drone.add_to_group(drone_state[drone_type].idle)
	update_drone_amount_label(drone_type)
