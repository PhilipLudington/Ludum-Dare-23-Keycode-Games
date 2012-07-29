package objects.missile 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	
	public class Asteroid extends Entity 
	{
		public var image:Image = Image.createCircle(25, 0x000000);
		
		public function Asteroid(x:int, y:int) 
		{
			super(x, y, image);
			image.centerOrigin();
			setHitbox(40, 40);
			centerOrigin();
			layer = 4;
		}
		
		override public function update():void 
		{
			if (collide("Explode", x, y))
			{
				Missile(world).points ++;
				world.remove(this);
			}
		}
	}
}