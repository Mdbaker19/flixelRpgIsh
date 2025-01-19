package;

import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.FlxG;

class Util {
    public static function createText(x: Float, y: Float, text: String, size: Int = 16): FlxText {
        var field = new FlxText(x, y, 0, text, size);
        field.color = FlxColor.WHITE;
        field.textField.background = true;
        field.textField.backgroundColor = 0x1e2019;
        return field;
    }

    public static function handleDamageCalc(attacker: Float, defender: Float): Int {
        var aVar: Float = FlxG.random.int(25, 45) / 100;
        var dVar: Float = FlxG.random.int(25, 45) / 100;
        var d = ((attacker * 4) * aVar) - ((defender * 2) * dVar);
        if (d < 0) {
            return 0;
        }
        return Std.int(d);
    }

}