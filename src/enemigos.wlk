import wollok.game.*
import gameManager.*
import proyectil.*
import animaciones.*
import sensores.*


class Enemigo {
	var vida = 1
	var position = self.randomPosition()
	var estaALaIzq = self.position().x() < game.center().x() 
	var velocidad = 0
	var tickID = ""
	
	
	var property nombre
	var property framesAnimacion
	const animacion = new Animacion(nombreEntidad = nombre, cantidadFrames = framesAnimacion, idAnimacion 
		= self.crearTickID(), direccion = if (estaALaIzq) "D" else "L")
	const animacionBoss = new AnimacionTentaculo(nombreEntidad = nombre, cantidadFrames = framesAnimacion, idAnimacion = self.crearTickID(), direccion = "")
	
	method esTentaculo() = false
	
	method salvado(){}
	
	method image() = animacion.image()
	
	method frame() = animacion.frame()
	
	method position() = position
	
	method estaALaIzq() = estaALaIzq
	
	method velocidad() = velocidad
	
	method randomPosition(){
        var posicionY = self.posicionPar()
        var posicionX= if(1.randomUpTo(100).truncate(0) > 50) 0 else game.width()
        return game.at(posicionX,posicionY)
    }

    method posicionPar(){
        var posicionY = 2.randomUpTo(50).truncate(0)
        if(!posicionY.even()) posicionY =self.posicionPar()
        return posicionY
    }
	
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
		animacion.inicializar()
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
		var remora = new Remora(position = self.position(), velocidad = velocidad/2, disparadaPor = self, estaALaIzq = self.estaALaIzq())
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
		gameManager.aumentarPuntaje(5) 
	}
}


							// ------------------------------------------------------------------ 
									

class Kraken inherits Enemigo (nombre = "kraken", framesAnimacion = 1){
	 
	var puedePegar = true

	
	override method movimiento(){}
	override method chocarCon(objeto) {} 
	override method destruidoPorElPlayer(){}
	
	method habilitarLanzamiento(){ // puede lanzar tentáculo.
		puedePegar = true
	}
	
	method crearTickTentaculos(){
		tickID = self.className() + 0.randomUpTo(99).toString() + 0.randomUpTo(99).toString()
	}
	
	override method randomPosition() = game.at(5,5)
	
	method crearTentaculo(){
		if(puedePegar){
			new Tentaculos(kraken = self).inicializar() 
			puedePegar = false
		}   
	}
	
	method cadenciaLanzamiento(){  
		game.onTick(1000, tickID, {  self.crearTentaculo() } )
	}
	
	override method inicializar(){
		animacionBoss.inicializar()
		game.addVisual(self)
		self.crearTickTentaculos()
		self.cadenciaLanzamiento()
		
		
	}
	
	override method image() = animacionBoss.image()
	override method frame() = animacionBoss.frame()
}


class Tentaculos inherits Enemigo (nombre = "tentaculo", framesAnimacion = 12){
	// TO DO
	var kraken 
	
	
	override method chocarCon(objeto){}
	override method movimiento(){}
	
	override method esTentaculo() = true
	override method esEnemigo() = false
	
	method serDestruido(){
		if(self.frame() == 12){
			game.removeVisual(self)
			animacionBoss.removeTick()
			kraken.habilitarLanzamiento() 
			gameManager.aumentarPuntaje(1)
			game.removeTickEvent("deteccionMuerte")
		}
	}
	
	override method randomPosition(){
        const x = 0
        const posicion = [game.at(x,8), game.at(x,16), game.at(x,24), game.at(x,32), game.at(x,40)]
        return posicion.anyOne()
    }
    
    override method inicializar(){
    	animacionBoss.inicializar()
    	game.addVisual(self)
    	game.onTick(1, "deteccionMuerte", {=> self.serDestruido()})
    }
    
    override method image() = animacionBoss.image()
	override method frame() = animacionBoss.frame()
}

							// -----------------------------------------------------------------
class Buzo inherits Enemigo(nombre = "buzo", framesAnimacion = 2){
	override method destruidoPorElPlayer(){
		super()
		gameManager.aumentarPuntaje(-5) 
	}
	override method esEnemigo() = false
	
	override method salvado(){
		gameManager.aumentarPuntaje(5)
		self.morir()
	}
}
