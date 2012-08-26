package objects.LD24 
{
	/**
	 * ...
	 * @author Philip Ludington
	 */
	public class boid extends Entity 
	{
		[Embed(source = '../../assets/Background1.png')] public static const BoidImage:Class;		
		
		public var image:Image = new Image(BoidImage);
		
		public function Block(x:int, y:int) 
		{
			super(x, y, image);
			x = x;
			y = y;
			image.centerOrigin();
			setHitbox(40, 40);
			centerOrigin();
		}
		
	}

}