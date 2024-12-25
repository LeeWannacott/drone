using Godot;
using Godot.Collections;


// Called when the node enters the scene tree for the first time.
[GlobalClass]
public partial class Gem : Godot.CharacterBody2D
{

	public Utils Utils;
	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
		if(Utils.IsColliding(this))
		{
			Utils.GetPushVector(this, delta, 2);
		}

	}

	public override void _Ready()
	{
		Utils = (Utils)GetTree().GetFirstNodeInGroup("utils");
	}
}