import wollok.game.*

class UserInterface {
	var gameStarted = false
	
	method changeBackground(newImage) {
		game.boardGround(newImage)
	}
	
	method startUI() {
		game.width(100)
		game.height(60)
		game.cellSize(16)
		self.changeBackground("UI/wip_background.jpg")
		game.addVisual(pressEnterLabel)
		
		keyboard.enter().onPressDo { if(!gameStarted) self.showDifficultySelector() }
	}
	
	method showDifficultySelector() {
		game.removeVisual(pressEnterLabel)
		self.startGame()
	}
	
	method startGame() {
		gameStarted = true
		
		game.addVisual(lifeCounter)
		
		game.addVisual(thousandNumber)
		game.addVisual(hundredNumber)
		game.addVisual(dozensNumber)
		game.addVisual(unitNumber)
	}
	
	method updateScore(newScore) {
		const newScoreString = newScore.toString().reverse() + "000"
		unitNumber.number(newScoreString.charAt(0))
		dozensNumber.number(newScoreString.charAt(1))
		hundredNumber.number(newScoreString.charAt(2))
		thousandNumber.number(newScoreString.charAt(3))
	}
}

object colorPick {
	method white() = "FFFFFF"
}

class GameScreenText {
	var property position = game.center()
	var text
	var property textColor = colorPick.white()
	
	method text() = text.toString()
	
	method updateText(newText) {
		text = newText
	}
}

const pressEnterLabel = new GameScreenText(text = "Press Enter to Start the game")
const lifeCounter = new GameScreenText(text = 3, position = game.center().left(10))
const uiController = new UserInterface()

class PointNumber {
	var property number = 0
	const position
	method image() = "UI/Numbers/num_"+ self.number().toString() + ".png"
	method position() = position
}

const thousandNumber = new PointNumber(position = game.at(20, 30))
const hundredNumber = new PointNumber(position = game.at(30, 30))
const dozensNumber = new PointNumber(position = game.at(40, 30))
const unitNumber = new PointNumber(position = game.at(50, 30))

