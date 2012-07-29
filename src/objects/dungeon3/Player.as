package objects.dungeon3 
{
	import com.greensock.easing.Back;
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
		[Embed(source = "../../assets/dungeon/player.png")] public static const PLAYER_D:Class;
		
		public var sprite:Spritemap = new Spritemap(PLAYER_D, 20, 20);
		public var hasSword:Boolean = false;
		public var keys:int = 0;
		public var start:Point;
		
		public var dies:int = 0;
		public var keyGot:Boolean;
		
		public function Player(x:int, y:int) 
		{
			start = new Point(x, y);
			super(x, y, sprite);
			setHitbox(20, 20);
		}
		
		override public function update():void 
		{
			if (Input.pressed(Key.RIGHT))
				move(20, 0);
			else if (Input.pressed(Key.LEFT))
				move(-20, 0);
			else if (Input.pressed(Key.DOWN))
				move(0, 20);
			else if (Input.pressed(Key.UP))
				move(0, -20);
			
			checkDemon();
		}
		
		public function move(x:int, y:int):void
		{
			if (x != 0)
				sprite.flipped = x < 0;
			
			var solid:Entity = collide("Solid", this.x + x, this.y + y);
			
			if (keys > 0 && solid is Lock)
			{
				start = new Point(solid.x, solid.y);
				world.remove(solid);
				solid = null;
				keys--;
			}
			
			if (solid == null)
			{
				active = false;
				TweenMax.to(this, 0.1, { x:this.x + x, y:this.y + y, ease:Cubic.easeOut, onComplete:moveEnd } );
			}
			
			Dungeon3(world).move();
		}
		
		public function moveEnd():void
		{
			active = true;
			sprite.alpha = 1;
			x = int(x / 20) * 20;
			y = int(y / 20) * 20;
			
			var sword:Entity = collide("Sword", x, y);
			if (sword != null)
			{
				world.remove(sword);
				sprite.frame = 1;
				hasSword = true;
				start = new Point(x, y);
			}
			
			var key:Entity = collide("Key", x, y);
			if (key != null)
			{
				start = new Point(x, y);
				world.remove(key);
				keys++;
				
				keyGot = true;
			}
			
			checkDemon();
		}
		
		public function checkDemon():void
		{
			var demon:Entity = collide("Demon", x, y);
			if (demon != null)
			{
				if (hasSword)
					world.remove(demon);
				else
					die();
			}
		}
		
		public function die():void
		{
			active = false;
			sprite.alpha = 0.5;
			TweenMax.killTweensOf(this);
			TweenMax.to(this, 0.5, { x:start.x, y:start.y, ease:Cubic.easeOut, onComplete:moveEnd } );
		}
	}
}