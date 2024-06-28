import wollok.game.*
import proyectil.*
import gameManager.*
import enemigos.*
import sounds.*
import personaje.*

class Sensor{
	const topeAncho = 96
	const topeAlto = 50
	const posCuerpo
	var cuerpo
	var position
	const velocidad = 2
	
	method position() = position
	method activarColision(){
		game.whenCollideDo(self, {element=>cuerpo.chocarCon(element)})
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
    
    method addVisual(){
    	if(!game.hasVisual(self)) {
			game.addVisual(self)
		}
    }
        
    method removeVisual(){
		if(game.hasVisual(self)) {
			game.removeVisual(self)		
		}
	}
	
	method reAcomodarSensor(){
		position = game.at(cuerpo.position().x()+posCuerpo.x(),cuerpo.position().y()+posCuerpo.y())
	}
}