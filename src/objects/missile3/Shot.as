package objects.missile3 
{
	import com.greensock.easing.Cubic;
	import com.greensock.easing.Quad;
	import com.greensock.TweenMax;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	public class Shot extends Entity 
	{
		[Embed(source = "../../assets/missile/shot.png")] public static const SHOT:Class;
		
		public static const SPEED:Number = 200;
		
		public var image:Image = new Image(SHOT);
		
		public function Shot(player:Player) 
		{
			FP.angleXY(this, player.gun.angle, 40, player.x, player.y);
			graphic = image;
			image.angle = player.gun.angle;
			image.centerOrigin();
			image.smooth = true;
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