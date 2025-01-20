package;

import flixel.text.FlxText;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.util.FlxTimer;
import flixel.ui.FlxButton;
import flixel.FlxSprite;

class EPickState extends FlxState {

    var pickBirdButton: FlxButton;
    var pickSlimeButton: FlxButton;

    var birdS: FlxSprite;
    var slimeS: FlxSprite;

    override public function create() {
		super.create();
        var t = Util.createText(50, 50, 'Pick the enemy');
        add(t);

        pickBirdButton = new FlxButton((FlxG.width / 2) - 100, FlxG.height / 2, 'Bird Lvl: ${Main.birdLevel}', pickBird);
        add(pickBirdButton);

        birdS = new FlxSprite(pickBirdButton.x, pickBirdButton.y - 90 - 2);
        birdS.loadGraphic('assets/images/birdMan.png', true, 90, 90);
        birdS.animation.add('idle', [0, 1], 3);
        birdS.animation.play('idle');
        add(birdS);

        pickSlimeButton = new FlxButton(pickBirdButton.x + 100, pickBirdButton.y + pickBirdButton.height + 8, 'Slime Lvl: ${Main.slimeLevel}', pickSlime);
        add(pickSlimeButton);

        slimeS = new FlxSprite(pickSlimeButton.x, pickSlimeButton.y - 60 - 2);
        slimeS.loadGraphic('assets/images/slimemold.png', true, 90, 60);
        slimeS.animation.add('idle', [0, 1, 2], 3);
        slimeS.animation.play('idle');
        add(slimeS);
    }

    override public function update(dt: Float) {
        super.update(dt);
    }

    function pickBird() {
        Main.eType = EType.Bird;
        goFight();
    }
    function pickSlime() {
        Main.eType = EType.Slime;
        goFight();
    }

    function goFight() {
        FlxG.switchState(new BattleState());
    }
}