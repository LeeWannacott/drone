extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotation_degrees+=owner.drone_speed*delta
	pass


@onready var blade_colour = Color.BISQUE
@onready var blade_thickness = 2
func _draw():
	#diagonals	
	draw_line(Vector2(-10, 10), Vector2(10, -10),blade_colour, blade_thickness)
	draw_line(Vector2(-10, -10), Vector2(10, 10), blade_colour, blade_thickness)
	#straight across
	draw_line(Vector2(0, -12), Vector2(0, 12), blade_colour, blade_thickness)
	draw_line(Vector2(-12, 0), Vector2(12, 0), blade_colour, blade_thickness)
