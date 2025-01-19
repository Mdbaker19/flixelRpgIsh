package;

import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.util.FlxTimer;

class BattleState extends FlxState {

	// show HUD
    // text for player hp and such
    // text for enemy data and such

    var playerAtkVisual: FlxSprite;
    var text: FlxText;

    var e: Enemy;
    var eT: FlxText;
    var damagesT: FlxText;
    var pastEDamage: Int;
    var pastPDamage: Int;
    var playerAlive: Bool = true;

    var skullSprite: FlxSprite;

    override public function create() {
		super.create();

        pastEDamage = 0;
        pastPDamage = 0;

        e = new Enemy(Main.eLevel);
        add(e);

        playerAtkVisual = new FlxSprite(e.x - 10, e.y - 10);
        playerAtkVisual.loadGraphic('assets/images/slashAnim.png', true, 110, 110);
        playerAtkVisual.animation.add('slash', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], 8, false);
        add(playerAtkVisual);

        text = Util.createText(50, 50, ' HP: ${Main.player.hp} \n ATB: ${Main.player.atkAmount}', 16);
        add(text);

        eT = Util.createText(150, 150, 'Bird HP: ${e.hp}');
        add(eT);

        damagesT = Util.createText(FlxG.width / 2, 120, 'E: 0 | P: 0', 12);
        add(damagesT);

        skullSprite = new FlxSprite(FlxG.width / 2, FlxG.height / 2);
        skullSprite.loadGraphic('assets/images/skull.png', true, 18, 18);
        skullSprite.animation.add('shake', [0], 0, false);
	}

	override public function update(dt: Float) {
		super.update(dt);
        if (playerAlive) {
            Main.player.update(dt);

            if (playerAtkVisual.animation.finished) {
                playerAtkVisual.kill();
                e.alpha = 1.0;
            }
            if (Main.player.atkAmount >= 10) {
                playerAtkVisual.revive();
                playerAtkVisual.animation.play('slash');
                Main.player.atkAmount -= 10;
                pastPDamage = Util.handleDamageCalc(Main.player.attack, e.defense);
                e.hp -= pastPDamage;
                e.alpha = 0.3;
            }
            if (e.attacked) {
                pastEDamage = Util.handleDamageCalc(e.attack, Main.player.defense);
                Main.player.hp -= pastEDamage;
                e.attacked = false;
            }

            if (e.hp <= 0 || Main.player.hp <= 0) {
                if (e.hp <= 0) {
                    Main.player.reward(Main.eLevel);
                    Main.eLevel += 1;
                    battleOver(null);
                } else {
                    skullSprite.animation.play('shake');
                    var timer:FlxTimer = new FlxTimer();
                    timer.start(3, battleOver, 0);
                    add(skullSprite);
                    playerAlive = false;
                    text.color = FlxColor.RED;
                }
            }
        } else {
            e.kill();
            playerAtkVisual.animation.pause();
            playerAtkVisual.kill();
            skullSprite.scale.x += dt * 5;
            skullSprite.scale.y += dt * 5;
            skullSprite.angle += dt * 8;
        }


        text.text = ' HP: ${Main.player.hp} \n ATB: ${Main.player.atkAmount}';
        eT.text = 'Bird HP: ${e.hp}';
        damagesT.text = 'E:${pastEDamage} | P: ${pastPDamage}';
	}

    function battleOver(_) {
        FlxG.switchState(new PlayState());
    }
}
