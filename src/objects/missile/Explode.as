package objects.missile 
{
	import com.greensock.easing.Back;
	import com.greensock.TweenMax;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Sfx;
	
	public class Explode extends Entity 
	{
		public var image:Image = Image.createCircle(25, 0xd9525b);
		
		public function Explode(shot:Shot) 
		{
			super(shot.x, shot.y, image);
			image.centerOrigin();
			setHitbox(50, 50);
			centerOrigin();
			
			image.scale = 0;
			TweenMax.to(image, 0.25, { scale:1, ease:Back.easeOut } );
			
			type = "Explode";
		}
		
		override public function update():void 
		{
			if (image.scale > 0.5)
			{
				image.alpha *= 0.9;
				
				if (image.alpha < 0.1)
					world.remove(this);
				else if (image.alpha < 0.5)
					collidable = false;
			}
		}
	}
}