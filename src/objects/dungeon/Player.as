package objects.dungeon 
{
	import com.greensock.easing.Cubic;
	import com.greensock.TweenMax;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Sfx;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class Player extends Entity 
	{
		public var image:Image = Image.createRect(20, 20, 0x32AB44);
		
		public function Player(x:int, y:int) 
		{
			super(x, y, image);
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
		}
		
		public function move(x:int, y:int):void
		{
			if (!collide("Solid", this.x + x, this.y + y))
			{
				active = false;
				TweenMax.to(this, 0.1, { x:this.x + x, y:this.y + y, ease:Cubic.easeOut, onComplete:enable } );
			}
		}
		
		public function enable():void
		{
			active = true;
			x = int(x / 20) * 20;
			y = int(y / 20) * 20;
		}
	}
}