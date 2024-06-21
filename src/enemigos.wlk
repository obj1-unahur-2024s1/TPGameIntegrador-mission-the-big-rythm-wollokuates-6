import wollok.game.*
import gestor.*


// PLAYER PARA HACER PRUEBAS

object player{
	var score = 0
	var property image = "bichoPrueba.png"
	
	var vidas = 3
	var property position = game.origin()
	
	method score() = score
	method sumarPuntos(puntos){
		score += puntos
	} 
	method morir() = vidas == 0
	method resetPosition() {
		position = game.origin()
	}
	
	

}


class Enemigo {
	var vida = 1
	var position
	var property image 
	method movimiento()
	method morir(){
		game.removeVisual(self)
	}
	method position() = position
	method destruidoPorElPlayer() {
		self.morir()
	}
}

class Tiburon inherits Enemigo{
	
	override method movimiento() {}
	override method destruidoPorElPlayer(){ // destruye al enemigo y suma puntos al player
		super()
		player.sumarPuntos(5)
	}
	method lanzarRemora() { 
		var estaALaIzq = self.position().x() < game.center().x()
		var remora = new Remora(position = self.position(), image = "bichoPrueba.png", aDondeVamo = estaALaIzq)
		game.addVisual(remora)
		game.onTick(500, "movimiento", { => remora.movimiento()})
	}
	

	
}

class Remora inherits Enemigo{
	var aDondeVamo // Determinar a qué lado va eyectada la remora
	override method movimiento() {
		if(aDondeVamo){
			position = game.at(position.x() + 1, position.y())
		} else {
			position = game.at(position.x() - 1, position.y())
		}
	}
	
	
	
}

class PezEspada inherits Enemigo{
	// TO DO
	
}

class Kraken inherits Enemigo{
	/* - method cambiarDeLado()
	 * method 
	 */
	method spawnearEnemigo()
	method dispararProyectil()
	method ataqueTentaculo()
}















