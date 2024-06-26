import wollok.game.*
import gameManager.*
import proyectil.*
import animaciones.*


class Enemigo {
	var vida = 1
	var position
	var estaALaIzq = self.position().x() < game.center().x() 
	var velocidad = 0
	var tickID = ""
	
	var property nombre
	var property framesAnimacion
	const animacion = new Animacion(nombreEntidad = nombre, cantidadFrames = framesAnimacion, idAnimacion = self.crearTickID(), direccion = if (estaALaIzq) "D" else "L")
	
	method image() = animacion.image()
	
	method position() = position
	
	method estaALaIzq() = estaALaIzq
	
	method movimiento() { 
		if(estaALaIzq){
			position = game.at(position.x() + 1, position.y())
		} else {
			position = game.at(position.x() - 1, position.y())
		}
	
		self.saleDelTablero() // detecta si sale del tablero, elimina el onTick y objeto
	}
	
	
	method morir(){ 
		game.removeVisual(self)
		animacion.removeTick()
		game.removeTickEvent(tickID)
		console.println("Muerto: " + nombre)
	}
	
	
	method destruidoPorElPlayer() {
		self.morir()
	}
	
	
	method crearTickID() { // tick id para el enemigo
		return self.className() + 0.randomUpTo(999).toString() + 0.randomUpTo(999).toString()
	}
	
	method chocarCon(objeto){ // *
		if(objeto.className() == "proyectil.Proyectil") self.destruidoPorElPlayer() // 
		else if(objeto.className() == "player.Player") self.morir()
	}
	
	method inicializar(){    // 
		tickID = self.crearTickID()
		game.addVisual(self)
		game.onTick(velocidad, tickID, { => self.movimiento()})
		game.onCollideDo(self, { algo => self.chocarCon(algo) }) // *
		
	}
	
	method saleDelTablero(){ // elimina al enemigo al salir del tablero
		if (position.x() < -3 or position.x() > game.width() + 3) self.morir() 
	}
	
	method esEnemigo() = true
}

                                     // ------------------------------------------------------------------ 

class Tiburon inherits Enemigo(nombre = "tiburon", framesAnimacion = 3){
	var tickLanzamiento = ""
	var puedeDisparar = true
	
	method cambioEstadoDisparo() {
		puedeDisparar = not puedeDisparar
	}
	
	override method morir() { 
		super()
		game.removeTickEvent(tickLanzamiento)
		
	}
	
	override method destruidoPorElPlayer(){ // destruye al enemigo y aumenta el puntaje
		super()
		gameManager.aumentarPuntaje(5) 
	}
	
	
	method crearTick() { // id para la remora
		tickLanzamiento = self.className() + 0.randomUpTo(999).toString() + 0.randomUpTo(999).toString()
	}
	
	method crearRemora() {  // Instanciar/crear la remora 
		self.cambioEstadoDisparo()
		var remora = new Remora(position = self.position(), velocidad = 300, disparadaPor = self, estaALaIzq = self.estaALaIzq())
		remora.inicializar()
		
	}
	
	method dispararRemora() {
		if (puedeDisparar) self.crearRemora()
	}
	
	method cadenciaDisparo(){  // tiempo entre disparos
		game.onTick(1000, tickLanzamiento, { => self.dispararRemora() } )
	}
	
	override method inicializar(){ 
		super()
		self.crearTick()
		self.cadenciaDisparo()
	}
	
}

							// ------------------------------------------------------------------ 

class Remora inherits Enemigo(nombre = "remora", framesAnimacion = 2){
	 // Determinar a qué lado va eyectada la remora
	var disparadaPor 
	
	override method morir(){ // 
		super()
		disparadaPor.cambioEstadoDisparo()
	}
	

}

							// ------------------------------------------------------------------ 

class PezEspada inherits Enemigo(nombre = "pezespada", framesAnimacion = 3){
	// TO DO
	override method destruidoPorElPlayer(){ // destruye al enemigo y aumenta el puntaje
		super()
		gameManager.aumentarPuntaje(3) 
	}
}


							// ------------------------------------------------------------------ 
									
class Kraken inherits Enemigo{
    method cambiarDeLado() 
	method dispararProyectil()
	
}


class Buzo inherits Enemigo(nombre = "buzo", framesAnimacion = 2){
	override method destruidoPorElPlayer(){
		super()
		gameManager.aumentarPuntaje(-5) 
	}
	override method esEnemigo() = false
}
