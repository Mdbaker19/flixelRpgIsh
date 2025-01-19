package;

import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite {
	public static var player: Player;
	public static var eLevel: Int;
	public function new() {
		super();
		eLevel = 1;
		new Player();
		addChild(new FlxGame(0, 0, PlayState));
	}
}
