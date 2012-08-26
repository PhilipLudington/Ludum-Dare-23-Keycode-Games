package objects.LD24 
{
	import com.greensock.TweenMax;
	import flash.display.BlendMode;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Sfx;
	import net.flashpunk.utils.Input;
	
	/**
	 * ...
	 * @author Philip Ludington
	 */
	public class Block extends Entity 
	{
		public var image:Image;
		public var clicks:int = 0;
		public var canClick:Boolean = true;
		
		private var speed:Number = 0.01;
		private var size:int = 40;
		private var mover:int = 0;
		
		public function Block(x:int, y:int) 
		{
			image = Image.createRect(size, size, 0xFFFFFF);
			super(x, y, image);
			x = x;
			y = y;
			image.centerOrigin();
			setHitbox(40, 40);
			centerOrigin();
		}
		
		override public function update():void 
		{
			if (LD24.Scored)
			{
			}
			else if( collidePoint(x, y, Input.mouseX, Input.mouseY))			
			{
				image.blend = BlendMode.ADD;
				
				if (Input.mousePressed && canClick)
				{
					canClick = false;
					LD24.Scored = true;
					clicks = Mutate();
					TweenMax.delayedCall(1.0, enable);
				}
			}
			else
				image.blend = BlendMode.NORMAL;
			
			if ( mover == 0 )
			{
				switch (clicks)
				{
					case 0:
						move(Input.mouseX, Input.mouseY, speed);
						break;
					case 1:
						move(FP.width - Input.mouseX, FP.height - Input.mouseY, speed);
						break;
					case 2:
						move(FP.height - Input.mouseY, Input.mouseX, speed);
						break;
					case 3:
						move(Input.mouseY, FP.width - Input.mouseX, speed);
						break;
					case 4:
						move(Input.mouseY, Input.mouseX, speed);
						break;
					case 5:
						move(FP.height - Input.mouseY, FP.width - Input.mouseX, speed);
						break;
					case 7:
						move(Input.mouseY, Input.mouseX, speed);
						break;
					case 8:
						move(Input.mouseY, Input.mouseX, speed);
						break;
					case 9:
						move(Input.mouseY, Input.mouseX, speed);
						break;					
					case 10:
						if ( x == 0)
						{
							moveTowards( FP.screen.width, 
								0, 
								FP.rand(40));
						}
						else
						{
							moveTowards( 0, 
								0, 
								FP.rand(40));
						}
						break;
					case 11:
						moveBy( speed * (FP.rand( 2) * -1), speed * (FP.rand( 2) * -1));					
						break;
					case 12:
						moveTowards( Input.mouseX + 10, 
							Input.mouseX - 10, 
							FP.rand(10));						
						break;
					default:
						move(Input.mouseX - 10, Input.mouseY - 10, speed);
						break;
				}
			}
			else
			{					
			
			}
			
			// Wrap
			Reuse.Wrap(this);
		}
		
		public function Mutate():int 
		{
			var mutator:int = FP.rand(14);
			
			switch (mutator)
			{
				case 7:
					size *= .9;
					// Create new shape
					var circle:Image = Image.createCircle(size / 2 , image.color);
					circle.blend = image.blend;	
					circle.centerOrigin();
					
					// Change ot the new shape
					image = circle;
					this.graphic = image;
					break;
				case 8:			
				case 9:
					image.color = FP.rand(0xFFFFFF);
					break;
				case 10:
					image.alpha = FP.random;
					break;
				case 11:
					speed++;
				case 12:
					size *= 1.05;
					// Create new shape with bigger size
					var square2:Image = Image.createRect(size, size, 0xFFFFFF);
					square2.blend = image.blend;	
					square2.centerOrigin();
					
					// Change ot the new shape
					image = square2;
					this.graphic = image;
					break;
				case 13:
				default:
					mover = 1;
					break;
				
			}
			
			return mutator;
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