package objects.weird 
{
	import com.greensock.TweenMax;
	import flash.display.BlendMode;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.Sfx;
	
	public class Weird extends Room 
	{
		[Embed(source = '../../assets/weird/bg1.png')] public static const BG1:Class;
		[Embed(source = '../../assets/weird/bg2.png')] public static const BG2:Class;
		
		public var bg1:Backdrop = new Backdrop(BG1);
		public var bg2:Backdrop = new Backdrop(BG2);
		
		public function Weird() 
		{
			bg2.blend = BlendMode.ADD;
			addGraphic(bg1, 10);
			addGraphic(bg2, 9);
			switchBg();
			
			add(new Block());
		}
		
		public function switchBg():void
		{
			TweenMax.delayedCall(0.1, switchBg);
			
			bg2.alpha = FP.random;
			bg2.y = FP.rand(FP.height);
			bg1.x = FP.rand(FP.width);
			
			switch (FP.rand(5))
			{
				case 0:
					bg2.blend = BlendMode.ADD;
					break;
				case 1:
					bg2.blend = BlendMode.SUBTRACT;
					break;
				case 2:
					bg2.blend = BlendMode.MULTIPLY;
					break;
				case 3:
					bg2.blend = BlendMode.DIFFERENCE;
					break;
				case 4:
					bg2.blend = BlendMode.LAYER;
					break;
			}
		}
		
		override public function update():void 
		{
			super.update();
		}
	}
}