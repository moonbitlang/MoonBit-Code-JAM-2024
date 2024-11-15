// fly bird game 
struct BirdModel {    //bird 
  mut x : Int
  mut y : Int
  width : Int
  height : Int
  mut birdVelocity : Int  //y轴向下方向速度
}

struct PipesItem {    // 管道
  mut x : Int
  top : Int
  bottom : Int
  width : Int
}

struct GameStateModel {   //游戏状态
  mut score : Int
  mut gameTitle : String
  mut isGameOver : Bool
}

struct CoinModel{  // 金币 +10分
    mut x : Int
     y : Int
    width : Int
    height : Int
    mut isGet:Bool  //是否获取到
}

let gravity = 1 //默认重力

let bird : BirdModel = { //bird初始化
  x: 10,
  y: 0,
  width: 15,
  height: 15,
  birdVelocity: 1 / 2,
}

let pipes : Array[PipesItem] = [{ x: 160, top: 60, bottom: 40, width: 15 }] // 管道初始化

let coins:Array[CoinModel]=[{x:200,y:80,width:10,height:10,isGet:false}]   //金币道具初始化

let pipesSpeed = 1 // 障碍间隔速度

let pipeGap = 60 // 上下障碍之间的空间

let gameState : GameStateModel = {    // 游戏状态初始化
  score: 0,
  gameTitle: "start",
  isGameOver: false,
}

let random : @random.Rand = @random.new()

let screen_size = 160  

//绘制bird
pub fn drawBird() -> Unit {
  @wasm4.set_draw_colors(2)
  let blit_flag : @wasm4.BlitFlag = {
    one_bit_per_pixel: true,
    flip_x: false,
    flip_y:false,
    rotate:false,
  }
  @wasm4.blit(
    @wasm4.sprite(b"\xff\xff\x7f\x87\x3f\x00\x3f\x30\x0f\x33\x03\x03\x00\x03\x80\x03\x80\x07\x80\x07\x80\x0f\xc0\x1f\xe0\x3f\x00\x3f\x80\xff\xff\xff"),
    bird.x,
    bird.y,
    16,
    16,
    blit_flag,
  )
}

//控制bird
pub fn controlBird() -> Unit {
  if @wasm4.get_gamepad(index=1).button_right && bird.x < 160 {
    bird.x += 1
  } else if @wasm4.get_gamepad(index=1).button_down && bird.y < 160 {
    bird.y += 3
  } else if @wasm4.get_gamepad(index=1).button_left && bird.x >= 0 {
    bird.x -= 1
  } else if @wasm4.get_gamepad(index=1).button_up && bird.y >= 0 {
    bird.y -= 3
  }
  drawBird()
}

// 更新bird
pub fn updateBird() -> Unit {
  bird.y += gravity
  if bird.y + bird.height > screen_size {
    gameState.gameTitle = "gameOver"
  } else if bird.y < 0 {
    bird.y = screen_size / 2
    bird.birdVelocity = 0
  }
}


//绘制障碍物
pub fn drawPipes() -> Unit {
  for pipe in pipes {
    //上方柱子
    @wasm4.set_draw_colors(3)
    @wasm4.rect(pipe.x, 0, pipe.width, pipe.top)

    // 底部柱子
    @wasm4.set_draw_colors(3)
    @wasm4.rect(pipe.x, screen_size - pipe.bottom, pipe.width, pipe.bottom)


  }
}

// 循环生成障碍物
pub fn addPipe() -> Unit {
  let gapTop = random.int(limit=10) * (screen_size - pipeGap) / 10
  let gapBottom = screen_size - gapTop - pipeGap
  pipes.push({ x: 160, top: gapTop, bottom: gapBottom, width: 15 })
}

// 障碍物坐标更新  
pub fn updatePipes() -> Unit {
  for pipe in pipes {
    if(gameState.score>=30){    // 当得分超过30时，升级难度，管道移动速度加快
        pipe.x -= pipesSpeed+1
    }else{
        pipe.x -= pipesSpeed
    }
    if pipe.x + pipe.width < 0 {
      gameState.score += 1
      let a = pipes.pop()
      addPipe()
    }
  }
}


//绘制金币 获取到金币，得分+10
pub fn drawCoin()->Unit{
   for coin in coins {
      @wasm4.set_draw_colors(2)
      @wasm4.oval(coin.x,coin.y,10,10)
   }
}

// 循环生成金币
pub fn addCoin() -> Unit {
  let gapTop = random.int(limit=10) * (screen_size - pipeGap) / 10
  coins.push({x:200,y:gapTop+30, width:10,height:10,isGet:false})
}

// 金币坐标更新
pub fn updateCoins() -> Unit {
  for index,coin in coins {
    coin.x -= pipesSpeed
    
    if(coin.isGet){
         gameState.score += 10
        let b=coins.remove(index)
    }

    if coin.x + coin.width < 0 {
      let c=coins.remove(index)
      addCoin()
    }
  }
}


// 检查碰撞
pub fn checkCollisions() -> Unit {
  for pipe in pipes {
    // Check if the bird is within the horizontal bounds of the pipe  
    if bird.x < pipe.x + pipe.width && bird.x + bird.width > pipe.x {
      // Check if the bird is within the vertical bounds of the top or bottom part of the pipe  
      if bird.y < pipe.top || bird.y + bird.width > screen_size - pipe.bottom {
           // 添加音效
           @wasm4.tone(   
            (2000, 0),
            @wasm4.ADSR::new(5),
            @wasm4.ADSRVolume::new(100),
            @wasm4.ToneFlag::new(),
          )
        gameOver()
      }
    }
  }
}

pub fn getCoin() -> Unit {
    for index,coin in coins{
      if(bird.x<coin.x+coin.width&&bird.x+bird.width>coin.x && bird.y<coin.y+30&&bird.y+bird.height>coin.y){
            coin.isGet=true
            // 获得金币，添加音效
            @wasm4.tone(   
              (2000, 0),
              @wasm4.ADSR::new(5),
              @wasm4.ADSRVolume::new(100),
              @wasm4.ToneFlag::new(),
            )
      }else{
            coin.isGet=false
      }
    }
}

pub fn gameOver()->Unit{
        gameState.gameTitle = "gameover"
        gameState.isGameOver = true
        @wasm4.set_draw_colors(4)
        @wasm4.text("Game Over!", 40, 80)
}

pub fn drawScore() -> Unit {
  @wasm4.set_draw_colors(4)
  @wasm4.text("score: "+gameState.score.to_string(), 50, 0)
}


pub fn start() -> Unit {
  @wasm4.set_palette(1, @wasm4.rgb(0xE0F8CF)) //背景   天空色  6fc5cc
  @wasm4.set_palette(2, @wasm4.rgb(0x86C06C)) // 小鸟 //黄色 E5AD20  
  @wasm4.set_palette(3, @wasm4.rgb(0x86C06C)) // 柱子  绿色
  @wasm4.set_palette(4, @wasm4.rgb(0x666666)) //默认背景色

}

// 游戏实时更新 每秒60 的刷新频次
pub fn update() -> Unit {
  if(gameState.isGameOver==false){
        updateBird()
        controlBird()
        // 绘制障碍物
        drawPipes()
        drawScore()
        updatePipes()

        //绘制金币
        drawCoin()
        updateCoins()

        // 检查碰撞
         getCoin()
        checkCollisions()
  }else{
        drawScore()
        gameOver()
  }
}

