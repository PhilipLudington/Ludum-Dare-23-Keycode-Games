package objects.dungeon3 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	
	public class Sword extends Entity 
	{
		[Embed(source = "../../assets/dungeon/sword.png")] public static const SWORD:Class;
		
		public var image:Image = new Image(SWORD);
		
		public function Sword(x:int, y:int) 
		{
			super(x, y, image);
			setHitbox(20, 20);
			type = "Sword";
			
			layer = 4;
		}
	}
}