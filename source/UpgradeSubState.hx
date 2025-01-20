package;

import flixel.util.FlxSpriteUtil;
import flixel.FlxSprite;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.FlxSubState;

class UpgradeSubState extends FlxSubState {

    var headText: FlxText;
    var closeBtn: FlxButton;
    var hpUp: FlxButton;
    var defUp: FlxButton;
    var atkUp: FlxButton;
    var speedUp: FlxButton;
    var heal: FlxButton;

	public function new() {
		super(0x33000000);
	}
	
	override function create() {
		super.create();
		
		headText = Util.createText(0, 0, 'Spend Money: ${Main.player.money}');
		headText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.RED, 4);
		headText.screenCenter();
        headText.y = headText.y - 70;
		
        hpUp = new FlxButton(0, 0, "HP $5", hpUpg);
		hpUp.screenCenter();
		hpUp.y = headText.y + headText.height + 8;
        atkUp = new FlxButton(0, 0, "ATK $5", atkUpg);
		atkUp.screenCenter();
		atkUp.y = hpUp.y + hpUp.height + 8;
        speedUp = new FlxButton(0, 0, "ATB $5", atkRateUpg);
		speedUp.screenCenter();
		speedUp.y = atkUp.y + atkUp.height + 8;
        heal = new FlxButton(0, 0, "Heal $5", justHeal);
		heal.screenCenter();
		heal.y = speedUp.y + speedUp.height + 8;

        defUp = new FlxButton(0, 0, "Def $5", defUpg);
		defUp.screenCenter();
		defUp.y = heal.y + heal.height + 8;

		closeBtn = new FlxButton(0, 0, "Close", closeSub);
		closeBtn.screenCenter();
		closeBtn.y = defUp.y + defUp.height + 16;
		
		var bg: FlxSprite = new FlxSprite();
		bg.makeGraphic(
            Std.int(headText.width + 16), 
            Std.int(headText.height + defUp.height + 8 + heal.height + hpUp.height + atkUp.height + speedUp.height + closeBtn.height + 140), 
            FlxColor.WHITE
        );

		FlxSpriteUtil.drawRect(bg, 1, 1, bg.width - 2, bg.height - 2, FlxColor.BLACK);
		bg.screenCenter();
		
		add(bg);
		add(headText);
        add(hpUp);
        add(atkUp);
        add(speedUp);
        add(heal);
        add(defUp);
		add(closeBtn);
	}
	
	private function closeSub(): Void {
		close();
	}

    // make a stat map for this
    private function hpUpg(): Void {
        if (Main.player.money >= 5) {
            Main.player.hp += 1;
            Main.player.money -= 5;
            headText.text = 'Spend Money: ${Main.player.money}';
        }
    }
    private function atkUpg(): Void {
        if (Main.player.money >= 5) {
            Main.player.attack += 1;
            Main.player.money -= 5;
            headText.text = 'Spend Money: ${Main.player.money}';
        }
    }
    private function atkRateUpg(): Void {
        if (Main.player.money >= 5) {
            Main.player.atbRate += 1;
            Main.player.money -= 5;
            headText.text = 'Spend Money: ${Main.player.money}';
        }
    }
    private function justHeal(): Void {
        if (Main.player.money >= 5) {
            Main.player.hp = Main.player.maxHp;
            Main.player.money -= 5;
            headText.text = 'Spend Money: ${Main.player.money}';
        }
    }
    private function defUpg(): Void {
        if (Main.player.money >= 5) {
            Main.player.defense += 1;
            Main.player.money -= 5;
            headText.text = 'Spend Money: ${Main.player.money}';
        }
    }
}