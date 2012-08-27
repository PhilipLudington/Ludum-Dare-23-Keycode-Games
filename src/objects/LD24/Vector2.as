package objects.LD24 
{
	/**
	 * ...
	 * @author Philip Ludington
	 */
	public class Vector2
	{
		public var x:Number;
		public var y:Number;
		
		public function Vector2(x:int = 0, y:int = 0)
		{			
			this.x = x;
			this.y = y;
		}
		
		public function Distance(v:Vector2):Number
		{
			return Math.sqrt( 
				Math.pow(v.x - x, 2)
				+
				Math.pow(v.y - y, 2)
				);
				
		}
		
		public function Magnitude():Number
		{
			return Math.sqrt( 
				x * x 
				+ y * y );
		}
		
		public function Normalize():Vector2
		{
			var magnitude: Number = Magnitude();
			
			if ( magnitude > 0)
			{
				return Divide( magnitude );
			}
			else
			{
				return this;
			}
		}
		
		public function Dot(v:Vector2) : Vector2
		{
			var result:Vector2 = new Vector2();
			result.x = x * v.x;
			result.y = y * v.y;
			
			return result;
		}
		public function Multiple(n:Number) : Vector2
		{
			var result:Vector2 = new Vector2();
			result.x = x * n;
			result.y = y * n;
			
			return result;
		}
		
		public function Divide(n:Number):Vector2
		{
			var result:Vector2 = new Vector2();
			result.x = x / n;
			result.y = y / n;
			
			return result;			
		}
		
		public function Subtract(v:Vector2):Vector2
		{
			var result:Vector2 = new Vector2();
			result.x = x - v.x;
			result.y = y - v.y;
			
			return result;
		}
		
		public function Limit(max:Number):Vector2		
		{
			var result:Vector2 = new Vector2();
			if ( Magnitude() > max)
			{
				result = this.Normalize();
				result = result.Multiple(max);
			}
			
			return this;
		}
		
		public function Add(v:Vector2):Vector2
		{
			var result:Vector2 = new Vector2();
			result.x = x + v.x;
			result.y = y + v.y;
			
			return result;
		}
		
	}

}