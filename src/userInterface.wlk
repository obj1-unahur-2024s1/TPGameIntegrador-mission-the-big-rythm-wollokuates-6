import wollok.game.*

class UserInterface {
	var gameStarted = false
	var diffMenu = false
	
	method changeBackground(newImage) {
		game.boardGround(newImage)
	}
	
	method startUI() {
		self.changeBackground("UI/Backgrounds/mainBackground.png")
		self.showHideMainScreen()
		
		keyboard.enter().onPressDo { if(!gameStarted && !diffMenu) self.startDifficultySelector() }
	}
	
	method startDifficultySelector() {
		diffMenu = true
		self.showHideMainScreen()
		self.showHideSelectDifficulty()
		
		keyboard.num1().onPressDo { if(!gameStarted) self.startGame() }
		keyboard.num2().onPressDo { if(!gameStarted) self.startGame() }
	}
	
	method startGame() {
		gameStarted = true
		self.showHideSelectDifficulty()
		self.showHideLifeCounter()
		self.showHideScoreCounter()
		self.showHideOxygenCounter()
	}
	
	method updateScore(newScore) {
		const newScoreString = newScore.toString().reverse() + "000"
		unitNumberScore.number(newScoreString.charAt(0))
		dozensNumberScore.number(newScoreString.charAt(1))
		hundredNumberScore.number(newScoreString.charAt(2))
		thousandNumberScore.number(newScoreString.charAt(3))
	}
	
	method updateOxygen(newValue) {
		const newValueString = newValue.toString().reverse() + "00"
		unitNumberScore.number(newValueString.charAt(0))
		dozensNumberScore.number(newValueString.charAt(1))
		hundredNumberScore.number(newValueString.charAt(2))
	}
	
	method updateLifes(newValue) { 
		unitNumberLife.number(newValue.toString())
	}
	
	method showHideMainScreen() {
		self.toggleVisibilityAll([pressEnterLabel, gameTitle])
	}
	
	method showHideLifeCounter() {
		self.toggleVisibilityAll([lifeLabel, unitNumberLife])
	}
	
	method showHideScoreCounter() {
		self.toggleVisibilityAll([scoreLabel, thousandNumberScore, hundredNumberScore, dozensNumberScore, unitNumberScore])
	}
	
	method showHideOxygenCounter() {
		self.toggleVisibilityAll([oxygenLabel, hundredNumberOxy, dozensNumberOxy, unitNumberOxy])
	}
	
	method showHideSelectDifficulty() {
		self.toggleVisibilityAll([selectLabel, pressNumLabel, easyLabel, hardLabel])
	}
	
	method toggleVisibilityAll(toggleList){
		toggleList.forEach({x => x.toggleVisibility()})
	}
}

class ToggleVisibility {
	method toggleVisibility() {
		if(game.hasVisual(self)) {
			game.removeVisual(self)
		} else {
			game.addVisual(self)
		}
	}
	
	method show() {
		game.addVisual(self)
	}
	
	method hide() {
		game.removeVisual(self)
	}
}

class TextImage inherits ToggleVisibility {
	var property position = game.center()
	var property image
}

class PointNumber inherits ToggleVisibility {
	var property number = 0
	const position
	method image() = "UI/Numbers/num_"+ self.number().toString() + ".png"
	method position() = position
}

//--Labels--
const pressEnterLabel = new TextImage(image = "UI/Text/press_enter.png", position = game.center().down(10).left(20))
const gameTitle = new TextImage(image = "UI/Text/game_title.png", position = game.center().left(30))

//Life Label
const lifeLabel = new TextImage(image = "UI/Text/lifes.png", position = game.center().up(27).right(40))
const unitNumberLife = new PointNumber(position = game.center().up(25).right(42))

//Score Label
const scoreLabel = new TextImage(image = "UI/Text/score.png", position = game.center().up(27).left(3))
const thousandNumberScore = new PointNumber(position = game.center().up(25).left(3))
const hundredNumberScore = new PointNumber(position = game.center().up(25).left(1))
const dozensNumberScore = new PointNumber(position = game.center().up(25).right(1))
const unitNumberScore = new PointNumber(position = game.center().up(25).right(3))

//Oxygen Label
const oxygenLabel = new TextImage(image = "UI/Text/oxygen.png", position = game.center().down(28).left(48))
const hundredNumberOxy = new PointNumber(position = game.center().down(28).left(38))
const dozensNumberOxy = new PointNumber(position = game.center().down(28).left(36))
const unitNumberOxy = new PointNumber(position = game.center().down(28).left(34))

//Select Difficulty
const selectLabel = new TextImage(image = "UI/Text/select_difficulty.png", position = game.center().up(10).left(15))
const pressNumLabel = new TextImage(image = "UI/Text/press_number.png", position = game.center().up(8).left(15))
const easyLabel = new TextImage(image = "UI/Text/easy.png", position = game.center().up(2).left(6))
const hardLabel = new TextImage(image = "UI/Text/hard.png", position = game.center().down(2).left(6))


//Create the UI
const uiController = new UserInterface()
