import wollok.game.*

class MusicPlayer{
	const menuMusic = game.sound("audio/music/MainThemeSeaQ.mp3")
	const ingameMusic1 = game.sound("audio/music/MainThemeSeaQ.mp3")
	const bossMusic = game.sound("audio/music/MainThemeSeaQ.mp3")
	const gameOverMusic = game.sound("audio/music/MainThemeSeaQ.mp3")
	
	const trackList = [menuMusic,ingameMusic1,bossMusic,gameOverMusic]
	var nowPlaying = 0
	
	const defaultMusicVolume = 0.4

	method stopAllMusic(){
		if (nowPlaying != 0) trackList.get(nowPlaying-1).stop()
		nowPlaying = 0
	}

	method setAndPlay(track,trackNumber,loop,volume,delay){
		self.stopAllMusic()
		track.shouldLoop(loop)
		track.volume(volume)
		game.schedule(delay, {track.play()})
		nowPlaying = trackNumber
	}
	
	method playMenuMusic(){self.setAndPlay(menuMusic,1,true,defaultMusicVolume,300)}
	method playIngameMusic1(){self.setAndPlay(ingameMusic1,2,true,defaultMusicVolume,1800)}
	method playBossMusic(){self.setAndPlay(bossMusic,3,true,defaultMusicVolume,300)}
	method playGameOverMusic(){self.setAndPlay(gameOverMusic,4,true,defaultMusicVolume,300)}
	
}

class FxPlayer {
	method playShoot(){}
	method playPlayerDie(){}
	method playEnemyDie(){}
	method playKrakenAttack(){}
	method playKrakenDie(){}
}

const musicPlayer = new MusicPlayer()
const fxPlayer = new FxPlayer()