package states;

import flixel.FlxObject;
import flixel.effects.FlxFlicker;
import lime.app.Application;
import states.editors.MasterEditorMenu;
import options.OptionsState;
import flixel.addons.display.FlxBackdrop;

class MainMenuState extends MusicBeatState
{
	var options:Array<String> = ["Story", "Freeplay", "Map", "Credits", "Settings"];
	var optGroup:FlxTypedGroup<FlxText>;

	var cursor:FlxSprite;
	var bg:FlxBackdrop;

	var lastSelected:String = '';

	public static var psychEngineVersion:String = '1.0.4';

	override function create(){
		super.create();

		//var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg = new FlxBackdrop(Paths.image('Pig'));
		add(bg); 

		var bg2 = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg2.alpha = 0.5;
		add(bg2); 

		cursor = new FlxSprite().loadGraphic(Paths.image('Cursor'));
		cursor.scale.set(0.05, 0.05);
		cursor.updateHitbox();
		add(cursor); 

		optGroup = new FlxTypedGroup<FlxText>();
		add(optGroup);

		for(i in 0...options.length){
			var option = new FlxText(25, 50 * i, 0, options[i], 30, false);
			option.antialiasing = false;
			optGroup.add(option);
		}
	}

	override function update(elapsed:Float){

		cursor.x = FlxG.mouse.x - 20;
		cursor.y = FlxG.mouse.y - 20;

		bg.x += FlxG.mouse.x / 500;
		bg.y += FlxG.mouse.y / 500;

		lastSelected = '';
		for(thingy in optGroup.members){
			if(FlxG.mouse.overlaps(thingy) && lastSelected != thingy.text){
				lastSelected = thingy.text;
				FlxTween.cancelTweensOf(thingy);
				FlxTween.tween(thingy.scale, {x: 1.5}, 0.1);
				FlxTween.tween(thingy, {x: 50, alpha: 1}, 0.1, {ease: FlxEase.elasticInOut});

			}else{
				if(!FlxG.mouse.overlaps(thingy) && lastSelected != thingy.text){
					FlxTween.cancelTweensOf(thingy);
					FlxTween.tween(thingy.scale, {x: 1}, 0.1);
					FlxTween.tween(thingy, {x: 25, alpha: 0.3}, 0.1, {ease: FlxEase.elasticInOut});
				}
			}
		}

		if(FlxG.mouse.justPressed){
			FlxTween.cancelTweensOf(cursor.scale);
			cursor.scale.y = 0.005;
			FlxTween.tween(cursor.scale, {y: 0.05}, 0.3, {ease: FlxEase.elasticInOut});

			for(thingy in optGroup.members){
				if(FlxG.mouse.overlaps(thingy)){
					switch(thingy.text){
						case "Story" :
							MusicBeatState.switchState(new StoryMenuState());
						case "Freeplay" :
							MusicBeatState.switchState(new FreeplayState());
						case "Map" :
							MusicBeatState.switchState(new MapState());
						case "Credits" :
							MusicBeatState.switchState(new CreditsState());
						case "Settings" :
							MusicBeatState.switchState(new OptionsState());
					}
				}
			}
		}

		super.update(elapsed);
	}

}