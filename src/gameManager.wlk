import wollok.game.*
import sounds.*
import personaje.*
import proyectil.*
import userInterface.*
import enemigos.*

object gameManager {
	var difficulty
	var score
	
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
		self.restartScore()
		musicPlayer.playIngameMusic1()
		uiController.startUI()
		keyboard.enter().onPressDo { if(!uiController.gameStarted() && !uiController.diffMenu()) self.difficultySelection()}
	}
	
	method difficultySelection(){
		uiController.startDifficultySelector()
		keyboard.num1().onPressDo { if(!uiController.gameStarted()) self.startGame(true) }
		keyboard.num2().onPressDo { if(!uiController.gameStarted()) self.startGame(false) }
	}
	
	method startGame(estaEnFacil){
		difficulty = estaEnFacil
		uiController.startGame()
		personaje.inicializar()
	}
	
	//TO DO: cambiar el clean porque rompe todo, usar un metodo que saque solamente lo necesario
	method gameOver(){
		musicPlayer.stopAllMusic()
		game.clear()
		self.menu()
	}
	
	method aumentarPuntaje(points){ 
		score = 999.max(score+points)
		uiController.updateScore(score)
	}
	
	method score() = score
	
	method restartScore() { 
		score = 0
		uiController.updateScore(score)
	}
	
	method updateLife(lifes){
		uiController.updateLifes(lifes)
	}
	
	method updateOxygen(oxygen){
		uiController.updateOxygen(oxygen)
	}
}

