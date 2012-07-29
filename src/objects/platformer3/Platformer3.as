package objects.platformer3 
{
	import gui.TextBox;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	import net.flashpunk.Sfx;
	import net.flashpunk.World;
	
	public class Platformer3 extends Room
	{
		[Embed(source = "../../levels/platformer3/level_1.oel", mimeType = "application/octet-stream")] public static const LEVEL_1:Class;
		[Embed(source = "../../assets/platformer/background.png")] public static const BACKGROUND:Class;
		[Embed(source = '../../assets/platformer/tiles3.png')] public static const TILES:Class;
		
		public var file:Class;
		public var level:XML;
		public var width:int;
		public var height:int;
		public var background:Backdrop;
		public var solids:Grid;
		public var tiles:Tilemap;
		public var player:Player;
		
		public function Platformer3(file:Class = null) 
		{
			if (file == null)
				file = LEVEL_1;
			
			this.file = file;
			level = FP.getXML(file);
			
			width = level.@width;
			height = level.@height;
			
			background = new Backdrop(BACKGROUND, true, true);
			background.scrollX = 0.5;
			addGraphic(background, 20);
			
			solids = new Grid(width, height, 20, 20);
			solids.loadFromString(level.Solids, "", "\n");
			addMask(solids, "Solid");
			
			tiles = new Tilemap(TILES, width, height, 20, 20);
			tiles.loadFromString(level.Tiles, ",", "\n");
			addGraphic(tiles, 10);
			
			var o:XML;
			
			for each (o in level.Objects.Player)
				add(player = new Player(o.@x, o.@y));
			
			for each (o in level.Objects.Spikes)
				add(new Spikes(o.@x, o.@y, o.@width));
		}
		
		override public function update():void 
		{
			super.update();
			
			camera.x += (FP.clamp(player.x - FP.halfWidth, 0, width - FP.width) - camera.x) * 0.1;
			
			if (player.x > width + 10)
			{
				trace("Complete!");
				active = false;
			}
		}
	}
}