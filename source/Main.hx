import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.Lib;
import flixel.FlxGame;
import flixel.FlxState;

class Main extends Sprite {
	/** Width of the game in pixels -it might be
	 * less / more in actual pixels depending on zoom level.
	 */
	var gWidth:Int = 640;
	/** Height of the game in pixels -it might be
	 * less / more in actual pixels depending on zoom level.
	 */
	var gHeight:Int = 480;
	/** FlxState the game starts with. */
	var initialState:Class<FlxState> = wiztigers.MenuState;
	/** If -1, zoom is automatically calculated to fit the window dimensions. */
	var zoom:Float = 1;
	/** Fps the game should run at. */
	var framerate:Int = 60;
	/** Skip the flixel splash screen that appears in release mode. */
	var splash:Bool = true;
	/** Start the game in fullscreen on desktop targets. */
	var fullscreen:Bool = false;
	
	// You can pretty much ignore everything from here on - your code should go in your states.
	
	public static function main():Void {
		Lib.current.addChild(new Main());
	}
	
	public function new() {
		super();
		if (stage != null) init();
		else addEventListener(Event.ADDED_TO_STAGE, init);
	}
	
	private function init(?E:Event):Void {
		if (hasEventListener(Event.ADDED_TO_STAGE)) {
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}
		setupGame();
	}
	
	private function setupGame():Void {
		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;

		if (zoom == -1) {
			var ratioX:Float = stageWidth / width;
			var ratioY:Float = stageHeight / height;
			zoom = Math.min(ratioX, ratioY);
			width = Math.ceil(stageWidth / zoom);
			height = Math.ceil(stageHeight / zoom);
		}
		addChild(new FlxGame(gWidth, gHeight, initialState, zoom, framerate, framerate, splash, fullscreen));
	}
}
