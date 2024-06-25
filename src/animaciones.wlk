import wollok.game.*
import personaje.*

class Animacion {
	const nombreEntidad
	var cantidadFrames
	var frame = 1
	var property direccion
	
	method siguienteFrame() {
		if (frame <= cantidadFrames) frame += 1 else frame = 1
	}
	
	method image() = "sprites/" + nombreEntidad + frame.toString() + direccion + ".png"
	
	method initialize() {
		game.onTick(200, "animacion", {self.siguienteFrame()})
	}
}
