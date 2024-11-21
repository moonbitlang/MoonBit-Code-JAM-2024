pub fn start() -> Unit {
  game.coin += 10
}

let game : Game = Game::new()

pub fn update() -> Unit {
  if game.gameOverFlag == false {
    game.time += 1
  }

  runEvents()
  animeProgressBar(game)
 
  if game.coin<=0 {
    gameOver()
  }

  draw(game)

  game.input()
}
