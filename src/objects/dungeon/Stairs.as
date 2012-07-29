package objects.dungeon 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;

	public class Stairs extends Entity 
	{
		public var image:Image = Image.createRect(20, 20, 0xF4E264);
		
		public function Stairs(x:int, y:int) 
		{
			super(x, y, image);
			setHitbox(20, 20);
			layer = 4;
		}
	}

}