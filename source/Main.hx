package;

import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite {
	public static var player: Player;
	public static var slimeLevel: Int;
	public static var birdLevel: Int;
	public static var eType: EType;
	public function new() {
		super();
		birdLevel = 1;
		slimeLevel = 1;
		new Player();
		addChild(new FlxGame(0, 0, PlayState));
	}
}
