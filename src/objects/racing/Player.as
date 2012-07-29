package objects.racing 
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Sfx;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class Player extends Entity 
	{
		public static const MAX_SPEED:Number = 6;
		public static const ACCEL:Number = 0.2;
		public static const FRICTION:Number = MAX_SPEED / (MAX_SPEED + ACCEL);
		
		public var sprite:Image = Image.createRect(20, 16, 0xd13766);
		public var speed:Point = new Point();
		
		public function Player(x:int, y:int) 
		{
			super(x, y, sprite);
			sprite.centerOrigin();
			setHitbox(16, 16);
			centerOrigin();
		}
		
		override public function update():void 
		{
			if (Input.check(Key.RIGHT))
				speed.x += ACCEL;
			if (Input.check(Key.LEFT))
				speed.x -= ACCEL;
			if (Input.check(Key.DOWN))
				speed.y += ACCEL;
			if (Input.check(Key.UP))
				speed.y -= ACCEL;
			
			speed.x *= FRICTION;
			speed.y *= FRICTION;
			
			moveBy(speed.x, speed.y, "Solid", true);
			
			if (speed.length > 0)
				sprite.angle = FP.angle(0, 0, speed.x, speed.y);
		}
		
		override public function moveCollideX(e:Entity):Boolean 
		{
			Room(world).shake(10);
			
			speed.x *= -0.5;
			return true;
		}
		
		override public function moveCollideY(e:Entity):Boolean 
		{
			Room(world).shake(10);
			
			speed.y *= -0.5;
			return true;
		}
	}
}