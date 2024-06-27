import wollok.game.*
import sounds.*
import personaje.*
import proyectil.*
import userInterface.*
import enemigos.*

object gameManager {
	var score
	var music
	var fx
	var interface
	var sharkSpeed
	var sharkSpawnerSpeed
	var swordfishSpeed
	var swordfishSpawnerSpeed
	var diverSpeed
	var diverSpawnerSpeed
	var flag = true
	
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
		music =new MusicPlayer()
		fx = new FxPlayer()
		interface = new UserInterface()
		self.restartScore()
		score = 95
		//music.playIngameMusic1()
		fx.playBubbles()
		keyboard.p().onPressDo {
        	music.volumeUp()
        	fx.volumeUp()
    	}
    	keyboard.l().onPressDo {
        	music.volumeDown()
        	fx.volumeDown()
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
		new Personaje().inicializar()
		self.configAndPlayEnemys(esFacil)
		keyboard.t().onPressDo{self.gameOver()}
	}
	
	method configAndPlayEnemys(esFacil){
		if(esFacil){
			diverSpeed = 1200
			diverSpawnerSpeed = 6000
			swordfishSpeed = 700
			swordfishSpawnerSpeed = 5000
			sharkSpeed = 1000
			sharkSpawnerSpeed = 5000
		}else {
			diverSpeed = 300
			diverSpawnerSpeed = 6000
			swordfishSpeed = 100
			swordfishSpawnerSpeed = 5000
			sharkSpeed = 250
			sharkSpawnerSpeed = 5000
		}
		game.onTick(swordfishSpawnerSpeed,"spawnSwordfish",{=>self.spawnerSwordFish()})
		game.onTick(diverSpawnerSpeed,"spawnBuzo",{=>self.sparnerDiver()})
		new Kraken().inicializar()
	}
	
	method spawnerSwordFish(){
		new PezEspada(velocidad = swordfishSpeed).inicializar()
	}
	method spawnerShark(){
		new Tiburon(velocidad = swordfishSpeed).inicializar()
	}
	method sparnerDiver(){
		new Buzo(velocidad = diverSpeed).inicializar()
	}
	
	method gameOver(){
		flag=true
		//music.stopAllMusic()
		game.clear()
		self.menu()
		game.removeTickEvent("spawnBuzo")
		game.removeTickEvent("spawnPezEspada")
		game.removeTickEvent("spawnTiburon")
	}
	
	method aumentarPuntaje(points){
		score = if(points<0) 0.max(score+points) else 9999.min(score+points)
		interface.updateScore(score)
		
		if(flag and score>=30) {
			game.onTick(sharkSpawnerSpeed,"spawnShark",{=>self.spawnerShark()})
			flag = false
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

