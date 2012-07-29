package objects.dungeon3 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	
	public class Lock extends Entity 
	{
		[Embed(source = '../../assets/dungeon/lock.png')] public static const LOCK:Class;
		
		public var image:Image = new Image(LOCK);
		
		public function Lock(x:int, y:int) 
		{
			super(x, y, image);
			setHitbox(20, 20);
			type = "Solid";
		}
	}
}