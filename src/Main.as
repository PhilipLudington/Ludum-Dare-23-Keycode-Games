package 
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import objects.LD24.LD24;
	
	public class Main extends Engine 
	{
		public function Main()
		{
			super(400, 300, 60);
			FP.screen.scale = 2;
			FP.screen.color = 0xFFFFFF;
			
			FP.world = new LD24();
		}
	}
}