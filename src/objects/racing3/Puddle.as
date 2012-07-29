package objects.racing3 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	
	public class Puddle extends Entity 
	{
		[Embed(source = "../../assets/racing/puddle.png")] public static const PUDDLE:Class;
		
		public var image:Image = new Image(PUDDLE);
		public var lap:int;
		
		public function Puddle(x:int, y:int, lap:int) 
		{
			this.lap = lap;
			super(x, y, image);
			image.alpha = 0.5;
			image.centerOrigin();
			setHitbox(6, 6);
			centerOrigin();
			type = "Puddle";
			layer = 1;
		}
		
		public function setLap(lap:int):void
		{
			if (this.lap == lap)
				enable();
			else
				disable();
		}
		
		public function enable():void
		{
			visible = true;
			collidable = true;
		}
		
		public function disable():void
		{
			visible = false;
			collidable = false;
		}
	}
}