import wollok.game.*

class UserInterface {
	
	method changeBackground(newImage) {
		game.boardGround(newImage)
	}
	
	method initialize() {
		game.width(1920)
		game.height(1080)
		game.cellSize(1)
		self.changeBackground("UI/wip_background.jpg")
		game.addVisual(playBtn)
		game.say(playBtn, "Play") 
	}
}

class Button {
	var property position
	var property image
}

class Label {
	
}

object playBtn inherits Button(position = game.center(), image = "UI/asset/Buttons/Rect-Medium/PlayIcon/Default.png") {
	
}

object uiController inherits UserInterface {
	
}