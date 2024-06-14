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
		(1..trackList.size()).forEach {n => if(n == nowPlaying) {trackList.get(n+1).stop()}}
		nowPlaying = 0
	}

	method setAndPlay(track,trackNumber,loop,volume,delay){
		self.stopAllMusic()
		track.shouldLoop(loop)
		track.volume(volume)
		game.schedule(delay, {track.play()})
		nowPlaying = trackNumber
	}
	
	method playMenuMusic(){self.setAndPlay(menuMusic,1,true,defaultMusicVolume,1000)}
	method playIngameMusic1(){self.setAndPlay(ingameMusic1,2,true,defaultMusicVolume,1800)}
	method playBossMusic(){self.setAndPlay(bossMusic,3,true,defaultMusicVolume,1000)}
	method playGameOverMusic(){self.setAndPlay(gameOverMusic,4,false,defaultMusicVolume,1000)}
	
}

class FxPlayer {
	
}

const musicPlayer = new MusicPlayer()
const fxPlayer = new FxPlayer()