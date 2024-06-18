import wollok.game.*
import sounds.*
import personaje.*
import proyectil.*

object gameManager {
	var difficulty
	var score
	
	method iniciar(){
		self.config()
		self.agregarVisuales()
		personaje.inicializar()
		musicPlayer.playIngameMusic1()
	}
	method config(){
		game.title("Ocean Quest")
		game.cellSize(16)
		game.width(100)
		game.height(60)
	}
	method agregarVisuales(){
		//game.addVisual(pepita)
	}
	method makeLevel(){
		/*
		 * instanciar:
		 * ui
		 * enemigos
		 */
	}
	method pause(){
		
	}
	method gameOver(){
		
	}
	method aumentarPuntaje(points){ score = 999.max(score+points) }
	method score() = score
	method restartScore() { score = 0 }
	method difficulty() = difficulty
	method difficulty(newDifficulty){ difficulty = newDifficulty }
}

class Buzo{
	method puntos() = 5 
}