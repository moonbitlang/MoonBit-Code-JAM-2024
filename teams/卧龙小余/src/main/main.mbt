// race-car game 

struct CarModel {    //car 
  mut x : Int
  mut y : Int
  width : Int
  height : Int
  mut isDown:Bool
}

struct ObstacleItem {    //障碍
   x : Int
  mut y : Int
  width : Int
  height : Int
  obstacleSpawnInterval:Int   //生成速度 时间间隔 // Time interval in milliseconds  
}

struct GameStateModel {  // 游戏状态
  mut score : Int
  mut gameTitle : String
  mut isGameOver : Bool
}

let car : CarModel = { 
  x: 80,
  y: 140,
  width: 20,
  height: 40,
  isDown:false
}

let obstacle : Array[ObstacleItem] = [{ x: 160, y: 60, width: 20, height: 40,obstacleSpawnInterval:2000 }] // 管道初始化

let obstacleSpeed = 1 

let gameState : GameStateModel = {   
  score: 0,
  gameTitle: "start",
  isGameOver: false,
}

let random : @random.Rand = @random.new()
let screen_size = 160  

//绘制car
pub fn drawcar() -> Unit {
  @wasm4.set_draw_colors(2)
  @wasm4.rect(car.x, car.y, 20, 20)
}

//控制car
pub fn controlcar() -> Unit {
  if @wasm4.get_gamepad(index=1).button_right && car.x < 160 {
    car.x += 1
  } else if @wasm4.get_gamepad(index=1).button_down && car.y < 160 {
  } else if @wasm4.get_gamepad(index=1).button_left && car.x >= 0 {
    car.x -= 2
  } else if @wasm4.get_gamepad(index=1).button_up && car.y >= 0 {
  }
  drawcar()
}

// 更新car
pub fn updatecar() -> Unit {
  if car.y + car.height > screen_size {
    gameState.gameTitle = "gameOver"
    car.y=140
  } else if car.y < 0 {
    car.y=140
  }
}

//绘制障碍物
pub fn drawObstacle() -> Unit {
  for item in obstacle {
    @wasm4.set_draw_colors(3)
    @wasm4.rect(item.x, item.y, item.width, item.height)
  }
}

// 循环生成障碍物
pub fn addPipe() -> Unit {
  let x = random.int(limit=10) * (screen_size - 20)/10;
  let y = -20;
  obstacle.push({ x: x, y: y, width: 20, height:40,obstacleSpawnInterval:2000 })
}

// 障碍物坐标更新
pub fn updateobstacle() -> Unit {
  for item in obstacle {
    item.y += obstacleSpeed
    if item.y  > screen_size {
      gameState.score += 1
      let a = obstacle.pop()
      addPipe()
    }
  }
}

// 检查碰撞
pub fn checkCollisions() -> Unit {
  for item in obstacle {
    if car.x < item.x + item.width && car.x + car.width > item.x {
      if car.y < item.y+item.height && car.y+car.height> item.y {
        gameOver()
      }
    }
  }
}

pub fn gameOver()->Unit{
        gameState.gameTitle = "gameover"
        gameState.isGameOver = true
        @wasm4.set_draw_colors(3)
        @wasm4.text("Game Over!", 40, 80)
}

pub fn drawScore() -> Unit {
  @wasm4.set_draw_colors(3)
  @wasm4.text("score: "+gameState.score.to_string(), 50, 0)
}



pub fn start() -> Unit {
  @wasm4.set_palette(1, @wasm4.rgb(0xF7F7F7)) //背景    白色
  @wasm4.set_palette(2, @wasm4.rgb(0xffc000)) //汽车    黄色
  @wasm4.set_palette(3, @wasm4.rgb(0x19A15F)) //障碍物  黑色
  @wasm4.set_palette(4, @wasm4.rgb(0xFFFFFF)) //背景    白色
}

pub fn update() -> Unit {
  if(gameState.isGameOver==false){
        updatecar()
        controlcar()
        drawObstacle()
        drawScore()
        updateobstacle()
        checkCollisions()
  }else{
        drawScore()
        gameOver()
  }
}