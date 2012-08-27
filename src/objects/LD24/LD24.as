package objects.LD24 
{
	import com.greensock.plugins.ColorMatrixFilterPlugin;
	import com.greensock.TweenMax;
	import flash.display.BlendMode;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.Sfx;
	
	/**
	 * ...
	 * @author Philip Ludington
	 */
	public class LD24 extends Room 
	{
		[Embed(source = '../../assets/Background1.png')] public static const BG1:Class;
		[Embed(source = '../../assets/Background2.png')] public static const BG2:Class;
		
		public var Background1:Backdrop = new Backdrop(BG1);
		public var Background2:Backdrop = new Backdrop(BG2);
		
		public static var Scored:Boolean = false;
		
		private var Score:int = 0;
		
		public function LD24() 
		{		
			var vector:Vector2 = new Vector2(0,0);
			
			Background2.blend = BlendMode.ADD;
			addGraphic(Background1, 10);
			addGraphic(Background2, 9);
			switchBg();
			
			SpawnBlock();
			SpawnBlock();
			SpawnBlock();
			SpawnBlock();
			SpawnBlock();
			SpawnBlock();
			SpawnBlock();
			SpawnBlock();
			SpawnBlock();
			SpawnBlock();
			SpawnBlock();
			SpawnBlock();
			SpawnBlock();
			SpawnBlock();
			SpawnBlock();
			SpawnBlock();
			SpawnBlock();
			SpawnBlock();
		}
		
		private function SpawnBlock():void
		{
			add(new Block(FP.rand(FP.screen.width), FP.rand(FP.screen.height)));
		}
		
		public function switchBg():void
		{
			TweenMax.delayedCall(0.2, switchBg);
			
			Background1.alpha = FP.random;
			Background2.alpha = FP.random;
			
			switch (FP.rand(10))
			{
				case 0:
					Background2.blend = BlendMode.ADD;
					Background2.y = FP.rand(FP.width);
					Background2.color = FP.rand(0xFFFFFF);
					break;
				case 1:
					Background2.blend = BlendMode.SUBTRACT;
					Background2.color = FP.rand(0xFFFFFF);
					Background2.y = FP.rand(FP.width);
					break;
				case 2:
					Background2.blend = BlendMode.MULTIPLY;
					Background2.color = FP.rand(0xFFFFFF);
					Background2.y = FP.rand(FP.width);
					break;
				case 3:
					Background2.blend = BlendMode.DIFFERENCE;
					Background2.color = FP.rand(0xFFFFFF);
					Background2.y = FP.rand(FP.width);
					break;
				case 4:
					Background2.blend = BlendMode.LAYER;
					Background2.color = FP.rand(0xFFFFFF);
					Background2.y = FP.rand(FP.width);
					break;
				case 5:
					Background1.blend = BlendMode.ADD;
					Background2.color = FP.rand(0xFFFFFF);
					Background1.x = FP.rand(FP.height);
					break;
				case 6:
					Background1.blend = BlendMode.SUBTRACT;
					Background1.x = FP.rand(FP.height);
					break;
				case 7:
					Background1.blend = BlendMode.MULTIPLY;
					Background1.x = FP.rand(FP.height);
					break;
				case 8:
					Background1.blend = BlendMode.DIFFERENCE;
					Background1.x = FP.rand(FP.height);
					break;
				case 9:
					Background1.blend = BlendMode.LAYER;
					Background1.x = FP.rand(FP.height);
					break;
			}
		}
		
		override public function update():void 
		{
			super.update();
			
			if ( Scored )
			{
				Score++;
			}
			
			Scored = false;			
		}
	}
}