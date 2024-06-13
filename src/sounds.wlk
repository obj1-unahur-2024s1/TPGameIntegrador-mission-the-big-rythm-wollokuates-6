import wollok.game.*

class SoundPlayer{
	method play(sound, delay){game.schedule(delay, {sound.play()})}
}

object musicPlayer inherits SoundPlayer{
	const ingameMusic1 = game.sound("audio/music/MainThemeSeaQ.mp3")
	
	method playIngameMusic1(){
		ingameMusic1.shouldLoop(true)
		self.play(ingameMusic1, 1000)
	}
}

object fxPlayer inherits SoundPlayer{
	
}