import wollok.game.*
import pepita.*

object gameManager {
	var difficulty
	var score
	
	method iniciar(){
		self.config()
		self.agregarVisuales()
	}
	method config(){
		game.title("Ocean Quest")
		game.cellSize(16)
		game.width(100)
		game.height(60)
	}
	method agregarVisuales(){
		game.addVisual(pepita)
	}
	method makeLevel(){
		/*
		 * instanciar:
		 * pj
		 * ui
		 * enemigos
		 */
	}
	method pause(){
		
	}
	method gameOver(){
		
	}
	method scoreUp(points){ score = 999.max(score+points) }
	method score() = score
	method restartScore() { score = 0 }
	method difficulty() = difficulty
	method difficulty(newDifficulty){ difficulty = newDifficulty }
}
