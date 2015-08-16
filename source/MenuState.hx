package;

import flixel.FlxG;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxDestroyUtil;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends flixel.FlxState
{
	private var _title:FlxText;
	private var _play:FlxButton;
	private var _options:FlxButton;

	/**
	 * Function that is called up when this state is created to set it up. 
	 */
	override public function create():Void
	{
		_title = new FlxText(0, 0, 0, "HaxeFlixel Spike");
		_title.alignment = "center";
		//_title.screenCenter(flixel.util.FlxAxes.X);
		add(_title);

		_play = new FlxButton(0, 0, "Play", onPlay);
		_play.x = (FlxG.width / 2) - _play.width - 10;
		_play.y = FlxG.height - _play.height - 10;
		add(_play);

		_options = new FlxButton(0, 0, "Options", onOptions);
		_options.x = (FlxG.width / 2) + 10;
		_options.y = FlxG.height - _options.height - 10;
		add(_options);
		

		super.create();
	}

	private function onPlay():Void
	{
		_title.text = "You pressed play!";
/*		FlxG.camera.fade(FlxColor.BLACK,.33, false, function() {
			FlxG.switchState(new PlayState());
		});
*/	}

	private function onOptions():Void
	{
		_title.text = "You pressed options!";
/*		FlxG.camera.fade(FlxColor.BLACK,.33, false, function() {
			FlxG.switchState(new OptionsState());
		});
*/	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
		_title   = FlxDestroyUtil.destroy(_title);
		_play    = FlxDestroyUtil.destroy(_play);
		_options = FlxDestroyUtil.destroy(_options);
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
	}	
}
