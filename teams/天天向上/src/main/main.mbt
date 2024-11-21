struct DragonModel { //dragon 
  mut x : Int
  mut y : Int
  width : Int
  height : Int
  mut dragonVelocity : Int
  mut isDown : Bool // 跳起后是否下降
}

struct PlantItem { //障碍
  mut x : Int
  top : Int
  bottom : Int
  width : Int
}

struct GameModel { // 游戏状态
  mut score : Int
  mut gameTitle : String
  mut isGameOver : Bool
}

let gravity = 1 //下降系数

let dragon : DragonModel = { //dragon初始化
  x: 10,
  y: 144,
  width: 16,
  height: 16,
  dragonVelocity: 1 / 2,
  isDown: false,
}

let plants : Array[PlantItem] = [{ x: 160, top: 60, bottom: 16, width: 15 }] // 障碍

let plantsSpeed = 1 // 障碍间隔速度

let gameState : GameModel = { // 游戏状态初始化
  score: 0,
  gameTitle: "start",
  isGameOver: false,
}

let random : @random.Rand = @random.new()

let screen_size = 160

// 绘制dragon
pub fn drawdragon() -> Unit {
  @wasm4.set_draw_colors(2)
  let blit_flag : @wasm4.BlitFlag = {
    one_bit_per_pixel: true,
    flip_x: false,
    flip_y: false,
    rotate: false,
  }
  @wasm4.blit( //恐龙
    @wasm4.sprite(
      b"\xff\x83\xff\x21\xff\x01\x7f\x01\x7e\x1f\x3c\x03\x18\x1f\x00\x03\x80\x03\xc0\x0b\xe0\x0f\xf8\x0f\xf8\x1f\xf9\xbf\xf9\x9f\xf8\xff",
    ),
    dragon.x,
    dragon.y,
    16,
    16,
    blit_flag,
  )
}

// dragon 实时更新
pub fn updatedragon() -> Unit {
  if dragon.isDown {
    dragon.y += gravity
    if dragon.y + dragon.height > screen_size {
      gameState.gameTitle = "gameOver"
      dragon.y = 144
      dragon.isDown = false
    } else if dragon.y < 0 {
      dragon.y = 144
      dragon.isDown = false
      dragon.dragonVelocity = 0
    }
  }
}

//控制dragon
pub fn controldragon() -> Unit {
  if @wasm4.get_gamepad(index=1).button_right && dragon.x < 160 {
    dragon.x += 1
  } else if @wasm4.get_gamepad(index=1).button_down && dragon.y < 160 {
    // dragon.y += 3
  } else if @wasm4.get_gamepad(index=1).button_left && dragon.x >= 0 {
    dragon.x -= 1
  } else if @wasm4.get_gamepad(index=1).button_up && dragon.y >= 0 {
    dragon.y -= 8
    dragon.isDown = true
  }
  drawdragon()
}

//绘制植物 
pub fn drawplants() -> Unit {
  for plant in plants {
    @wasm4.set_draw_colors(2)
    let blit_flag : @wasm4.BlitFlag = {
      one_bit_per_pixel: true,
      flip_x: false,
      flip_y: false,
      rotate: false,
    }
    @wasm4.blit(
      @wasm4.sprite(
        b"\xfe\x3f\xfe\x3f\xe6\x3f\xe6\x3f\xe6\x3f\xe6\x3f\xe0\x3f\xe0\x23\xe0\x23\xfe\x23\xfe\x03\xfe\x03\xfe\x03\xfe\x3f\xfe\x3f\xfe\x3f",
      ),
      plant.x,
      screen_size - 16,
      16,
      16,
      blit_flag,
    )
  }
}

// 循环生成植物
pub fn addplant() -> Unit {
  plants.push({ x: 160, top: 0, bottom: 16, width: 16 })
}

// 植物坐标更新
pub fn updateplants() -> Unit {
  for plant in plants {
    plant.x -= plantsSpeed
    if plant.x + plant.width < 0 {
      gameState.score += 1
      let a = plants.pop()
      addplant()
    }
  }
}

// 检查碰撞
pub fn checkCollisions() -> Unit {
  for plant in plants {
    if dragon.x < plant.x + plant.width && dragon.x + dragon.width > plant.x {
      if dragon.y + dragon.width > screen_size - plant.bottom {
        gameOver()
      }
    }
  }
}

pub fn gameOver() -> Unit {
  gameState.gameTitle = "gameover"
  gameState.isGameOver = true
  @wasm4.set_draw_colors(3)
  @wasm4.text("Game Over!", 40, 80)
}

pub fn drawScore() -> Unit {
  @wasm4.set_draw_colors(3)
  @wasm4.text("score: " + gameState.score.to_string(), 50, 0)
}

pub fn drawUnderline() -> Unit {
  @wasm4.set_draw_colors(3)
  @wasm4.line(0, 159, 160, 159)
}

pub fn start() -> Unit {
  @wasm4.set_palette(1, @wasm4.rgb(0xF7F7F7)) //背景  天空 白色
  @wasm4.set_palette(2, @wasm4.rgb(0x535353)) //恐龙、障碍物  灰色
  @wasm4.set_palette(3, @wasm4.rgb(0x333333)) //地平线  黑色
  @wasm4.set_palette(4, @wasm4.rgb(0xFFFFFF)) //背景  天空 白色
}

pub fn update() -> Unit {
  if gameState.isGameOver == false {
    drawUnderline()
    updatedragon()
    controldragon()
    drawplants()
    drawScore()
    updateplants()
    checkCollisions()
  } else {
    drawScore()
    gameOver()
  }
}
