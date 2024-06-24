import wollok.game.*
import proyectil.*
import gameManager.*

class Personaje {
	
	const origen = game.at(50, 58)
	const topeAncho = 98
	const topeAlto = 58
	const velocidad = 2
	
	var vidas = 3
	var oxigeno = 100
	var position = origen
	var direccionDisparo = 1
	var puedeDisparar = true
	
	method image() { return "pepita.png" }
	method position() { return position }
	method position(x,y) { position = game.at(x,y) }
	method habilitarDisparo() { puedeDisparar = true }
	
	method controladorDeMovimiento() {
		
		/*keyboard.left().onPressDo { self.moverIzquierda() }
		keyboard.right().onPressDo { self.moverDerecha() }
		keyboard.up().onPressDo { self.moverArriba() }
		keyboard.down().onPressDo { self.moverAbajo() }*/
		
		keyboard.a().onPressDo { self.moverIzquierda()  }
		keyboard.d().onPressDo { self.moverDerecha() }
		keyboard.w().onPressDo { self.moverArriba() }
		keyboard.s().onPressDo { self.moverAbajo() }
		
		keyboard.space().onPressDo { self.disparar() }
		
	}
	
	method moverIzquierda() {
		const pos = utilidades.clamp(position.x() - velocidad, topeAncho, true)
		self.position(pos, position.y())
		direccionDisparo = -1
	}
	
	method moverDerecha() {
		const pos = utilidades.clamp(position.x() + velocidad, topeAncho, true)
		self.position(pos, position.y())
		direccionDisparo = 1
	}
	
	method moverArriba() {
		const pos = utilidades.clamp(position.y() + velocidad, topeAlto, true)
		self.position(position.x(), pos)
	}
	
	method moverAbajo() {
		const pos = utilidades.clamp(position.y() - velocidad, topeAlto, true)
		self.position(position.x(), pos)
	}
	
	method disparar() {
		if(puedeDisparar) {
			const proyectil = new Proyectil(direccion = direccionDisparo, position = position )
			proyectil.inicializar()
			puedeDisparar = false
		}
	}
	
	method controladorDeOxigeno(valor, superficie){
		oxigeno = if(position.y() < topeAlto) (oxigeno - valor).max(0) else (oxigeno + valor).min(100)
		gameManager.updateOxygen(oxigeno)
		if(oxigeno == 0) self.perderVida()
		console.println("Oxigeno: " + oxigeno)
	}
	
	method chocarCon(objeto) { 
		if(objeto.className() == "personaje.tester") self.perderVida() // ver qué poner depende del tipo de enemigo (va type?)
		else if(objeto.className() == "Buzo") self.recoger(objeto.puntos()) 
	}
	
	method perderVida() { 
		vidas = (vidas - 1).max(0)
		gameManager.updateLife(vidas)
		if(vidas == 0) self.morir() else self.reset()
		console.println("Perdiste una vida, te quedan: " + vidas)
	}
	
	method reset(){
		position = origen
		oxigeno = 100
		gameManager.updateOxygen(oxigeno)
	}
	
	method recoger(puntaje) {gameManager.aumentarPuntaje(puntaje) }
	
	method morir() {gameManager.gameOver()}
	
	method inicializar() {
		game.addVisual(self)
		game.onCollideDo(self, { algo => self.chocarCon(algo) })
		self.controladorDeMovimiento()
		game.onTick(2000, "Oxigeno", { self.controladorDeOxigeno(5, 19) })
	}
	
}

object utilidades {
	
	method clamp(valor, tope, normal) { return if(normal) (valor.min(tope)).max(0) else valor.max(tope) }
	
}

const personaje = new Personaje()


class Buzo{
	var property estaEnEscena = false
	var position 
	
	method image() { return "buzo.png" }
	method position() { return position }
	method puntos() = 5 
}