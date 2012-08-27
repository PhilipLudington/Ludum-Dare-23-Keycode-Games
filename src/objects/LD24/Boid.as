package objects.LD24 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import flash.display.BlendMode;
	
	/**
	 * ...
	 * @author Philip Ludington
	 */
	public class Boid extends Entity 
	{
		[Embed(source = '../../assets/boid.png')] public static const BoidImage:Class;		
		
		public var image:Image = Image.createCircle(6, 0xCC3333);
		public var vector:Vector2 = new Vector2();
		
		private static var neighbours:Array = new Array();
		
		private var velocity:Vector2;
		private var location:Vector2;
		
		private var SEPARATION_WEIGHT:Number = 2;
		private var ALIGNMENT_WEIGHT:Number = 1;
		private var COHESION_WEIGHT:Number = 1;
		private var MAX_SPEED:Number = 2;
		private var NEIGHBOUR_RADIUS:Number = 50;
		private var MAX_FORCE:Number = 0.5;
		private var DESIRED_SEPARATION:Number = 6;
		
		public function Boid(x:int, y:int)
		{
			super(x, y, image);
			image.blend = BlendMode.NORMAL;
			image.alpha = 1;
			x = x;
			y = y;
			image.centerOrigin();
			setHitbox(6, 6);
			centerOrigin();
			location = new Vector2(x, y);
			velocity = new Vector2( 
				3 * ( -1 * FP.random) + 0.1, 
				3 * ( -1 * FP.random) * FP.random + 0.1);
			
			neighbours.push(this);
		}
		
		override public function update():void 
		{
			var acceleration:Vector2 = this.flock(neighbours);
			
			Wrap(this);
			
			velocity = velocity.Add(acceleration).Limit(MAX_SPEED);
			location = location.Add(velocity);		
			x = location.x;
			y = location.y;
		}
		
		
		public function Wrap( entity:Entity ):void
		{
			if ( location.x < 0 )
			{
				location.x = FP.width;
			}
			if ( location.y < 0 )
			{
				location.y = FP.height;
			}
			if ( location.x > FP.width )
			{
				location.x = 0;
			}
			if ( location.y > FP.height )
			{
				location.y = 0;
			}
		}
		private function flock(neighbours:Array):Vector2
		{
			var separation:Vector2 = Separate(neighbours).Multiple(SEPARATION_WEIGHT);
			var alignment:Vector2  = Align(neighbours).Multiple(ALIGNMENT_WEIGHT);
			var cohesion:Vector2  = Cohere(neighbours).Multiple(COHESION_WEIGHT);
			
			return separation.Add(alignment).Add(cohesion);
		}
		
		private function Cohere(neighbours:Array):Vector2
		{
			var sum:Vector2 = new Vector2();
			var count:int = 0;
			
			for ( var i:int = 0; i < neighbours.length; i++)
			{
				if ( neighbor == this )
				{
					// don't worry about self
				}
				else
				{
					var neighbor:Boid = neighbours[i];
					var distance:Number = vector.Distance(neighbor.vector);
					if ( distance > 0 && distance < NEIGHBOUR_RADIUS)
					{
						sum += neighbor;
						
						count++;
					}
				}
			}
			
			if ( count > 0)
			{
				return Steer( sum.Divide(count) );
			}
			else
			{
				return sum;
			}
		}
		
		private function Steer(target:Vector2):Vector2
		{
			var desired:Vector2 = target.Subtract( vector );
			var distance:Number = desired.Magnitude();
			
			var steer:Vector2;
			if ( distance > 0 )
			{
				desired = desired.Normalize();
				
				if ( distance < 100.0 )
				{
					desired = desired.Multiple(MAX_SPEED * (distance / 100.0));
				}
				else
				{
					desired = desired.Multiple(MAX_SPEED);					
				}
				
				steer = desired.Subtract(velocity);
				steer = steer.Limit(MAX_FORCE);
			}
			else
			{
				steer = new Vector2();
				steer.x = 0;
				steer.y = 0;
			}
			
			return steer;
		}
		
		private function Align(neighbours:Array):Vector2
		{
			var mean:Vector2 =  new Vector2();
			var count:int = 0;
			
			for ( var i:int = 0; i < neighbours.length; i++)
			{
				if ( neighbor == this )
				{
					// don't worry about self
				}
				else
				{
					var neighbor:Boid = neighbours[i];
					var distance:Number = location.Distance(neighbor.vector);
					
					if ( distance > 0 && distance < NEIGHBOUR_RADIUS)
					{
						mean = mean.Add(neighbor.velocity);
						
						count++;
					}
				}
			}
				
			if ( count > 0 )
			{
				mean = mean.Divide(count);
			}
			mean = mean.Limit(MAX_FORCE);
				
			return mean;
		}
		
		private function Separate(neighbours:Array):Vector2
		{
			var mean:Vector2 = new Vector2();
			var counter:int = 0;
			
			for ( var i:int = 0; i < neighbours.length;  i++)
			{
				if ( neighbor == this )
				{
					// don't worry about self
				}
				else
				{
					var neighbor:Boid = neighbours[i];
					var distance:Number = location.Distance(neighbor.vector);
					
					if ( distance > 0 && distance < DESIRED_SEPARATION)
					{
						var part:Vector2 = location.Subtract( neighbor.location);
						part = part.Normalize();
						part = part.Divide(distance);
						mean = mean.Add(part);
						
						counter++;
					}
				}
			}
			
			if ( counter > 0 )
			{
				mean = mean.Divide(counter);
			}
			return mean;
		}
	}
}