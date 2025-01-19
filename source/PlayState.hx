package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.util.FlxSave;

class PlayState extends FlxState {

	// text for upgrades and hud

	var battleButton: FlxButton;
	var upgradeButton: FlxButton;
	var saveButton: FlxButton;
	var loadButton: FlxButton;
	var clearButton: FlxButton;
	var gameSave: FlxSave;

	override public function create() {

		gameSave = new FlxSave();
		gameSave.bind("accountSave");

        battleButton = new FlxButton((FlxG.width / 2) - 8, FlxG.height / 2, "Fight", clickBattle);
        add(battleButton);


        upgradeButton = new FlxButton(battleButton.x, battleButton.y + battleButton.height + 8, "Upgrade", clickUpgrade);
        add(upgradeButton);

		saveButton = new FlxButton(upgradeButton.x, upgradeButton.y + upgradeButton.height + 8, "Save", clickSave);
        add(saveButton);

		loadButton = new FlxButton(saveButton.x, saveButton.y + saveButton.height + 8, "Load", clickLoad);
        add(loadButton);

		clearButton = new FlxButton(loadButton.x, loadButton.y + loadButton.height + 8, "Clear save", clickClear);
        add(clearButton);

		super.create();
	}

	override public function update(dt: Float) {
		super.update(dt);
	}

	function clickBattle() {
        FlxG.switchState(new BattleState());
    }

	function clickUpgrade() {
        openSubState(new UpgradeSubState());
    }

	function clickSave() {
		trace('Is save currently there? : ${gameSave.isEmpty()}');
		gameSave.data.player = Main.player;
		gameSave.data.eLvl = Main.eLevel;
		var isSaved: Bool = gameSave.flush();
		trace('Did we save? : ${isSaved}');
	}

	function clickLoad() {
		if (gameSave.data.player == null) {
			trace("Player not there sorry");
		} else {
			trace('Loading player hp: ${gameSave.data.player.hp}');
			trace('Loading e level: ${gameSave.data.eLvl}');
			Main.player = gameSave.data.player;
			Main.eLevel = gameSave.data.eLvl;
		}
	}

	function clickClear() {
		gameSave.erase();
		trace("Save deleted");
	}
}
