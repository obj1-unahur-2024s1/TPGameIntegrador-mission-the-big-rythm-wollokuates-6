import wollok.game.*
import personaje.utilidades

class Proyectil {
	const direccion
	const topeDerecho = 100
	const topeIzquierdo = -1
	const velocidadDelDisparo = 15
	
	var position 
	var tickID = ""
	
	method image() { return "proyectil.png"}
	method position() { return position}
	method position(x,y) { position = game.at(x,y) }
	
	
	method controladorDeMovimiento() { 
		const pos = if(direccion == 1) utilidades.clamp(position.x() + 1, topeDerecho, true) else utilidades.clamp(position.x() - 1, topeIzquierdo, false)
		self.position(pos, position.y())
		if(pos == topeDerecho or pos == topeIzquierdo) self.destruir()
	}
	
	method disparar() { game.onTick(velocidadDelDisparo, tickID, { self.controladorDeMovimiento() }) }
	
	method chocarCon(objeto) {
		try{
			objeto.destruidoPorElPlayer()
			self.destruir()
		}
		catch e {}
	}
	
	method destruir() {
		game.removeTickEvent(tickID)
		game.removeVisual(self)
	}
	
	method crearTickID() {
		tickID = "moverProyectil" +  0.randomUpTo(99).toString()
	}
	
	method inicializar() {
		self.crearTickID()
		game.addVisual(self)
		game.onCollideDo(self, { algo => self.chocarCon(algo) })
		self.disparar()
	}
	
	method esEnemigo() { return false }
	method salvado() {}
}