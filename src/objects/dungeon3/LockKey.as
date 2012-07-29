package objects.dungeon3 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	
	public class LockKey extends Entity 
	{
		[Embed(source = '../../assets/dungeon/key.png')] public static const KEY:Class;
		
		public var image:Image = new Image(KEY);
		
		public function LockKey(x:int, y:int) 
		{
			super(x, y, image);
			setHitbox(20, 20);
			type = "Key";
			layer = 2;
		}
		
		public function disable():void
		{
			visible = false;
			collidable = false;
		}
		
		public function enable():void
		{
			visible = true;
			collidable = true;
		}
	}
}