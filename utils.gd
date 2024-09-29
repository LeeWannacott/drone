extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func is_colliding(root:Node2D)->bool:
	var soft_collision:= root.get_node_or_null("%soft_collision")
	if soft_collision: return soft_collision.has_overlapping_areas()
	else: return false

var push_vector:Vector2 = Vector2.ZERO
var soft_collision:Node
var areas:Array[Area2D]=[]
var area:Area2D
func get_push_vector(root:CharacterBody2D,delta:float,rot_speed:float=2)->void:
	areas=[]
	soft_collision = root.get_node_or_null("%soft_collision")
	push_vector = Vector2.ZERO
	if soft_collision.has_overlapping_areas():
		areas = soft_collision.get_overlapping_areas()
		if areas.size()>0:
			area = areas[0]
			push_vector = area.global_position.direction_to(soft_collision.global_position)
	root.velocity += push_vector *delta*	100
	root.rotation = lerp_angle(root.rotation, (root.velocity*delta).angle(),delta*rot_speed)
	root.move_and_slide()