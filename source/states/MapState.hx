package states;

import flixel.FlxObject;
import flixel.addons.display.FlxBackdrop;
import flixel.FlxG;
import flixel.FlxCamera.FlxCameraFollowStyle;
class MapState extends MusicBeatState
{
	var bg:FlxBackdrop;
	var map:FlxSprite;
	var player:FlxSprite;
	private var camFollowPos:FlxObject;

	override function create(){
		super.create();

		var baseCam = new FlxCamera(0, 0, FlxG.width, FlxG.height, 1);
		FlxG.cameras.add(baseCam);
		FlxG.camera = baseCam;
		baseCam.bgColor = 0x00080808;
		FlxG.cameras.setDefaultDrawTarget(baseCam, true);


		bg = new FlxBackdrop(Paths.image('MapBg'));
		bg.updateHitbox();
		bg.scale.set(0.5, 0.5);
		bg.screenCenter();
		bg.antialiasing = ClientPrefs.data.antialiasing;
		add(bg); 

		map = new FlxSprite().loadGraphic(Paths.image('MAP1'));
		map.scale.set(50, 50);
		map.updateHitbox();
		map.antialiasing = ClientPrefs.data.antialiasing;
		add(map); 

		player = new FlxSprite(0, 0);
		player.frames = Paths.getSparrowAtlas('player');
		player.animation.addByPrefix('front', 'front', 24, true);
		player.animation.addByPrefix('back', 'back', 24, true);
		player.animation.addByPrefix('leftface', 'leftface', 24, true);
		player.animation.addByPrefix('rightface', 'rightface', 24, true);
		player.animation.play('front');
		player.updateHitbox();
		player.screenCenter();
		player.antialiasing = ClientPrefs.data.antialiasing;
		player.scrollFactor.set();
		add(player); 
		player.cameras = [];


		camFollowPos = new FlxObject(0, 0, 1, 1);
		add(camFollowPos);
		FlxG.camera.follow(camFollowPos, LOCKON, 1);
	}

	override function update(elapsed:Float){
		if(FlxG.keys.pressed.LEFT){
			player.x -= 350 * elapsed;
			player.animation.play('leftface');
		}
		if(FlxG.keys.pressed.RIGHT){
			player.x += 350 * elapsed;
			player.animation.play('rightface');
		}
		if(FlxG.keys.pressed.DOWN){
			player.y += 350 * elapsed;
			player.animation.play('front');
		}
		if(FlxG.keys.pressed.UP){
			player.y -= 350 * elapsed;
			player.animation.play('back');
		}

		camFollowPos.setPosition(FlxMath.lerp(camFollowPos.x, player.x, elapsed * 2.4), FlxMath.lerp(camFollowPos.y, player.y, elapsed * 2.4));

		super.update(elapsed);
	}

}