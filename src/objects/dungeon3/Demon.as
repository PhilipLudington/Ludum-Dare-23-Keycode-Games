package objects.dungeon3 
{
	import com.greensock.easing.Cubic;
	import com.greensock.TweenMax;
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Key;
	
	public class Demon extends Entity 
	{
		[Embed(source = '../../assets/dungeon/demon.png')] public static const DEMON:Class;
		[Embed(source = '../../assets/dungeon/blood.png')] public static const BLOOD:Class;
		
		public var image:Image = new Image(DEMON);
		public var path:Array = [];
		public var index:int = -1;
		public var key:int;
		
		public function Demon(x:int, y:int, key:int, nodes:XML) 
		{
			super(x, y, image);
			setHitbox(20, 20);
			
			for each (var node:XML in nodes.node)
				path.push(new Point(node.@x, node.@y));
			
			this.key = key;
			type = "Demon";
			layer = 4;
		}
		
		public function move():void
		{
			index++;
			index %= path.length;
			var p:Point = path[index];
			TweenMax.to(this, 0.1, { x:p.x, y:p.y, ease:Cubic.easeOut } );
		}
		
		override public function removed():void 
		{
			world.addGraphic(new Image(BLOOD), layer, x, y);
			
			var keys:Array = Dungeon3(world).keys;
			if (keys[key])
				keys[key].enable();
		}
	}
}