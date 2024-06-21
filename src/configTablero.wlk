import wollok.game.*
import enemigos.*


object configuracionTablero {
	method configurar(){
		game.width(100)
		game.height(60)
		game.cellSize(10)
		//game.addVisualCharacter(player)
		var tiburoncin = new Tiburon(position = game.at(30,2), image = "bichoPrueba.png")
		var tiburoncin2 = new Tiburon(position = game.at(game.width() + 10,2), image = "bichoPrueba.png")
		game.addVisual(tiburoncin2)
		game.addVisual(tiburoncin)
		game.onTick(5000, "ataqueRemora", { => tiburoncin.lanzarRemora()})
		game.onCollideDo(tiburoncin2, { element => element.morir()})
		
	}
	
		
	
	
	
}
