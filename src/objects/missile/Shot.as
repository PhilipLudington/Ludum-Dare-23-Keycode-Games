package objects.missile 
{
	import com.greensock.easing.Cubic;
	import com.greensock.easing.Quad;
	import com.greensock.TweenMax;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Sfx;
	
	public class Shot extends Entity 
	{
		public static const SPEED:Number = 200;
		
		public var image:Image = Image.createRect(10, 4, 0xd9525b);
		
		public function Shot(player:Player) 
		{
			FP.angleXY(this, player.gun.angle, 40, player.x, player.y);
			graphic = image;
			image.angle = player.gun.angle;
			image.centerOrigin();
			active = false;
			layer = 2;
		}
		
		override public function added():void 
		{
			var time:Number = FP.distance(x, y, world.mouseX, world.mouseY) / SPEED;
			TweenMax.to(this, time, { x:world.mouseX, y:world.mouseY, ease:Quad.easeOut, onComplete:explode } );
		}
		
		public function explode():void
		{
			world.add(new Explode(this));
			world.remove(this);
		}
	}
}