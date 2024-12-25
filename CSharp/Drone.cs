using Godot;
using Godot.Collections;

[GlobalClass]
public partial class Drone : Godot.CharacterBody2D
{
	public Godot.NavigationAgent2D NavAgent;
	public Godot.Variant Gems;

	public Dictionary State;

	public override void _Ready()
	{
		// Rotors = new Array{
		// 	GetNode("%rotor"), 
		// 	GetNode("%rotor2"), 
		// 	GetNode("%rotor3"), 
		// 	GetNode("%rotor4"), 
		// 	};
		Utils = (Utils)GetTree().GetFirstNodeInGroup("utils");

		Resources = (TileMapLayer)GetTree().GetFirstNodeInGroup("resources");
		NavAgent = (NavigationAgent2D)GetNode("%nav");
		State = new Dictionary{
			{0, "idle_drones"},
			{1, "busy_drones"},
			};
		
		var MagnetArea = (Area2D) GetNode("%magnet_area");
		MagnetArea.AreaEntered += _MagnetAreaEntered;
		// MagnetArea.Connect(Area2D.SignalName.AreaEntered, Callable.From(_MagnetAreaEntered));

	}


    public Array Rotors;

	public Utils Utils;
	public override void _PhysicsProcess(double delta)
	{

		// Get the input direction and handle the movement/deceleration.
		// As good practice, you should replace UI actions with custom gameplay actions.
		// nav_agent.target_position = target_position
		// nav_agent.target_position =get_global_mouse_position()
		// for rotor in rotors:
		// 	rotor.rotation_degrees+=1
		// if(Utils.IsColliding(this))
		// {Utils.GetPushVector(this, delta, 2);
		// }
		// if(NavAgent.GetNextPathPosition()!= new Vector2(0,0))
		// {
		// 	Velocity = GlobalPosition.DirectionTo(NavAgent.GetNextPathPosition()) * 200;
		// 	// velocity = self.global_position.direction_to(Vector2(100,500))*100
		// 	// direction = root.global_position.direction_to(player.global_position)
		// 	Rotation = (float)Mathf.LerpAngle(Rotation, (Velocity * (float)delta).Angle(), 0.1);
		// 	// if velocity !=Vector2():
		// }
		
		Velocity= new Vector2();
		MoveAndSlide();
	}


	public Godot.TileMapLayer Resources;

	private void _MagnetAreaEntered(Godot.Area2D area)
	{
		Resources.RemoveChild(area.Owner);
		GetNode("%gems").AddChild(area.Owner);
		var gem = (Node2D)area.Owner;
		gem.Position = new Vector2(GD.RandRange(0,5), 0);
		NavAgent.TargetPosition = new Vector2(0, 0);
		// Replace with function body.
	}
}