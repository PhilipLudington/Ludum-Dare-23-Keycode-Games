package objects.dungeon3 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;

	public class Stairs extends Entity 
	{
		[Embed(source = "../../assets/dungeon/stairs.png")] public static const STAIRS:Class;
		
		public var image:Image = new Image(STAIRS);
		
		public function Stairs(x:int, y:int) 
		{
			super(x, y, image);
			setHitbox(20, 20);
			layer = 4;
		}
	}

}