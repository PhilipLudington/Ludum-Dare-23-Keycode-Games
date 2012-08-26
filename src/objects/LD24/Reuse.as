package objects.LD24 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Philip Ludington
	 */
	public class Reuse 
	{
		
		public function Reuse() 
		{
			
		}
		
		public static function Wrap( entity:Entity ):void
		{
			if ( entity.x < 0 )
			{
				entity.x = FP.width;
			}
			if ( entity.y < 0 )
			{
				entity.y = FP.height;
			}
			if ( entity.x > FP.width )
			{
				entity.x = 0;
			}
			if ( entity.y > FP.height )
			{
				entity.y = 0;
			}
		}
	}

}