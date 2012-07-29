package objects.missile3 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	public class Asteroid extends Entity 
	{
		[Embed(source = "../../assets/missile/asteroid.png")] public static const ASTEROID:Class;
		
		public var image:Image = new Image(ASTEROID);
		public var angleSpeed:Number = -2 + FP.random * 4;
		public var fallSpeed:Number = 0.5 + FP.random;
		
		public function Asteroid(x:int, y:int) 
		{
			super(x, y, image);
			image.centerOrigin();
			setHitbox(40, 40);
			centerOrigin();
			layer = 4;
			
			image.smooth = true;
			image.angle = FP.rand(360);
		}
		
		override public function update():void 
		{
			image.angle += angleSpeed;
			y += fallSpeed;
			
			if (collide("Explode", x, y))
			{
				Missile3(world).points ++;
				destroy();
			}
			else if (y > FP.height - 20)
				destroy();
		}
		
		public function destroy():void
		{
			for (var i:int = 0; i < 5; i++)
			Missile3(world).chunks.emit("Chunk", x, y);
			Room(world).shake(10, 4);
			world.remove(this);
		}
	}
}