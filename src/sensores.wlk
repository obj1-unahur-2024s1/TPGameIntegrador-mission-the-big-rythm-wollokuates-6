import wollok.game.*

class Sensor {
	var position = new Position(x=0, y=0)
	
	const property haceDanio = false
	
	method position() = position
	method position(nuevaPosicion) {
		position = nuevaPosicion
	}
	
	method positionXY(x, y) {
		self.position(new Position(x=x , y=y))
	}
	
	method addVisual(){
		if(!game.hasVisual(self)){
			game.addVisual(self)
		}
	}
	
	method removeVisual(){
		if(game.hasVisual(self)){
			game.removeVisual(self)
		}
	}
	
	
	// activa el sensor
	method activarDeteccion(accion){
		game.whenCollideDo(self, accion)
	}
	
}
