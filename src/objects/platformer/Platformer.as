package objects.platformer 
{
	import com.greensock.TweenMax;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	import net.flashpunk.Sfx;
	import net.flashpunk.World;
	
	public class Platformer extends Room
	{
		[Embed(source = "../../levels/platformer/level_1.oel", mimeType = "application/octet-stream")] public static const LEVEL_1:Class;
		[Embed(source = '../../assets/platformer/tiles.png')] public static const TILES:Class;
		
		public var file:Class;
		public var level:XML;
		public var width:int;
		public var height:int;
		public var solids:Grid;
		public var tiles:Tilemap;
		public var player:Player;
		
		public function Platformer(file:Class = null) 
		{
			if (file == null)
				file = LEVEL_1;
			
			this.file = file;
			level = FP.getXML(file);
			
			width = level.@width;
			height = level.@height;
			
			solids = new Grid(width, height, 20, 20);
			solids.loadFromString(level.Solids, "", "\n");
			addMask(solids, "Solid");
			
			tiles = new Tilemap(TILES, width, height, 20, 20);
			tiles.loadFromString(level.Tiles, ",", "\n");
			addGraphic(tiles, 10);
			
			var o:XML;
			
			for each (o in level.Objects.Player)
				add(player = new Player(o.@x, o.@y));
		}
		
		override public function update():void 
		{
			super.update();
			
			if (player.x > width + 10)
			{
				trace("Complete!");
				active = false;
			}
		}
	}
}