import wollok.game.*
import personaje.*

class Animacion {
	const nombreEntidad
	var cantidadFrames
	var frame = 1
	var property direccion
	const idAnimacion
	
	method frame() = frame
	
	method siguienteFrame() {
		if (frame < cantidadFrames) frame += 1 else frame = 1
	}
	
	method image() = "sprites/" + nombreEntidad + direccion + frame.toString() + ".png"
	
	method inicializar() {
		game.onTick(300, "animacion" + idAnimacion , {self.siguienteFrame()})
	}
	
	method removeTick() {
		game.removeTickEvent("animacion" + idAnimacion)
	}
}

class AnimacionTentaculo inherits Animacion{
	override method image() = "sprites/" + nombreEntidad + frame.toString() + ".png"
	override method inicializar() {
		game.onTick(100, "animacion" + idAnimacion , {self.siguienteFrame()})
	}
}