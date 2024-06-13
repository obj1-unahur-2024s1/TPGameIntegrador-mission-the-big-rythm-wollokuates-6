import wollok.game.*

class SoundPlayer{
	method play(sound, delay){game.schedule(delay, {sound.play()})}
}

object soundManager inherits SoundPlayer{
	const ingameMusic1 = game.sound("audio/music/MainThemeSeaQ.mp3")
	
	method playIngameMusic1(){self.play(ingameMusic1, 1000)}
}
