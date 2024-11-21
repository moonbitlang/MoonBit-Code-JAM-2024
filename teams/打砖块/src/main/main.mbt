let width = 50

let height = 5

let ball_size = 5

let screen_size = 160

// 拍子
struct PaddleModel {
  mut x : Int
  y : Int
  width : Int
  height : Int
}

pub fn PaddleModel::new() -> PaddleModel {
  {
    x: screen_size / 2 - width / 2,
    y: screen_size - 4,
    width: width,
    height: height,
  }
}
let paddle : PaddleModel = PaddleModel::new()

// 小球
struct BallModel {
 mut x : Int
 mut y : Int
 mut dx : Int
 mut dy : Int
}
pub fn BallModel::new() -> BallModel {
  {
    // x: screen_size / 2, 
    x: 10,
    y: screen_size - 110, 
    dx: 1, 
    dy: 1
  }
}

let ball : BallModel = BallModel::new()
// let rng : @random.Rand = @random.new()

// 砖块
struct BrickModel {
  x : Int
  y : Int
  width : Int
  height : Int
}

// 当前关卡-类型
struct GameModel {
  bricks : Array[BrickModel] // 游戏 砖块数据
  mut score : Int // 游戏分数
  mut status : String // 游戏状态
}

// 当前关卡
let gameModel : GameModel = { 
    bricks: [],
    score: 0,
    status: "waiting"
  }

pub fn init_bricks() -> Unit {
    let brickWidth = 14;
    let brickHeight = 6;
    let brickCount = 10;
    let brickRow = 5;
    for row = 0; row < brickRow; row = row + 1  {
      for col = 0; col < brickCount; col = col + 1 {
          gameModel.bricks.push({
              x: col * (brickWidth + 2) + 1,
              y: row * (brickHeight + 2) + 1,
              width: brickWidth,
              height: brickHeight
          });
      }
    }
}

pub fn draw_bricks() -> Unit {
  @wasm4.set_draw_colors(2)
  for brick in gameModel.bricks {
    @wasm4.rect(brick.x, brick.y, brick.width, brick.height)
  }
}

pub fn draw_ball() -> Unit {
  @wasm4.set_draw_colors(3)
  @wasm4.oval(ball.x, ball.y, ball_size, ball_size)
}

pub fn draw_paddle() -> Unit {
  @wasm4.set_draw_colors(2)
  @wasm4.set_draw_colors(0x0U, index=2)
  @wasm4.rect(paddle.x, paddle.y, paddle.width, paddle.height)
}

// 更新游戏状态
pub fn updatePaddle(x : Int) -> Unit {
  paddle.x = paddle.x + x
}
pub fn updateBall() -> Unit {
  ball.x = ball.dx + ball.x
  ball.y = ball.dy + ball.y
}

// 渲染游戏画面
pub fn draw() -> Unit {
  draw_ball()
  draw_bricks()
  draw_paddle()
}

// 游戏主循环
pub fn game_loop() -> Unit {
  // 1. 更新游戏状态
  updateBall()
  check_collision()
  // 2. 渲染游戏画面
  draw()
  
}
pub fn end_game(text: String, x: Int, y : Int) -> Unit {
  gameModel.status = "complete"
  @wasm4.text(text, x, y)
  ball.dx = 0;
  ball.dy = 0;
  tone()
}
pub fn tone() -> Unit {
  @wasm4.tone(
    (2000, 0),
    @wasm4.ADSR::new(5),
    @wasm4.ADSRVolume::new(100),
    @wasm4.ToneFlag::new(),
  )
}

// 检查碰撞
pub fn check_collision() -> Unit {
  // 检查球是否撞到砖块
  for i=0; i < gameModel.bricks.length(); i = i + 1 {
      let brick = gameModel.bricks[i]
      if ball.x + ball_size > brick.x &&
         ball.x - ball_size < brick.x + brick.width &&
         ball.y + ball_size > brick.y &&
         ball.y - ball_size < brick.y + brick.height {
            ball.dy = -ball.dy;
           let _ = gameModel.bricks.remove(i);
            gameModel.score = gameModel.score + 1;
        }
    }
  


  if gameModel.bricks.length() == 0 {
      end_game("Game Complete!", 20, 80);
  }
  // 检查球是否撞到墙壁
  if ball.x + ball_size > screen_size || ball.x - ball_size < 0 {
      ball.dx = -ball.dx;
  }
  if ball.y - ball_size < 0 {
      ball.dy = -ball.dy;
      // tone()
  }

  // 检查球是否撞到拍子
  if 
      ball.x + ball_size > paddle.x &&
      ball.x - ball_size < paddle.x + paddle.width &&
      ball.y + ball_size > paddle.y &&
      ball.y - ball_size < paddle.y + paddle.height {
        ball.dy = -ball.dy;
        // tone()
  }

  // 检查球是否掉出屏幕
  if ball.y + ball_size > screen_size {
      end_game("Game Over!", 40, 80);
      
  }
}


pub fn start() -> Unit {
  @wasm4.set_palette(1, @wasm4.rgb(0xF9F9F9)) 
  @wasm4.set_palette(2, @wasm4.rgb(0xFF0000)) 
  @wasm4.set_palette(3, @wasm4.rgb(0x00FF00))
  @wasm4.set_palette(4, @wasm4.rgb(0x0000FF)) 
  init_bricks()
  // draw()
}

pub fn update() -> Unit {
  if @wasm4.get_gamepad().button_right && paddle.x + width < screen_size {
    updatePaddle(1)
  } else if @wasm4.get_gamepad().button_left && paddle.x > 0 {
    updatePaddle(-1)  
  } 
  // else if @wasm4.get_gamepad().button_up || @wasm4.get_gamepad().button_down {
  //   updateBall()
    gameModel.status = "running"
  // } else {
    if gameModel.status == "running" {
      game_loop()
    }
  // }

   @wasm4.set_draw_colors(4)
   @wasm4.text("Score: "+ gameModel.score.to_string(), 40, 60)
}
