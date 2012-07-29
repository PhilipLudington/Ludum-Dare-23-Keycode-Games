package objects.missile3 
{
	import com.greensock.TweenMax;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.ParticleType;
	import net.flashpunk.graphics.TiledImage;
	import net.flashpunk.Sfx;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.utils.Ease;
	
	public class Missile3 extends Room
	{
		[Embed(source = "../../assets/missile/space.png")] public static const SPACE:Class;
		[Embed(source = "../../assets/missile/ground.png")] public static const GROUND:Class;
		[Embed(source = "../../assets/missile/chunk.png")] public static const CHUNK:Class;
		
		public var space:Backdrop = new Backdrop(SPACE, true, true);
		public var ground:TiledImage = new TiledImage(GROUND, FP.width, 20);
		public var chunks:Emitter = new Emitter(CHUNK, 22, 22);
		public var points:int = 0;
		
		public function Missile3() 
		{
			addGraphic(space, 20);
			addGraphic(ground, 0, 0, FP.height - ground.height);
			add(new Player(FP.halfWidth, FP.height - ground.height + 5));
			
			addGraphic(chunks, 4);
			var t:ParticleType = chunks.newType("Chunk", [0, 1, 2, 3, 0, 1, 2, 3]);
			t.setMotion(20, 25, 0.5, 140, 75, 1.5, Ease.cubeOut);
			t.setAlpha(1, 0, Ease.cubeIn);
			t.setGravity(0.3, 0.2);
			
			TweenMax.delayedCall(4.0, spawnAsteroid);
		}
		
		public function spawnAsteroid():void
		{
			add(new Asteroid(25 + FP.rand(FP.width - 50), -25));
			TweenMax.delayedCall(1.0, spawnAsteroid);
		}
		
		override public function update():void 
		{
			super.update();
			
			if (points >= 10)
			{
				trace("Complete!");
				active = false;
			}
		}
		
		override public function render():void 
		{
			super.render();
			
			Draw.circlePlus(mouseX, mouseY, 6, 0xFFFFFF, 1, false, 1);
			Draw.line(mouseX - 10, mouseY - 10, mouseX + 10, mouseY + 10, 0xFFFFFF);
			Draw.line(mouseX + 10, mouseY - 10, mouseX - 10, mouseY + 10, 0xFFFFFF);
		}
	}
}