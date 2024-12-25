using Godot;
using Godot.Collections;


// Called when the node enters the scene tree for the first time.
[GlobalClass]
public partial class Utils : Godot.Node
{
	public override void _Ready()
	{
		// Replace with function body.
	}


	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{

	}

	public bool IsColliding(Godot.Node2D root)
	{
		if (SoftCollision != null)
		{
			return SoftCollision.HasOverlappingAreas();
		}
		else
		{
			return false;
		}
	}

	public Vector2 PushVector = Vector2.Zero;
	public Godot.Area2D SoftCollision;
	public Array<Area2D> Areas = new Array<Area2D>();
	public Godot.Area2D Area;
	public void GetPushVector(Godot.CharacterBody2D root, double delta, double rot_speed = 2)
	{
		Areas = new Array<Area2D>();
		SoftCollision = (Area2D)root.GetNodeOrNull("%soft_collision");
		PushVector = Vector2.Zero;
		if (SoftCollision.HasOverlappingAreas())
		{
			Areas = SoftCollision.GetOverlappingAreas();
			if (Areas.Count > 0)
			{
				Area = Areas[0];
				PushVector = Area.GlobalPosition.DirectionTo(SoftCollision.GlobalPosition);
			}
		}
		root.Velocity += PushVector * (float)delta * 100;
		root.Rotation = (float)Mathf.LerpAngle(root.Rotation, (root.Velocity * (float)delta).Angle(), delta * rot_speed);
		root.MoveAndSlide();
	}


}