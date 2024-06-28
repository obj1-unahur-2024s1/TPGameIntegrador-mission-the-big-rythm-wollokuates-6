import wollok.game.*
import proyectil.*
import gameManager.*
import enemigos.*
import sounds.*


class Personaje {
	
	const origen = game.at(50, 50)
	const topeAncho = 96
	const topeAlto = 50
	const velocidad = 2
	const tickDeDisparo = 2500
	const tickDeOxigeno = 2000
	const oxigenoPorTick = 5
	
	var image = "sprites/submarinoD.png"
	var vidas = 3
	var oxigeno = 100
	var position = origen
	var direccionDisparo = 1
	var puedeDisparar = true
	
	method image() { return image }
	method position() { return position }
	method position(x,y) { position = game.at(x,y) }
	method habilitarDisparo() { puedeDisparar = true }
	
	method controladorDeMovimiento() {
		keyboard.a().onPressDo { self.moverIzquierda() }
		keyboard.d().onPressDo { self.moverDerecha() }
		keyboard.w().onPressDo { self.moverArriba() }
		keyboard.s().onPressDo { self.moverAbajo() }
		keyboard.space().onPressDo { self.disparar() }
	}
	
	method moverIzquierda() {
		const pos = utilidades.clamp(position.x() - velocidad, topeAncho, true)
		self.position(pos, position.y())
		direccionDisparo = -1
		image = "sprites/submarinoL.png"
	}
	
	method moverDerecha() {
		const pos = utilidades.clamp(position.x() + velocidad, topeAncho, true)
		self.position(pos, position.y())
		direccionDisparo = 1
		image = "sprites/submarinoD.png"
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
			fxPlayer.playShoot()
			puedeDisparar = false
		}
	}
	
	method controladorDeOxigeno(valor){
<<<<<<< HEAD
		if (position.y() < topeAlto){
			oxigeno = (oxigeno - valor).max(0)	
		} else {
			oxigeno = (oxigeno + valor).min(100) 
			fxPlayer.playOxigen()
		}
		
=======
		oxigeno = if(position.y() < topeAlto) (oxigeno - valor).max(0) else (oxigeno + valor + 5).min(100)
>>>>>>> f0ede159aefc0b33eed1e65d9b9dbe280a061d52
		gameManager.updateOxygen(oxigeno)
		if(oxigeno == 0) self.perderVida()
		if(oxigeno <= 20) fxPlayer.playBip()
	}
	
	method chocarCon(objeto) { 
        if(objeto.esEnemigo()) self.perderVida()
        else objeto.salvado() 
    }

	
	method perderVida() { 
		vidas = (vidas - 1).max(0)
		gameManager.updateLife(vidas)
		fxPlayer.playPlayerDie()
		if(vidas == 0) self.morir() else self.reset()
	}
	
	method reset(){
		position = origen
		oxigeno = 100
		gameManager.updateOxygen(oxigeno)
	}
	
	method recoger(puntaje) {gameManager.aumentarPuntaje(puntaje) } // quitar metodo
	
	method morir() {gameManager.gameOver()}
	
	method inicializar() {
		game.addVisual(self)
		game.onCollideDo(self, { algo => self.chocarCon(algo) })
		self.controladorDeMovimiento()
		gameManager.updateLife(vidas)
		game.onTick(tickDeOxigeno, "Oxigeno", { self.controladorDeOxigeno(oxigenoPorTick) })
		game.onTick(tickDeDisparo, "Disparo", { self.habilitarDisparo() })
	}
	
}

object utilidades {
	
	method clamp(valor, tope, normal) { return if(normal) (valor.min(tope)).max(0) else valor.max(tope) }
	
}

const personaje = new Personaje()
