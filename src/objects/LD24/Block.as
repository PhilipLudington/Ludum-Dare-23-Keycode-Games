package objects.LD24 
{
	import com.greensock.TweenMax;
	import flash.display.BlendMode;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Sfx;
	import net.flashpunk.utils.Input;
	
	public class Block extends Entity 
	{
		public var image:Image = Image.createRect(40, 40, 0xFFFFFF);
		public var clicks:int = 0;
		public var canClick:Boolean = true;
		
		public function Block() 
		{
			super(x, y, image);
			x = FP.halfWidth;
			y = FP.halfHeight;
			image.centerOrigin();
			setHitbox(40, 40);
			centerOrigin();
		}
		
		override public function update():void 
		{
			if (collidePoint(x, y, Input.mouseX, Input.mouseY))
			{
				image.blend = BlendMode.ADD;
				
				if (Input.mousePressed && canClick)
				{
					canClick = false;
					clicks ++;
					TweenMax.delayedCall(1.0, enable);
					image.scale = 0.5;
				}
			}
			else
				image.blend = BlendMode.DIFFERENCE;
			
			image.color = FP.rand(0xFFFFFF);
			
			switch (clicks)
			{
				case 0:
					move(Input.mouseX, Input.mouseY, 0.1);
					break;
				case 1:
					move(FP.width - Input.mouseX, FP.height - Input.mouseY, 0.1);
					break;
				case 2:
					move(FP.height - Input.mouseY, Input.mouseX, 0.1);
					break;
				case 3:
					move(Input.mouseY, FP.width - Input.mouseX, 0.1);
					break;
				case 4:
					move(Input.mouseY, Input.mouseX, 0.2);
					break;
				case 5:
					move(FP.height - Input.mouseY, FP.width - Input.mouseX, 0.05);
					break;
				default:
					visible = active = collidable = false;
					trace("Complete!");
					active = false;
					break;
			}
		}
		
		public function enable():void
		{
			canClick = true;
			//image.scale = 1;
			TweenMax.to(image, 0.25, { scale:1 } );
		}
		
		public function move(xx:int, yy:int, ease:Number):void
		{
			x += (xx - x) * ease;
			y += (yy - y) * ease;
		}
	}
}