import wollok.game.*
import sounds.*
import personaje.*
import proyectil.*
import userInterface.*
import enemigos.*

object gameManager {
	var score
	var interface
	var sharkSpeed
	var sharkSpawnerSpeed
	var swordfishSpeed
	var swordfishSpawnerSpeed
	var diverSpeed
	var diverSpawnerSpeed
	var flag = true
	var contador = 18
	var personajeReferencia
	
	method start(){
		self.config()
		self.menu()
	}
	
	method config(){
		game.title("Ocean Mission")
		game.cellSize(16)
		game.width(100)
		game.height(60)
	}	
	
	method menu(){
		interface = new UserInterface()
		self.restartScore()
		score = 98
		contador = 1
		musicPlayer.playMenuMusic()
		keyboard.p().onPressDo {
        	musicPlayer.volumeUp()
        	fxPlayer.volumeUp()
    	}
    	keyboard.l().onPressDo {
        	musicPlayer.volumeDown()
        	fxPlayer.volumeDown()
    	}
    	
		interface.startUI()
		keyboard.enter().onPressDo { if(!interface.gameStarted() && !interface.diffMenu()) self.difficultySelection()}
	}
	
	method difficultySelection(){
		interface.startDifficultySelector()
		keyboard.num1().onPressDo { if(!interface.gameStarted()) self.startGame(true) }
		keyboard.num2().onPressDo { if(!interface.gameStarted()) self.startGame(false) }
	}
	
	method startGame(esFacil){
		interface.startGame()
		musicPlayer.playIngameMusic1()
		fxPlayer.playBubbles()
		personajeReferencia = new Personaje()
		personajeReferencia.inicializar()
		self.configAndPlayEnemys(esFacil)
		keyboard.t().onPressDo{self.gameOver()}
	}
	
	method configAndPlayEnemys(esFacil){
		if(esFacil){
			diverSpeed = 300
			diverSpawnerSpeed = 20000
			
			swordfishSpeed = 100
			swordfishSpawnerSpeed = 12000
			
			sharkSpeed = 250
			sharkSpawnerSpeed = 15000
		}else {
			diverSpeed = 150
			diverSpawnerSpeed = 20000
			
			swordfishSpeed = 50
			swordfishSpawnerSpeed = 12000
			
			sharkSpeed = 75
			sharkSpawnerSpeed = 15000
		}
		game.onTick(swordfishSpawnerSpeed,"spawnSwordfish",{=>self.spawnerSwordFish()})
		game.onTick(diverSpawnerSpeed,"spawnDiver",{=>self.spawnerDiver()})
	}
	
	method spawnerSwordFish(){
		new PezEspada(velocidad = swordfishSpeed).inicializar()
	}
	method spawnerShark(){
		new Tiburon(velocidad = swordfishSpeed).inicializar()
	}
	method spawnerDiver(){
		new Buzo(velocidad = diverSpeed).inicializar()
	}
	 
	method gameOver(){
		flag=true
		musicPlayer.stopAllMusic()
		fxPlayer.stopBubbles()
		game.clear()
		self.menu()
		console.println("terminado")
		try{
			game.removeTickEvent("spawnDiver")
			game.removeTickEvent("spawnSwordfish")
			game.removeTickEvent("spawnShark")
		} 
		catch e: Exception{
			console.println(e)
		}
		
	}
	
	method aumentarPuntaje(points){
		score = if(points<0) 0.max(score+points) else 9999.min(score+points)
		interface.updateScore(score)
		
		if(flag and score>=30) {
			game.onTick(sharkSpawnerSpeed,"spawnShark",{=>self.spawnerShark()})
			flag = false
		} else if (score >= 100 * contador){
			contador += 1
			new Kraken(personajeReferencia = personajeReferencia).inicializar()
			musicPlayer.playBossMusic()
		}
	}
	
	method score() = score
	
	method restartScore() { 
		score = 0
		interface.updateScore(score)
	}
	
	method updateLife(lifes){
		interface.updateLifes(lifes)
	}
	
	method updateOxygen(oxygen){
		interface.updateOxygen(oxygen)
	}
}

