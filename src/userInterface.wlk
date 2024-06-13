import wollok.game.*
import sounds.*

class UserInterface {
	var gameStarted = false
	
	method changeBackground(newImage) {
		game.boardGround(newImage)
	}
	
	method initialize() {
		game.width(100)
		game.height(60)
		game.cellSize(10)
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

const startGame = new Label(text = "Press Enter to Start the game")

const lifeCounter = new LabelCounter(text = 3, position = game.center().left(150))

const scoreCounter = new LabelCounter(text = 0, position = game.center().right(150))

const uiController = new UserInterface()