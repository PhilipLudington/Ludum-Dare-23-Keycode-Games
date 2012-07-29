package 
{
	import com.greensock.TweenMax;
	import flash.display.MovieClip;
	import flash.display.StageQuality;
	import flash.geom.Rectangle;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import objects.dungeon.Dungeon;
	import objects.dungeon3.Dungeon3;
	import objects.missile.Missile;
	import objects.missile3.Missile3;
	import objects.platformer.Platformer;
	import objects.platformer3.Platformer3;
	import objects.racing.Racing;
	import objects.racing3.Racing3;
	import objects.weird.Weird;
	
	/**
	 * ========================================================
	 * LUDUM DARE 23 KEYNOTE GAMES
	 * 2012 (c) Chevy Ray Johnston
	 * ========================================================
	 * 
	 * These games are made with FlashPunk, a game engine which
	 * is freely available for you to use! Check it out at:
	 * 
	 * flashpunk.net
	 * flashpunk.net/learn
	 * flashpunk.net/forums
	 * 
	 * You are totally free to use any of the code in this in
	 * your games! So enjoy :) hope some of it is helpful!
	 * 
	 * ========================================================
	 * INSTRUCTIONS
	 * ========================================================
	 * 
	 * I just put all 9 of the games in one source, to make it
	 * simpler to distribute! Each game's objects are in its own
	 * folder (eg. objects/dungeon, objects/racing). The versions
	 * with "3" at the end are the improved ones with graphics!
	 * 
	 * To switch games, just change the current FlashPunk "world",
	 * in the code below, I've commented out the other games, so
	 * just switch which line is uncommented to try out the others.
	 * 
	 * If you have any questions about this, feel free to email me:
	 * 
	 * happytrash@gmail.com
	 * 
	 * ========================================================
	 * 
	 * Break a leg, jammers!
	 */
	public class Main extends Engine 
	{
		public function Main()
		{
			super(400, 300, 60);
			FP.screen.scale = 2;
			FP.screen.color = 0xFFFFFF;
			
			//Which game to play:
			
			FP.world = new Platformer();
			//FP.world = new Platformer3();
			//FP.world = new Missile();
			//FP.world = new Missile3();
			//FP.world = new Dungeon();
			//FP.world = new Dungeon3();
			//FP.world = new Racing();
			//FP.world = new Racing3();
			//FP.world = new Weird();
		}
	}
}