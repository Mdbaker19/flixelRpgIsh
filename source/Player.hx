package;

import flixel.FlxSprite;
import js.lib.Math;

class Player {

    public var hp: Float;
    public var maxHp: Float;

    public var atkRate: Float;
    public var atkTime: Float = 0;
    public var atkAmount: Float;
    public var atkMax: Float;
    public var atbRate: Float;

    public var attack: Float;
    public var defense: Float;
    public var acc: Float;

    public var money: Float;

    public var xp: Float;
    public var xpReq: Float;

    public function new() {
        this.hp = 10;
        this.maxHp = 10;
        this.atkRate = 1;
        this.atkAmount = 0;
        this.atkMax = 10;
        this.attack = 5;
        this.defense = 5;
        this.acc = 10;
        this.money = 0;
        this.xp = 0;
        this.xpReq = 100;
        this.atbRate = 3;
        Main.player = this;
    }

    public function update(dt: Float) {
        this.atkTime += dt;
        if (this.atkTime > this.atkRate) {
            this.atkAmount += this.atbRate;
            this.atkTime = 0;
        }
    }

    public function levelUp() {
        this.xp %= this.xpReq;
        this.maxHp += 5;
        this.attack += 1;
        this.defense += 1;
        this.atkMax += 2;
        this.atbRate += 1;
    }

    public function reward(eLvl: Int) {
        this.xp += eLvl * 30;
        this.money += eLvl * 8;
        if (this.xp >= this.xpReq) {
            this.levelUp();
        }
    }

}