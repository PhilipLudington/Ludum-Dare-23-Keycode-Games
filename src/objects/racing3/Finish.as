package objects.racing3 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Sfx;
	
	public class Finish extends Entity 
	{
		public var passing:Boolean;
		
		public function Finish(x:int, y:int, height:int) 
		{
			super(x, y);
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