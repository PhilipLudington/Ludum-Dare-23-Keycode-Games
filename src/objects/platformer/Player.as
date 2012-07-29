package objects.platformer 
{
	import com.greensock.easing.Cubic;
	import com.greensock.TweenMax;
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Sfx;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class Player extends Entity 
	{
		[Embed(source = '../../assets/platformer/player.png')] public static const PLAYER:Class;
		
		public static const MAX_SPEED:Number = 3.0;
		public static const ACCEL:Number = 0.5;
		public static const FRICTION:Number = MAX_SPEED / (MAX_SPEED + ACCEL);
		public static const MIN_SPEED:Number = ACCEL * FRICTION;
		public static const JUMP_SPEED:Number = 6.0;
		public static const GRAVITY:Number = 0.25;
		public static const MAX_FALL:Number = 8.0;
		
		public var sprite:Image = Image.createRect(20, 20, 0xf6f580);
		public var speed:Point = new Point(4, 0);
		
		public function Player(x:int, y:int) 
		{
			super(x, y, sprite);
			setHitbox(20, 20, 10, 20);
			sprite.originX = 10;
			sprite.originY = 20;
		}
		
		override public function update():void 
		{
			if (collide("Solid", x, y + 1))
			{
				if (Input.pressed(Key.UP))
				{
					speed.y = -JUMP_SPEED;
					squish(0.7, 1.4);
				}
			}
			else
			{
				speed.y += GRAVITY;
				
				if (speed.y > MAX_FALL)
					speed.y = MAX_FALL;
			}
			
			if (Input.check(Key.RIGHT))
				speed.x += ACCEL;
			
			if (Input.check(Key.LEFT))
				speed.x -= ACCEL;
			
			speed.x *= FRICTION;
			
			if (Math.abs(speed.x) < MIN_SPEED)
				speed.x = 0;
			
			moveBy(speed.x, speed.y, "Solid", true);
			
			x = Math.max(x, 10);
		}
		
		override public function moveCollideX(e:Entity):Boolean 
		{
			speed.x = 0;
			return true;
		}
		
		override public function moveCollideY(e:Entity):Boolean 
		{
			if (speed.y > 0)
			{
				speed.x = 0;
				squish(1.4, 0.7);
			}
			
			speed.y = 0;
			return true;
		}
		
		public function squish(x:Number, y:Number):void
		{
			sprite.scaleX = x;
			sprite.scaleY = y;
			TweenMax.killTweensOf(sprite);
			TweenMax.to(sprite, 0.15, { scaleX:1, scaleY:1, ease:Cubic.easeIn } );
		}
	}
}