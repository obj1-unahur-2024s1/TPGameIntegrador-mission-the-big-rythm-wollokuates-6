import wollok.game.*
import proyectil.*
import gameManager.*
import enemigos.*
import sounds.*

class Sensor{
	var cuerpo
	var position
	var velocidad = 2
	
	method position() = position
	method activarColision(){
		game.whenCollideDo(self, {element=>self.chocarCon(element)})
	}
	
	method moverSensorDerecha(){
		position = game.at(position.x()+velocidad,position.y())
	}
	method moverSensorIzquierda(){
		position = game.at(position.x()-velocidad,position.y())
	}
	method moverSensorArriba(){
		position = game.at(position.x(),position.y()+velocidad)
	}
	method moverSensorAbajo(){
		position = game.at(position.x(),position.y()-velocidad)
	}
	
	method chocarCon(objeto) { 
        if(objeto.esEnemigo()) cuerpo.perderVida()
        else objeto.salvado() 
    }
    
    method addVisual(){
    	if(!game.hasVisual(self)) {
			game.addVisual(self)
		}
    }
}