import wollok.game.*

class MusicPlayer{
	var menuMusic = game.sound("audio/music/MainThemeSeaQ.mp3")
	var ingameMusic1 = game.sound("audio/music/MainThemeSeaQ.mp3")
	var bossMusic = game.sound("audio/music/MainThemeSeaQ.mp3")
	var gameOverMusic = game.sound("audio/music/MainThemeSeaQ.mp3")
	
	const trackList = [menuMusic,ingameMusic1,bossMusic,gameOverMusic]
	var nowPlaying = 0
	
	var musicVolume = 0.6

	method stopAllMusic(){
		//Nota: Se usa la var nowPlaying para saber que track está reproduciéndose que no se le de stop() a un audio que no está en reproducción
		//ya que si sucede, wollok devuelve un error.
		if (nowPlaying != 0) trackList.get(nowPlaying-1).stop()
		nowPlaying = 0
	}

	method setAndPlay(track,trackNumber,loop,volume,delay){
		self.stopAllMusic()
		track.shouldLoop(loop)
		track.volume(volume)
		game.schedule(delay, {track.play()})
		//Nota: Se renueva la colección trackList para quitar referencia a los audios ya reproducidos y
		//y se hace la nueva referencia:
		trackList.clear()
		trackList.addAll([menuMusic,ingameMusic1,bossMusic,gameOverMusic])
		nowPlaying = trackNumber
	}
	
	//Nota: Hay que volver cargar el audio (crear el objeto y referenciarlo a la var) antes de reproducirlo porque Wollok no permite
	//reproducir un objeto de audio que, aunque esté en stop, haya sido ya reproducido.
	method playMenuMusic(){
		menuMusic = game.sound("audio/music/MenuMusic.mp3")
		self.setAndPlay(menuMusic,1,true,musicVolume,20)
	}
	method playIngameMusic1(){
		ingameMusic1 = game.sound("audio/music/MainThemeSeaQ.mp3")
		self.setAndPlay(ingameMusic1,2,true,musicVolume,150)
	}
	method playBossMusic(){
		bossMusic = game.sound("audio/music/KrakenTheme.mp3")
		self.setAndPlay(bossMusic,3,true,musicVolume,20)
	}
	method playGameOverMusic(){
		gameOverMusic = game.sound("audio/music/MainThemeSeaQ.mp3")
		self.setAndPlay(gameOverMusic,4,true,musicVolume,20)
	}
	//DES.: Evaluar si se puede usar loop false en playGameOverMusic(). Ojo que stopAllMusic() puede tirar error.
	//Necesitaría que al terminar el track, se hiciera nowPlaying = 0 pero como wollok no tiene getter de la reproducción...
	
	method volumeUp(){
		musicVolume = (if (musicVolume >= 0.2) (musicVolume + 0.2) else (musicVolume + 0.1)).min(1)
		if (nowPlaying != 0) trackList.get(nowPlaying-1).volume(musicVolume)
	}
	method volumeDown(){
		musicVolume = (if (musicVolume > 0.2) (musicVolume - 0.2) else (musicVolume - 0.1)).max(0)
		if (nowPlaying != 0) trackList.get(nowPlaying-1).volume(musicVolume)
	}
}

class FxPlayer {
	var sfxVolume = 0.6
	
	method setAndPlay(track,loop,volume){
		track.shouldLoop(loop)
		track.volume(volume)
		track.play()
	}
	
	//Nota: Acá no se referencian las pistas a variables ni constantes para que al terminar
	//de reproducirse, queden sin referencia y se las lleve el recolector de basura (verificar)
	
	method playShoot(){self.setAndPlay(game.sound("audio/sfx/Shoot.mp3"),false,sfxVolume)}
	method playBip(){self.setAndPlay(game.sound("audio/sfx/BipEdit.mp3"),false,sfxVolume)}
	method playOxigen(){self.setAndPlay(game.sound("audio/sfx/Oxigen.mp3"),false,sfxVolume)}
	
	method playPlayerDie(){self.setAndPlay(game.sound("audio/sfx/PlayerDie.mp3"),false,sfxVolume)}
	method playEnemyDie1(){self.setAndPlay(game.sound("audio/sfx/EnemyDie1.mp3"),false,sfxVolume)}
	method playEnemyDie2(){self.setAndPlay(game.sound("audio/sfx/EnemyDie2.mp3"),false,sfxVolume)}
	method playTentacleAlarm(){self.setAndPlay(game.sound("audio/sfx/TentacleAlarm.mp3"),false,sfxVolume)}
	method playKrakenAttack(){self.setAndPlay(game.sound("audio/sfx/KrakenAttack.mp3"),false,sfxVolume)}
	method playKrakenDie(){self.setAndPlay(game.sound("audio/sfx/KrakenDie.mp3"),false,sfxVolume)}
	
	
	method setAndPlayBubble(){
		const bubbleSound = game.sound("audio/sfx/Bubble.mp3")
		bubbleSound.shouldLoop(false)
		bubbleSound.volume(sfxVolume)
		bubbleSound.play()
	}
	method delayBubble(){
		const delay = new Range(start = 3000, end = 9000).anyOne()
		game.schedule(delay, {self.setAndPlayBubble()})
	}
	method playBubbles(){game.onTick(3500, "playBubble", { => self.delayBubble() })}
	method stopBubbles(){game.removeTickEvent("playBubble")}
	
	method volumeUp(){sfxVolume = (if (sfxVolume >= 0.2) (sfxVolume + 0.2) else (sfxVolume + 0.1)).min(1)}
	method volumeDown(){sfxVolume = (if (sfxVolume > 0.2) (sfxVolume - 0.2) else (sfxVolume - 0.1)).max(0)}
}

//Instanciaciones:
const musicPlayer = new MusicPlayer()
const fxPlayer = new FxPlayer()
