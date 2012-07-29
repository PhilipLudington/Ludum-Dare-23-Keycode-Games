package objects.missile 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Sfx;
	import net.flashpunk.utils.Input;
	
	public class Player extends Entity 
	{
		public static const SHOT_TIMER:int = 30;
		
		public var body:Image = Image.createCircle(20, 0xd9525b);
		public var gun:Image = Image.createRect(40, 10, 0xd9525b);
		public var shotTimer:int = 0;
		
		public function Player(x:int, y:int) 
		{
			body.centerOrigin();
			gun.originX = 0;
			gun.originY = gun.height / 2;
			super(x, y, new Graphiclist(gun, body));
			gun.angle = 90;
			layer = 1;
		}
		
		override public function update():void 
		{
			gun.angle = FP.angle(x, y, world.mouseX, world.mouseY);
			
			if (shotTimer > 0)
				shotTimer--;
			else
			{
				if (Input.mousePressed)
				{
					world.add(new Shot(this));
					shotTimer = 30;
				}
			}
		}
	}
}