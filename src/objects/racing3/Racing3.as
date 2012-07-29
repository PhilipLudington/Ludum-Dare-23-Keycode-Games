package objects.racing3 
{
	import flash.display.BitmapData;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Stamp;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	import net.flashpunk.Sfx;
	import net.flashpunk.utils.Draw;
	
	public class Racing3 extends Room 
	{
		[Embed(source = "../../levels/racing3/level_1.oel", mimeType = "application/octet-stream")] public static const LEVEL_1:Class;
		[Embed(source = "../../assets/racing/grass.png")] public static const GRASS:Class;
		[Embed(source = "../../assets/racing/tiles3.png")] public static const TILES:Class;
		[Embed(source = "../../assets/racing/track.png")] public static const TRACK:Class;
		[Embed(source = "../../assets/racing/tires.png")] public static const TIRES:Class;
		
		public var file:Class;
		public var level:XML;
		public var width:int;
		public var height:int;
		public var background:Backdrop;
		public var solids:Grid;
		public var slow:Grid;
		public var walls:Tilemap;
		public var track:Tilemap;
		public var player:Player;
		public var finish:Finish;
		public var hud:Text;
		public var lap:int = 0;
		public var canvasData:BitmapData;
		public var canvas:Stamp;
		public var tires:Image;
		public var puddles:Array = [];
		
		public function Racing3(file:Class = null) 
		{
			if (file == null)
				file = LEVEL_1;
			
			this.file = file;
			level = FP.getXML(file);
			
			width = level.@width;
			height = level.@height;
			
			background = new Backdrop(GRASS, true, true);
			addGraphic(background, 12);
			
			solids = new Grid(width, height, 20, 20);
			solids.loadFromString(level.Walls, "", "\n");
			addMask(solids, "Solid");
			
			slow = new Grid(width, height, 20, 20);
			slow.loadFromString(level.Slow, "", "\n");
			addMask(slow, "Slow");
			
			walls = new Tilemap(TILES, width, height, 20, 20);
			walls.loadFromString(level.Walls, "", "\n");
			addGraphic(walls, 11);
			
			track = new Tilemap(TRACK, width, height, 20, 20);
			track.loadFromString(level.Track, ",", "\n");
			addGraphic(track, 10);
			
			hud = new Text("LAP: 1/2", 2, 2, { color:0xFFFFFF } );
			hud.scrollX = hud.scrollY = 0;
			addGraphic(hud, -10);
			
			canvasData = new BitmapData(width, height, true, 0);
			canvas = new Stamp(canvasData);
			addGraphic(canvas, 3);
			
			tires = new Image(TIRES);
			tires.centerOrigin();
			tires.alpha = 0.2;
			
			var o:XML;
			
			for each (o in level.Objects.Player)
				add(player = new Player(o.@x, o.@y));
			
			for each (o in level.Objects.Finish)
				add(finish = new Finish(o.@x, o.@y, o.@height));
			
			for each (o in level.Objects.Puddle)
				puddles.push(add(new Puddle(o.@x, o.@y, o.@lap)));
			
			camera.x = FP.clamp(player.x - FP.halfWidth, 0, width - FP.width);
			camera.y = FP.clamp(player.y - FP.halfHeight, 0, height - FP.height);
			
			nextLap();
		}
		
		override public function update():void 
		{
			super.update();
			
			camera.x += (FP.clamp(player.x - FP.halfWidth + player.speed.x * 20, 0, width - FP.width) - camera.x) * 0.1;
			camera.y += (FP.clamp(player.y - FP.halfHeight + player.speed.y * 20, 0, height - FP.height) - camera.y) * 0.1;
			
			if (player.speed.length > 0 && !player.collideWith(slow.parent, player.x, player.y))
			{
				tires.angle = player.sprite.angle;
				Draw.setTarget(canvasData, FP.zero);
				Draw.graphic(tires, player.x, player.y);
				Draw.resetTarget();
			}
			
			if (finish.checkLap(player))
				nextLap();
		}
		
		public function nextLap():void
		{
			lap ++;
			if (lap > 2)
			{
				trace("Complete!");
				active = false;
			}
			else
			{
				hud.text = "LAP: " + lap + "/2";
				for each (var puddle:Puddle in puddles)
					puddle.setLap(lap);
			}
		}
	}
}