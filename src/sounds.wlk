import wollok.game.*

class SoundPlayer{
	method play(sound, delay){game.schedule(delay, {sound.play()})}
	method stop(sound){sound.stop()}
}

class MusicPlayer inherits SoundPlayer{
	const menuMusic = game.sound("audio/music/MainThemeSeaQ.mp3")
	const ingameMusic1 = game.sound("audio/music/MainThemeSeaQ.mp3")
	const bossMusic = game.sound("audio/music/MainThemeSeaQ.mp3")
	const gameOverMusic = game.sound("audio/music/MainThemeSeaQ.mp3")
	var isPlayingMenuMusic = false
	var isPlayingIngameMusic1 = false
	var isPlayingBossMusic = false
	var isPlayingGameOverMusic = false
	const musicVolume = 0.4

	method setTrackConfig(track,loop){
		track.shouldLoop(loop)
		track.volume(musicVolume)
	}
	
	method stopAllMusic(){
		if (isPlayingMenuMusic) {
			self.stop(menuMusic)
			isPlayingMenuMusic = false
		}
		if (isPlayingIngameMusic1) {
			self.stop(ingameMusic1)
			isPlayingIngameMusic1 = false
		}
		if (isPlayingBossMusic) {
			self.stop(bossMusic)
			isPlayingBossMusic = false
		}
		if (isPlayingGameOverMusic) {
			self.stop(gameOverMusic)
			isPlayingGameOverMusic = false
		}
	}

	method playMenuMusic(){
		self.setTrackConfig(menuMusic,true)
		self.stopAllMusic()
		self.play(menuMusic, 1000)
		isPlayingMenuMusic = true
	}
	
	method playIngameMusic1(){
		self.setTrackConfig(ingameMusic1,true)
		self.stopAllMusic()
		self.play(ingameMusic1, 1000)
		isPlayingIngameMusic1 = true
	}
	
	method playBossMusic(){
		self.setTrackConfig(bossMusic,true)
		self.stopAllMusic()
		self.play(bossMusic, 1000)
		isPlayingBossMusic = true
	}
	
	method playGameOverMusic(){
		self.setTrackConfig(gameOverMusic,true)
		self.stopAllMusic()
		self.play(gameOverMusic, 1000)
		isPlayingGameOverMusic = true
	}
	
}

class FxPlayer inherits SoundPlayer{
	
}

const musicPlayer = new MusicPlayer()
const fxPlayer = new FxPlayer()