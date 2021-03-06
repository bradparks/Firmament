package;


import flash.display.Sprite;
import flash.display.Bitmap;
import firmament.core.FGame;
import flash.Lib;
import openfl.Assets;
class Main extends Sprite{

	var splashScreen:Bitmap;
	public	function new(){

		super();
		setupTrace();
		
		showSplashScreen();

		haxe.Timer.delay(setupEngine,2000);

	}

	private	function setupTrace(){
		#if (flash9 || flash10)
		haxe.Log.trace = function(v,?pos) { untyped __global__["trace"](pos.className+"#"+pos.methodName+"("+pos.lineNumber+"):",v); }
		#elseif flash
		haxe.Log.trace = function(v,?pos) { flash.Lib.trace(pos.className+"#"+pos.methodName+"("+pos.lineNumber+"): "+v); }
		#end
	}

	private	function showSplashScreen(){
		var stage = Lib.current.stage;
		splashScreen = new Bitmap();
		splashScreen.bitmapData = Assets.getBitmapData('assets/PixelBlitLogo.png');
		this.addChild(splashScreen);
		splashScreen.x = (stage.stageWidth - splashScreen.width) / 2;
		splashScreen.y = (stage.stageHeight - splashScreen.height) / 2;
		trace(splashScreen.x);
	}

	private function setupEngine(){
		
		var game:FGame = FGame.getInstance();


		var args = Sys.args();
		trace(args);
		var executableDir:String = Sys.executablePath();

		//HACKS
		Sys.setCwd("../../../../../../../");
		trace(Sys.getCwd());
		//load the scene via script!!!
		trace(game.executeFile("test.hx"));
	}
}