extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotation_degrees+=60*delta
	pass


@onready var blade_colour = Color.BISQUE
@onready var blade_thickness = 2
func _draw():
	#diagonals	
	draw_line(Vector2(-8, 8), Vector2(8, -8),blade_colour, blade_thickness)
	draw_line(Vector2(-8, -8), Vector2(8, 8), blade_colour, blade_thickness)
	#straight across
	draw_line(Vector2(0, -10), Vector2(0, 10), blade_colour, blade_thickness)
	draw_line(Vector2(-10, 0), Vector2(10, 0), blade_colour, blade_thickness)
