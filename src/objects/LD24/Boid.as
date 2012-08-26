package objects.LD24 
{
	/**
	 * ...
	 * @author Philip Ludington
	 */
	public class Boid extends Entity 
	{
		[Embed(source = '../../assets/Background1.png')] public static const BoidImage:Class;		
		
		public var image:Image = new Image(BoidImage);
		private var SEPARATION_WEIGHT:Number = 10;
		private var ALIGNMENT_WEIGHT:Number = 10;
		private var COHESION_WEIGHT:Number = 10;
		
		public function Boid(x:int, y:int) 
		{
			super(x, y, image);
			x = x;
			y = y;
			image.centerOrigin();
			setHitbox(40, 40);
			centerOrigin();
		}
		
		override public function update():void 
		{
			acceleration = this.flock(neighbours)
			@velocity.add(acceleration).limit(MAX_SPEED) # Limit the maximum speed at which a boid can go
			@location.add(@velocity)
		
			Reuse.(this);
		}
		
		
		private function flock(neighbours)
		{
			separation = this.separate(neighbours).multiply(SEPARATION_WEIGHT);
			alignment = this.align(neighbours).multiply(ALIGNMENT_WEIGHT);
			cohesion = this.cohere(neighbours).multiply(COHESION_WEIGHT);
			
			return separation.add(alignment).add(cohesion)
		}
	}

}