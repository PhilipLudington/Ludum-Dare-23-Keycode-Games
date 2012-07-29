package  
{
	import net.flashpunk.FP;
	import net.flashpunk.World;
	
	public class Room extends World 
	{
		public var shakeTime:int = 0;
		public var shakeAmount:Number = 0;
		
		public function Room() 
		{
			
		}
		
		override public function update():void 
		{
			super.update();
		}
		
		override public function render():void 
		{
			if (shakeTime > 0)
			{
				shakeTime--;
				var x:Number = camera.x;
				var y:Number = camera.y;
				camera.x = Math.round((camera.x - shakeAmount) + shakeAmount * 2 * FP.random);
				camera.y = Math.round((camera.y - shakeAmount) + shakeAmount * 2 * FP.random);
				super.render();
				camera.x = x;
				camera.y = y;
			}
			else
				super.render();
		}
		
		public function shake(time:int = 20, amount:Number = 4):void
		{
			shakeTime = time;
			shakeAmount = amount;
		}
	}
}