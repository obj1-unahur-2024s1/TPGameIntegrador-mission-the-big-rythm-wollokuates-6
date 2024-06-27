import wollok.game.*

object utilidadUI {
	
	const numbersDict = new Dictionary()
	
	method initialize() {
		numbersDict.put("0", 0)
		numbersDict.put("1", 1)
		numbersDict.put("2", 2)
		numbersDict.put("3", 3)
		numbersDict.put("4", 4)
		numbersDict.put("5", 5)
		numbersDict.put("6", 6)
		numbersDict.put("7", 7)
		numbersDict.put("8", 8)
		numbersDict.put("9", 9)
	}
	
	method stringToInt(stringNumbers) {
		
		const integers = []
		const numbers = stringNumbers.split("")
		const index = (0..numbers.size() - 1)
		index.forEach({i => integers.add(self.charToInt(numbers.get(i)))})
		
		return self.finalNumber(integers)
	}
	
	method charToInt(charNumber) {
		return numbersDict.get(charNumber)
	}
	
	method finalNumber(integersList) {
		var number = 0
		const list = integersList
		integersList.forEach({ 
			int => 
			number += self.mathOperation(list.first(), list.size())
			list.remove(int)
		})
		return number
	}
	
	method mathOperation(intNumber, listLength) {
		var number = intNumber
		(listLength - 1).times({ i => number = number * 10 })
		
		return number
	}
	
	method numberStringToList(string) {
		const newList = []
		self.stringToInt(string).times({i => newList.add(i)})
		return newList
	}
}

class UserInterface {
	var gameStarted = false
	var diffMenu = false
	
	//--Labels--
	const pressEnterLabel = new TextImage(image = "UI/Text/press_enter.png", position = game.center().down(10).left(20))
	const gameTitle = new TextImage(image = "UI/Text/game_title.png", position = game.center().left(30))

	//Life Label
	const lifeLabel = new TextImage(image = "UI/Text/lifes.png", position = game.center().up(27).right(40))
	const unitNumberLife = new PointNumber(position = game.center().up(25).right(42))

	//Score Label
	const scoreLabel = new TextImage(image = "UI/Text/score.png", position = game.center().up(27).left(3))
	const unitNumberScore = new PointNumber(position = game.center().up(25).right(3))
	const dozensNumberScore = new PointNumber(position = game.center().up(25).right(1))
	const hundredNumberScore = new PointNumber(position = game.center().up(25).left(1))
	const thousandNumberScore = new PointNumber(position = game.center().up(25).left(3))
	const scoreLabels = [unitNumberScore, dozensNumberScore, hundredNumberScore, thousandNumberScore]
	
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
	
	//Controls Instructions
	const movementLabel = new TextImage(image = "UI/Controls/wasd-label.png", position = game.center().down(22).left(50))
	const movementControls = new TextImage(image = "UI/Controls/wasd.png", position = game.center().down(29).left(43))
	const shootLabel = new TextImage(image = "UI/Controls/space-label.png", position = game.center().down(22).left(10))
	const shootControls = new TextImage(image = "UI/Controls/space.png", position = game.center().down(28).left(3))
	const volumeLabel = new TextImage(image = "UI/Controls/volume-label.png", position = game.center().down(22).right(20))
	const volumeUp = new TextImage(image = "UI/Controls/letter-p.png", position = game.center().down(28).right(30))
	const volumeDown = new TextImage(image = "UI/Controls/letter-l.png", position = game.center().down(28).right(36))
	
	//--Methods--
	method changeBackground(newImage) {
		game.boardGround(newImage)
	}
	
	method startUI() {
		self.changeBackground("UI/Backgrounds/mainBackground.png")
		self.showHideMainScreen()
	}
	
	method startDifficultySelector() {
		diffMenu = true
		self.showHideMainScreen()
		self.showHideSelectDifficulty()
	}
	
	method startGame() {
		gameStarted = true
		self.showHideSelectDifficulty()
		self.showHideLifeCounter()
		self.showHideScoreCounter()
		self.showHideOxygenCounter()
	}
	
	method updateScore(newScore) {
		var newScoreString = newScore.toString()
		const scoreLenght = newScoreString.size()
		newScoreString = newScoreString.reverse() + if(scoreLenght < 5) "000" else ""
		
		if(scoreLenght > scoreLabels.size()) {
			(0..scoreLenght - scoreLabels.size() - 1).forEach({x => 
				scoreLabels.add(new PointNumber(position = game.center().up(25).left(3 + 2 * (scoreLabels.size() + 1 - 4))))
				scoreLabels.last().toggleVisibility()
			})
		}
		
		var i = 0
		scoreLabels.forEach({x => x.number(newScoreString.charAt(i)) i = i + 1})
	}
	
	method updateOxygen(newValue) {
		const newValueString = newValue.toString().reverse() + "00"
		unitNumberOxy.number(newValueString.charAt(0))
		dozensNumberOxy.number(newValueString.charAt(1))
		hundredNumberOxy.number(newValueString.charAt(2))
	}
	
	method updateLifes(newValue) { 
		unitNumberLife.number(newValue.toString())
	}
	
	method showHideMainScreen() {
		self.toggleVisibilityAll([pressEnterLabel, gameTitle, movementControls, shootControls, volumeUp, volumeDown, movementLabel, shootLabel, volumeLabel])
	}
	
	method showHideLifeCounter() {
		self.toggleVisibilityAll([lifeLabel, unitNumberLife])
	}
	
	method showHideScoreCounter() {
		scoreLabel.toggleVisibility()
		self.toggleVisibilityAll(scoreLabels)
	}
	
	method showHideOxygenCounter() {
		self.toggleVisibilityAll([oxygenLabel, hundredNumberOxy, dozensNumberOxy, unitNumberOxy])
	}
	
	method showHideSelectDifficulty() {
		self.toggleVisibilityAll([selectLabel, pressNumLabel, easyLabel, hardLabel])
	}
	
	method toggleVisibilityAll(toggleList) {
		toggleList.forEach({x => x.toggleVisibility()})
	}
	
	method gameStarted() = gameStarted
	method diffMenu() = diffMenu
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

//Create the UI
const uiController = new UserInterface()
