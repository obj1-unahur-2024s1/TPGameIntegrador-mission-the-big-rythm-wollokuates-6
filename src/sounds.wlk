import wollok.game.*

object soundManager {
	const ingameMusic1 = game.sound("audio/music/MainThemeSeaQ.mp3")
	
	method playIngameMusic1(){
		game.schedule(1000, { ingameMusic1.play() })
	}


}
