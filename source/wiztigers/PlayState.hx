package wiztigers;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxDestroyUtil;
import flixel.addons.tile.FlxTilemapExt;
//import flixel.graphics.frames.FlxTileFrames;
import openfl.Assets;

class PlayState extends flixel.FlxState {
	private var level:FlxTilemapExt;
	private var player:FlxSprite;
	private var enemy:FlxSprite;

	override public function create(): Void {
		level = new FlxTilemapExt();
		// Load in the Level and Define Arrays for different slope types
		var map:String = Assets.getText("assets/slopemap.txt");
		var tiles:String = "assets/colortiles.png";
		add(level.loadMap(map, tiles, 10, 10));

		// tile tearing problem fix
//		var levelTiles:FlxTileFrames = FlxTileFrames.fromBitmapAddSpacesAndBorders("assets/colortiles.png", new FlxPoint(10, 10), new FlxPoint(2, 2), new FlxPoint(2, 2));
//		level.frames = levelTiles;
//		level.useScaleHack = false;

		var tempFL:Array<Int> = [5, 13, 21];
		var tempFR:Array<Int> = [6, 14, 22];
		var tempCL:Array<Int> = [7, 15, 23];
		var tempCR:Array<Int> = [8, 16, 24];

		var tempC:Array<Int> = [4, 12, 20];

		level.setSlopes(tempFL, tempFR, tempCL, tempCR);
		level.setClouds(tempC);

		this.player = createPlayer();
		add(this.player);

		this.enemy = createPlayer();
		this.enemy.makeGraphic(8, 22, flixel.util.FlxColor.RED);
		this.enemy.x = 110;
		this.enemy.y = 300;
		add(this.enemy);

		FlxG.cameras.bgColor = 0xff050509;
		// follow the player
		//FlxG.camera.setScrollBoundsRect(0, 0, 970, 500, true);
		//FlxG.camera.follow(this.player, PLATFORMER);

		super.create();
	}

	private function createPlayer() : FlxSprite {
		// player as a box
		var player:FlxSprite = new FlxSprite(70);
		player.makeGraphic(8, 10, flixel.util.FlxColor.BLUE);

		// if it's a platformer, Y should be high, like 200.
		// otherwise, set them to something like 80.
		player.maxVelocity.set(250, 1000);
		// Simulate Gravity on the Player
		player.acceleration.y = 2000;
		player.drag.x = player.maxVelocity.x * 8;
		return player;
	}



	override public function destroy(): Void {
		super.destroy();
		this.player = FlxDestroyUtil.destroy(this.player);
		this.level = FlxDestroyUtil.destroy(this.level);
	}

	override public function update(): Void {
//		var goLeft :Array<String> = ["LEFT", "Q"];
//		var goRight:Array<String> = ["RIGHT", "D"];
//		var jump   :Array<String> = ["UP", "Z", "SPACE"];
		player.acceleration.x = 0;
		if (FlxG.keys.anyPressed(["LEFT", "A"]))
			player.acceleration.x = -player.maxVelocity.x * 4;
		if (FlxG.keys.anyPressed(["RIGHT", "D"]))
			player.acceleration.x = player.maxVelocity.x * 4;
		if (FlxG.keys.anyPressed(["SPACE", "W", "UP"]) && player.isTouching(flixel.FlxObject.FLOOR))
			player.velocity.y = -player.maxVelocity.y / 3;

		//TODO? elapsed time
		super.update();

		FlxG.collide(this.level, this.player);
		FlxG.collide(this.level, this.enemy);
		FlxG.collide(this.player, this.enemy);
	}
}
