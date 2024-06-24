import wollok.game.*
import gameManager.*
import proyectil.*



class Enemigo {
	var vida = 1
	var position
	var image
	var estaALaIzq = true 
	var velocidad = 0
	var tickID = ""
	
	method image() = image
	method position() = position
	
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
		game.removeTickEvent(tickID)
	}
	
	
	method destruidoPorElPlayer() {
		self.morir()
	}
	
	
	method crearTickID() { // tick id para el enemigo
		tickID = self.className() + 0.randomUpTo(999).toString() + 0.randomUpTo(999).toString()
	}
	
	method chocarCon(objeto){ // *
		if(objeto.className() == "proyectil.Proyectil") self.destruidoPorElPlayer() // 
		else if(objeto.className() == "player.Player") self.morir()
	}
	
	method inicializar(){    // 
		self.crearTickID()
		game.addVisual(self)
		estaALaIzq = self.position().x() < game.center().x() 
		game.onTick(velocidad, tickID, { => self.movimiento()})
		game.onCollideDo(self, { algo => self.chocarCon(algo) }) // *
		
	}
	
	method saleDelTablero(){ // elimina al enemigo al salir del tablero
		if (position.x() < -3 or position.x() > game.height() + 3) self.morir() 
	}
}

                                     // ------------------------------------------------------------------ 

class Tiburon inherits Enemigo{
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
		tickLanzamiento= self.className() + 0.randomUpTo(999).toString() + 0.randomUpTo(999).toString()
	}
	
	method crearRemora() {  // Instanciar/crear la remora 
		self.cambioEstadoDisparo()
		var remora = new Remora(position = self.position(), image = "bichoPrueba.png", velocidad = 2500, disparadaPor = self)
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
		self.cadenciaDisparo()
	}
	
}

							// ------------------------------------------------------------------ 

class Remora inherits Enemigo{
	 // Determinar a qué lado va eyectada la remora
	var disparadaPor 
	
	override method morir(){ // 
		super()
		disparadaPor.cambioEstadoDisparo()
	}
	
	
	
	
	
}

							// ------------------------------------------------------------------ 

class PezEspada inherits Enemigo{
	// TO DO
	override method destruidoPorElPlayer(){ // destruye al enemigo y aumenta el puntaje
		super()
		gameManager.aumentarPuntaje(3) 
	}
}


							// ------------------------------------------------------------------ 
									
class Kraken inherits Enemigo{
	/* - method cambiarDeLado() ¿?
	 */
	method spawnearEnemigo()
	method dispararProyectil()
	method ataqueTentaculo()
}















