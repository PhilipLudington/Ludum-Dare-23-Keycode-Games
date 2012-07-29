package objects.racing 
{
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	import net.flashpunk.Sfx;
	
	public class Racing extends Room 
	{
		[Embed(source = "../../levels/racing/level_1.oel", mimeType = "application/octet-stream")] public static const LEVEL_1:Class;
		[Embed(source = "../../assets/racing/tiles.png")] public static const TILES:Class;
		
		public var file:Class;
		public var level:XML;
		public var width:int;
		public var height:int;
		public var solids:Grid;
		public var tiles:Tilemap;
		public var player:Player;
		public var finish:Finish;
		public var hud:Text;
		public var lap:int = 1;
		
		public function Racing(file:Class = null) 
		{
			if (file == null)
				file = LEVEL_1;
			
			this.file = file;
			level = FP.getXML(file);
			
			width = level.@width;
			height = level.@height;
			
			solids = new Grid(width, height, 20, 20);
			solids.loadFromString(level.Walls, "", "\n");
			addMask(solids, "Solid");
			
			tiles = new Tilemap(TILES, width, height, 20, 20);
			tiles.loadFromString(level.Walls, "", "\n");
			addGraphic(tiles, 10);
			
			hud = new Text("LAP: 1/2", 2, 2, { color:0xFFFFFF } );
			addGraphic(hud, -10);
			
			var o:XML;
			
			for each (o in level.Objects.Player)
				add(player = new Player(o.@x, o.@y));
			
			for each (o in level.Objects.Finish)
				add(finish = new Finish(o.@x, o.@y, o.@height));
		}
		
		override public function update():void 
		{
			super.update();
			
			if (finish.checkLap(player))
			{
				lap ++;
				if (lap > 2)
				{
					trace("Complete!");
					active = false;
				}
				else
					hud.text = "LAP: " + lap + "/2";
			}
		}
	}
}