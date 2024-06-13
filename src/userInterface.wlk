import wollok.game.*
import sounds.*

class UserInterface {
	var gameStarted = false
	
	method changeBackground(newImage) {
		game.boardGround(newImage)
	}
	
	method initialize() {
		game.width(1920)
		game.height(1080)
		game.cellSize(1)
		self.changeBackground("UI/wip_background.jpg")
		game.addVisual(startGame)
		
		keyboard.enter().onPressDo { if(!gameStarted) self.startGame() }
	}
	
	method startGame() {
		gameStarted = true
		game.removeVisual(startGame)
		game.addVisual(lifeCounter)
		game.addVisual(scoreCounter)
	}
}

object colorPick {
	method white() = "FFFFFF"
}

class Label {
	var property position = game.center()
	var text
	var property textColor = colorPick.white()
	
	method text() = text.toString()
	
	method updateText(newText) {
		text = newText
	}
}

class LabelCounter inherits Label {
	method updateCounter(value) {
		self.updateText(text + value)
	}
}

object startGame inherits Label(text = "Press Enter to Start the game") {
	
}

object lifeCounter inherits LabelCounter(text = 3, position = game.center().left(150)) {
	
}

object scoreCounter inherits LabelCounter(text = 0, position = game.center().right(150)) {
	
}

object uiController inherits UserInterface {
	
}