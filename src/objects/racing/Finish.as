package objects.racing 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Sfx;
	
	public class Finish extends Entity 
	{
		public var image:Image;
		public var passing:Boolean;
		
		public function Finish(x:int, y:int, height:int) 
		{
			image = Image.createRect(20, height, 0xFFFFFF);
			super(x, y, image);
			setHitbox(20, height);
			type = "Solid";
		}
		
		public function checkLap(player:Player):Boolean
		{
			if (passing)
			{
				if (player.left > right)
				{
					passing = false;
					collidable = true;
					return true;
				}
			}
			else
			{
				collidable = player.x > x;
				if (collideWith(player, x, y))
					passing = true;
			}
			return false;
		}
	}
}