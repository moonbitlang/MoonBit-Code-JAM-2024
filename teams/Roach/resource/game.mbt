pub struct Block {
  mut width : Int
  mut height : Int
  mut x : Int
  mut y : Int
  mut color : Color
  mut event_block : String
  mut sprite_block : MoveSprite
}

pub fn Block::new() -> Block {
  { width: 30, 
  height: 70, 
  x: 0, 
  y: 20, 
  color: Color::new(), 
  event_block : "None",
  sprite_block : MoveSprite::new()
  }
}

pub struct Ball {
  mut width : Int
  mut height : Int
  mut x : Int
  mut y : Int
  mut color : Color
}

pub fn Ball::new() -> Ball {
  { width: 25, height: 25, x: 19, y: 98, color: Color::new() }
}

pub struct Game {
  mut block : Array[Block]
  mut ball : Ball
  mut frame_count : Int
  mut prev_gamepad : @wasm4.GamePad
  mut coin : Int
  mut time : UInt
  mut delay : UInt
  mut counter : UInt
  mut counterFlag : Bool
  mut pbar :Block
  mut gameOverFlag:Bool
}

pub fn Game::new() -> Game {
  {
    block: [Block::new(), Block::new(), Block::new()],
    ball: Ball::new(),
    frame_count: 0,
    prev_gamepad: @wasm4.GamePad::default(),
    coin: 0,
    time: 0,
    delay: 0,
    counter: 65,
    counterFlag: false,
    pbar: Block::{width: 0, height: 10, x: 20, y: 138, color: Color::new(), event_block : "None", sprite_block : MoveSprite::new()} ,
    gameOverFlag: false
  }
}

pub fn input(self : Game) -> Unit {
  let gamepad = @wasm4.get_gamepad()
  if game.counterFlag {
    game.counter -= 1
    animeBlock(self)
    animeBall(self)
    animeSprite(self)
  }
  if game.counter == 0 {
    for i in [0, 1, 2] {
      self.block[i].changeColor_random()
      self.block[i].event_block = identifyEvent(getEvent())
      
    @wasm4.trace("\{self.time}")

    }

    game.counter = 65
    game.counterFlag = false
    game.ball.x = 19
    if game.block[0].color.palette == game.block[1].color.palette {
      if game.block[1].color.palette == game.block[2].color.palette {
        music()
      }
    } else {
      nothing()
      prize()
    }
  }
  if gamepad != self.prev_gamepad {
    if gamepad.button_1 && game.coin > 0 && game.counterFlag == false {
      game.coin -= 1
      game.counterFlag = true
    }
  }
  self.prev_gamepad = gamepad
}

fn gameOver() -> Unit {
  @wasm4.text("GAME OVER", 44, 105)
  @wasm4.text("press R to restart", 8, 115)
  game.time += 1
  game.coin = 0
  game.gameOverFlag = true
}
