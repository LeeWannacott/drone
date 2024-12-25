extends Node2D


# Called when the node enters the scene tree for the first time.
@onready var resources := get_tree().get_first_node_in_group("resources")
func _ready() -> void:
	connect("mouse_entered",_set_mouse_on_gem.bind(true))
	connect("mouse_exited",_set_mouse_on_gem.bind(false))


@onready var utils := get_tree().get_first_node_in_group("utils")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# if utils.is_colliding(self):
	# 	utils.get_push_vector(self,delta,2)
	pass

func _draw():
	draw_rect(Rect2(20.0, 20.0, 20.0, 20.0), Color.GREEN, false, 2.0)
	# draw_triangle(Vector2(0,0),Vector2(0,20),Vector2(20,0),Color.GREEN)
	draw_polygon([Vector2(-20,0),Vector2(0,-20),Vector2(20,0)],[Color.GREEN,Color.GREEN,Color.ORANGE])

func _set_mouse_on_gem(value: bool) -> void:
	resources.mouse_on_gem = value
	pass # Replace with function body.
