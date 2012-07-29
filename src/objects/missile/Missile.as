package objects.missile 
{
	import com.greensock.TweenMax;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Sfx;
	import net.flashpunk.utils.Draw;
	
	public class Missile extends Room
	{
		public var ground:Image = Image.createRect(400, 20, 0x000000);
		public var points:int = 0;
		
		public function Missile() 
		{
			addGraphic(ground, 0, 0, FP.height - ground.height);
			add(new Player(FP.halfWidth, FP.height - ground.height));
			add(new Asteroid(FP.width * 0.25, 50));
			add(new Asteroid(FP.width * 0.5, 80));
			add(new Asteroid(FP.width * 0.75, 65));
		}
		
		override public function update():void 
		{
			super.update();
			
			if (points >= 3)
			{
				trace("Complete!");
				active = false;
			}
		}
		
		override public function render():void 
		{
			super.render();
			Draw.circlePlus(mouseX, mouseY, 6, 0xd9525b, 1, false, 1);
			Draw.line(mouseX - 10, mouseY - 10, mouseX + 10, mouseY + 10, 0xd9525b);
			Draw.line(mouseX + 10, mouseY - 10, mouseX - 10, mouseY + 10, 0xd9525b);
		}
	}
}