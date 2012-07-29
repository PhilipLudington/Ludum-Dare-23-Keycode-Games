package objects.dungeon3 
{
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	import net.flashpunk.Sfx;
	
	public class Dungeon3 extends Room 
	{
		[Embed(source = "../../levels/dungeon3/level_1.oel", mimeType = "application/octet-stream")] public static const LEVEL_1:Class;
		[Embed(source = "../../assets/dungeon/tiles2.png")] public static const TILES:Class;
		
		public var file:Class;
		public var level:XML;
		public var width:int;
		public var height:int;
		public var solids:Grid;
		public var tiles:Tilemap;
		public var player:Player;
		public var stairs:Stairs;
		public var demons:Array = [];
		public var keys:Array = [];
		
		public function Dungeon3(file:Class = null) 
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
			
			var o:XML;
			
			for each (o in level.Objects.Player)
				add(player = new Player(o.@x, o.@y));
			
			for each (o in level.Objects.Stairs)
				add(stairs = new Stairs(o.@x, o.@y));
			
			for each (o in level.Objects.Sword)
				add(new Sword(o.@x, o.@y));
			
			for each (o in level.Objects.Key)
				keys[int(o.@id)] = add(new LockKey(o.@x, o.@y));
			
			for each (o in level.Objects.Lock)
				add(new Lock(o.@x, o.@y));
			
			for each (o in level.Objects.Demon)
			{
				demons.push(add(new Demon(o.@x, o.@y, o.@key, o)));
				if (keys[int(o.@key)])
					keys[int(o.@key)].disable();
			}
		}
		
		override public function update():void 
		{
			super.update();
			
			camera.x += (FP.clamp(player.x - FP.halfWidth, 0, width - FP.width) - camera.x) * 0.1;
			camera.y += (FP.clamp(player.y - FP.halfHeight, 0, height - FP.height) - camera.y) * 0.1;
			
			if (player.active && player.collideWith(stairs, player.x, player.y))
			{
				trace("Complete!");
				active = false;
			}
		}
		
		override public function render():void 
		{
			var x:Number = camera.x;
			var y:Number = camera.y;
			camera.x = int(camera.x);
			camera.y = int(camera.y);
			super.render();
			camera.x = x;
			camera.y = y;
		}
		
		public function move():void
		{
			for each (var demon:Demon in demons)
				demon.move();
		}
	}
}