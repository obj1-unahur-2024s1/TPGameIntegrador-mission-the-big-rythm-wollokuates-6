import wollok.game.*
import personaje.*

class Animacion {
	const nombreEntidad
	var cantidadFrames
	var frame = 1
	var property direccion
	const idAnimacion
	
	method siguienteFrame() {
		if (frame < cantidadFrames) frame += 1 else frame = 1
	}
	
	method image() = "sprites/" + nombreEntidad + direccion + frame.toString() + ".png"
	
	method initialize() {
		game.onTick(300, "animacion" + idAnimacion , {self.siguienteFrame()})
	}
	
	method removeTick() {
		game.removeTickEvent("animacion" + idAnimacion)
	}
}