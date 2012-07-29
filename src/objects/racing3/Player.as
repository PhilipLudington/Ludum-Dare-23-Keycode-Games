package objects.racing3 
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
		[Embed(source = "../../assets/racing/car.png")] public static const CAR:Class;
		
		public static const MAX_SPEED:Number = 8;
		public static const SLOW_SPEED:Number = 2;
		public static const ACCEL:Number = 0.2;
		public static const FRICTION:Number = MAX_SPEED / (MAX_SPEED + ACCEL);
		public static const SLOW_FRICTION:Number = SLOW_SPEED / (SLOW_SPEED + ACCEL);
		
		public var sprite:Image = new Image(CAR);
		public var accel:Point = new Point();
		public var speed:Point = new Point();
		public var spin:int = 0;
		
		public function Player(x:int, y:int) 
		{
			super(x, y, sprite);
			sprite.centerOrigin();
			setHitbox(16, 16);
			centerOrigin();
			sprite.smooth = true;
		}
		
		override public function update():void 
		{
			if (spin > 0)
			{
				sprite.angle += spin;
				spin--;
			}
			else
			{
				accel.x = accel.y = 0;
				
				if (Input.check(Key.RIGHT))
					speed.x += ACCEL;
				if (Input.check(Key.LEFT))
					speed.x -= ACCEL;
				if (Input.check(Key.DOWN))
					speed.y += ACCEL;
				if (Input.check(Key.UP))
					speed.y -= ACCEL;
				
				if (speed.length > 0)
					sprite.angle = FP.angle(0, 0, speed.x, speed.y);
			}
			
			if (collide("Slow", x, y))
			{
				speed.x *= SLOW_FRICTION;
				speed.y *= SLOW_FRICTION;
			}
			else
			{
				speed.x *= FRICTION;
				speed.y *= FRICTION;
			}
			
			moveBy(speed.x, speed.y, "Solid", true);
			
			var p:Puddle = collide("Puddle", x, y) as Puddle;
			if (p != null)
			{
				spin = 60;
				p.disable();
			}
		}
		
		override public function moveCollideX(e:Entity):Boolean 
		{
			Room(world).shake(20, 4);
			speed.x *= -0.5;
			return true;
		}
		
		override public function moveCollideY(e:Entity):Boolean 
		{
			Room(world).shake(20, 4);
			speed.y *= -0.5;
			return true;
		}
	}
}