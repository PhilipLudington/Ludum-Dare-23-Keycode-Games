package objects.platformer3 
{
	import com.greensock.easing.Back;
	import com.greensock.easing.Cubic;
	import com.greensock.TweenMax;
	import flash.geom.Point;
	import gui.TextBox;
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
		
		public static const MAX_SPEED:Number = 2.0;
		public static const ACCEL:Number = 0.1;
		public static const FRICTION:Number = MAX_SPEED / (MAX_SPEED + ACCEL);
		public static const MIN_SPEED:Number = ACCEL * FRICTION;
		public static const JUMP_SPEED:Number = 5.0;
		public static const GRAVITY:Number = 0.2;
		public static const MAX_FALL:Number = 8.0;
		
		public var sprite:Spritemap = new Spritemap(PLAYER, 20, 20);
		public var speed:Point = new Point();
		public var safeSpot:Point;
		
		public function Player(x:int, y:int) 
		{
			super(x, y, sprite);
			setHitbox(8, 10, 4, 10);
			sprite.originX = 10;
			sprite.originY = 20;
			
			sprite.add("Idle", [0], 0, false);
			sprite.add("Run", [1, 2, 3, 4], 20, true);
			
			safeSpot = new Point(x, y);
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
			
			if (collide("Solid", x, y + 1))
			{
				if (Math.abs(speed.x) > MIN_SPEED)
				{
					sprite.play("Run");
					sprite.rate = FP.scale(Math.abs(speed.x), 0, MAX_SPEED, 0, 1);
				}
				else
				{
					sprite.play("Idle");
					sprite.rate = 1;
				}
			}
			else
				sprite.frame = 3;
			
			if (speed.x != 0)
				sprite.flipped = speed.x < 0; 
			
			if (collide("Death", x, y))
			{
				world.add(new Explode(x, y - 10));
				speed.x = speed.y = 0;
				active = false;
				sprite.alpha = 0.5;
				TweenMax.to(this, 0.5, { x:safeSpot.x, y:safeSpot.y, ease:Back.easeIn, onComplete:enable } );
				Room(world).shake(20, 4);
			}
			else if (!collide("Death", x + 20, y) && !collide("Death", x - 20, y))
			{
				if (collide("Solid", x, y + 1) && collide("Solid", x + 20, y + 1) && collide("Solid", x - 20, y + 1))
				{
					safeSpot.x = x;
					safeSpot.y = y;
				}
			}
		}
		
		public function enable():void
		{
			sprite.alpha = 1;
			active = true;
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
				speed.x *= 0.75;
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