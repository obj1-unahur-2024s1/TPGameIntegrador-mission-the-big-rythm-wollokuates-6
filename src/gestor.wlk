import wollok.game.*


object gestorId {
	method nuevoId(){
		return 1.randomUpTo(10000).truncate(0) // el truncate es para "cortar" en una cierta cantidad de decimales, acá lo q hace es q no haya decimales. "0"
		//Crea un nuevo ID con randomizador.
	}
}
