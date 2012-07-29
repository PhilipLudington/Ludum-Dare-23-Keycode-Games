package objects.platformer3 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.TiledImage;
	
	public class Spikes extends Entity 
	{
		[Embed(source = "../../assets/platformer/spikes.png")] public static const SPIKES:Class;
		
		public var image:TiledImage;
		
		public function Spikes(x:int, y:int, width:int) 
		{
			image = new TiledImage(SPIKES, width, 10);
			super(x, y, image);
			setHitbox(width, 4, 0, -6);
			type = "Death";
		}
	}
}