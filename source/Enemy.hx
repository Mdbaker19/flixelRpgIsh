package;

import flixel.FlxG;
import flixel.FlxSprite;

class Enemy extends FlxSprite {
    public var hp: Float;
    public var defense: Float;
    public var attack: Float;
    public var level: Float;
    var sizeH: Int = 45;

    var atkRate: Float = 3;
    var atkTime: Float = 0;
    public var attacked: Bool = false;

    public function new() {
        super((FlxG.width / 2) - sizeH, (FlxG.height / 2) - sizeH);

        if (Main.eType == EType.Bird) {
            loadGraphic('assets/images/birdMan.png', true, 90, 90);
            animation.add('idle', [0], 0, false);
            animation.add('open', [0, 1, 2], 2);
            animation.play('idle');
            this.level = Main.birdLevel;
        } else if (Main.eType == EType.Slime) {
            loadGraphic('assets/images/slimemold.png', true, 90, 60);
            animation.add('idle', [0, 1, 2], 3);
            animation.add('open', [3, 4, 5, 6], 3);
            animation.play('idle');
            this.level = Main.slimeLevel;
        }
        this.setStats();
    }

    public override function update(dt: Float) {
        super.update(dt);
        atkTime += dt;
        if (atkTime >= atkRate && !attacked) {
            animation.play('open');
            atkTime = 0;
            attacked = true;
        }
        if (animation.name == 'open' && animation.finished) {
            trace("E attacked complete");
            animation.play('idle');
            atkTime = 0;
        }
    }

    function setStats() {
        this.hp = this.level * 6;
        this.defense = this.level * 3;
        this.attack = this.level * 2;
    }

}