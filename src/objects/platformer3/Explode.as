package objects.platformer3 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	
	public class Explode extends Entity 
	{
		[Embed(source = "../../assets/platformer/explode.png")] public static const EXPLODE:Class;
		
		public var sprite:Spritemap = new Spritemap(EXPLODE, 40, 40, animEnd);
		
		public function Explode(x:int, y:int) 
		{
			super(x, y, sprite);
			sprite.centerOrigin();
			sprite.add("Explode", [0, 1, 2, 3, 4], 20, false).play();
		}
		
		public function animEnd():void
		{
			world.remove(this);
		}
	}
}