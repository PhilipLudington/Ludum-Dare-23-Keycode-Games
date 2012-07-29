package objects.missile3 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Sfx;
	import net.flashpunk.utils.Input;
	
	public class Player extends Entity 
	{
		[Embed(source = "../../assets/missile/body.png")] public static const BODY:Class;
		[Embed(source = "../../assets/missile/gun.png")] public static const GUN:Class;
		
		public static const SHOT_TIMER:int = 30;
		
		public var body:Image = new Image(BODY);
		public var gun:Image = new Image(GUN);
		public var shotTimer:int = 0;
		
		public function Player(x:int, y:int) 
		{
			body.originX = body.width / 2;
			body.originY = body.height;
			gun.originX = -19;
			gun.originY = gun.height / 2;
			super(x, y, new Graphiclist(gun, body));
			gun.angle = 90;
			gun.smooth = true;
			layer = 1;
		}
		
		override public function update():void 
		{
			gun.angle = FP.angle(x, y, world.mouseX, world.mouseY);
			
			if (shotTimer > 0)
			{
				shotTimer--;
				gun.visible = !gun.visible;
			}
			else
			{
				gun.visible = true;
				
				if (Input.mousePressed)
				{
					world.add(new Shot(this));
					shotTimer = 30;
				}
			}
		}
	}
}