import wollok.game.*

class MusicPlayer{
	var menuMusic = game.sound("audio/music/MainThemeSeaQ.mp3")
	var ingameMusic1 = game.sound("audio/music/MainThemeSeaQ.mp3")
	var bossMusic = game.sound("audio/music/MainThemeSeaQ.mp3")
	var gameOverMusic = game.sound("audio/music/MainThemeSeaQ.mp3")
	
	const trackList = [menuMusic,ingameMusic1,bossMusic,gameOverMusic]
	var nowPlaying = 0
	
	const defaultMusicVolume = 0.4

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
		menuMusic = game.sound("audio/music/MainThemeSeaQ.mp3")
		self.setAndPlay(menuMusic,1,true,defaultMusicVolume,20)
	}
	method playIngameMusic1(){
		ingameMusic1 = game.sound("audio/music/MainThemeSeaQ.mp3")
		self.setAndPlay(ingameMusic1,2,true,defaultMusicVolume,150)
	}
	method playBossMusic(){
		bossMusic = game.sound("audio/music/MainThemeSeaQ.mp3")
		self.setAndPlay(bossMusic,3,true,defaultMusicVolume,20)
	}
	method playGameOverMusic(){
		gameOverMusic = game.sound("audio/music/MainThemeSeaQ.mp3")
		self.setAndPlay(gameOverMusic,4,true,defaultMusicVolume,20)
	}
	//DES.: Evaluar si se puede usar loop false en playGameOverMusic(). Ojo que stopAllMusic() puede tirar error.
}

class FxPlayer {
	const defaultSfxVolume = 0.5
	
	method setAndPlay(track,loop,volume){
		track.shouldLoop(loop)
		track.volume(volume)
		track.play()
	}
	
	//Nota: Acá no se referencian las pistas a variables ni constantes para que al terminar
	//de reproducirse, queden sin referencia y se las lleve el recolector de basura
	
	method playShoot(){self.setAndPlay(game.sound("audio/sfx/Shoot.mp3"),false,defaultSfxVolume)}
	method playPlayerDie(){self.setAndPlay(game.sound("audio/sfx/PlayerDie.mp3"),false,defaultSfxVolume)}
	method playEnemyDie1(){self.setAndPlay(game.sound("audio/sfx/EnemyDie1.mp3"),false,defaultSfxVolume)}
	method playEnemyDie2(){self.setAndPlay(game.sound("audio/sfx/EnemyDie2.mp3"),false,defaultSfxVolume)}
	method playKrakenAttack(){self.setAndPlay(game.sound("audio/sfx/KrakenAttack.mp3"),false,defaultSfxVolume)}
	method playKrakenDie(){self.setAndPlay(game.sound("audio/sfx/KrakenDie.mp3"),false,defaultSfxVolume)}
	
	method delayBubble(){
		const bubbleSound = game.sound("audio/sfx/Bubble.mp3")
		const delay = 3000.randomUpTo(9000)
		bubbleSound.shouldLoop(false)
		bubbleSound.volume(defaultSfxVolume)
		game.schedule(delay, {bubbleSound.play()})
	}
	method playBubbles(){game.onTick(3500, "playBubble", { => self.delayBubble() })}
}

//Instanciaciones:
const musicPlayer = new MusicPlayer()
const fxPlayer = new FxPlayer()
