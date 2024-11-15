
let maze : Array[Array[Int]]= [
    // 第一关地图  16*16 地图
    [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
    [1, 2, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1],
    [1, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 0, 1],
    [1, 0, 1, 1, 0, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1],
    [1, 0, 0, 0, 0, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1],
    [1, 1, 1, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1],
    [1, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 1, 1, 1],
    [1, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1],
    [1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 0, 1],
    [1, 0, 1, 1, 1, 1, 0, 1, 0, 0, 1, 1, 1, 0, 0, 1],
    [1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 1, 1],
    [1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1],
    [1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1],
    [1, 0, 0, 1, 1, 1, 0, 1, 0, 1, 1, 0, 0, 1, 0, 1],
    [1, 0, 1, 1, 0, 1, 0, 1, 0, 1, 1, 1, 0, 1, 0, 1],
    [1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 3, 1],
    [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
  ]


let tile_size = 6 //瓦片尺寸

// 玩家坐标——类型
struct playerModel {
  mut x : Int
  mut y : Int
}

//游戏状态-类型
struct gameStateModel {
  mut isGameOver : Bool
}

// 当前关卡-类型
struct currentLevelModle {
  data : Array[Array[Int]] // 当前关卡地图数据
  mut levelCompleted : Bool //当前关卡是否完成标志
}

// 当前关卡
let currentLevel : currentLevelModle = {
  data: maze.copy(),
  levelCompleted: false,
}

// 玩家
let player : playerModel = { x: 1, y: 1 }

// 游戏状态
let gameState : gameStateModel = { isGameOver: false}

// 加载当前关卡  
pub fn loadLevel() -> Unit {
  player.x = findPlayerIndex(currentLevel.data)[0]
  player.y = findPlayerIndex(currentLevel.data)[1]
  gameState.isGameOver = false
  currentLevel.levelCompleted = false
  drawLevel()
}

// 绘制关卡
pub fn drawLevel() -> Unit {
  for y = 0; y < currentLevel.data.length(); y = y + 1 {
    for x = 0; x < currentLevel.data[y].length(); x = x + 1 {
      let tile = currentLevel.data[y][x]
      drawTile(x, y, tile)
    }
  }
  // 如果游戏结束，显示胜利信息  
  // if (gameOver) {
  //     ctx.fillStyle = '#00FF00'; // 绿色胜利信息  
  //     ctx.font = '24px Arial';
  //     ctx.fillText('You Win!', canvas.width / 2 - 50, canvas.height / 2);
  // }
}

//绘制单个瓦片
pub fn drawTile(x : Int, y : Int, tile : Int) -> Unit {
  if tile == 0 {
    @wasm4.set_draw_colors(1)
    @wasm4.rect(x * tile_size, y * tile_size, tile_size, tile_size)
  } else if tile == 1 {
    @wasm4.set_draw_colors(2)
    @wasm4.rect(
      x * tile_size,
      y * tile_size,
      tile_size ,
      tile_size ,
    )
  } else if tile == 2 {
    @wasm4.set_draw_colors(3)
    @wasm4.rect(
      x * tile_size,
      y * tile_size,
      tile_size ,
      tile_size ,
    )
  }else if tile == 3 {
    @wasm4.set_draw_colors(4)
    @wasm4.rect(x * tile_size, y * tile_size, tile_size, tile_size)
  }
}

// 在地图上查找玩家的初始位置  
pub fn findPlayerIndex(level : Array[Array[Int]]) -> Array[Int] {
  for y = 0; y < level.length(); y = y + 1 {
    for x = 0; x < level[y].length(); x = x + 1 {
      if level[y][x] == 2 {
        return [x, y]
      }
    }
  }
  return [-1, -1] // 如果没有找到玩家，返回[-1, -1]（理论上不应该发生）  
}

// 移动玩家   (0,1)
pub fn movePlayer(dx : Int, dy : Int) -> Unit {
  let mut newX = 0
  let mut newY = 0

  newX = (player.x + dx)
  newY = (player.y + dy)
  if newX >= 0 &&
    newX < currentLevel.data.length() &&
    newY >= 0 &&
    newY < currentLevel.data.length() {
    let tile = currentLevel.data[newY][newX]
    if tile == 0  {
      currentLevel.data[player.y][player.x] = 0
      currentLevel.data[newY][newX] = 2
      player.x = newX
      player.y = newY
    } else if tile == 3 {
      currentLevel.data[player.y][player.x] = 0
      currentLevel.data[newY][newX] = 3
      player.x = newX
      player.y = newY
    }
  }

  // 检查胜利条件  
  if checkWin() {
    gameState.isGameOver = true
    @wasm4.text("Game Victory!", 30, 120)
    @wasm4.tone(
      (2000, 0),
      @wasm4.ADSR::new(5),
      @wasm4.ADSRVolume::new(100),
      @wasm4.ToneFlag::new(),
    )
  }
}

// 检查是否胜利

pub fn checkWin()-> Bool {
  if(player.x == -1 && player.y == -1) {
    currentLevel.levelCompleted = true 
    return true
  }
  return false
}


pub fn controlPlayer() -> Unit {
  if gameState.isGameOver == false && currentLevel.levelCompleted == false {
    if @wasm4.get_gamepad().button_right {
      movePlayer(1, 0)
    } else if @wasm4.get_gamepad().button_down {
      movePlayer(0, 1)
    } else if @wasm4.get_gamepad().button_left {
      movePlayer(-1, 0)
    } else if @wasm4.get_gamepad().button_up {
      movePlayer(0, -1)
    }
  }
}

pub fn start() -> Unit {
  loadLevel()
}


struct Position {
  mut x : Int
  mut y : Int
}

let pos : Position = { x: 0, y: 0 }
pub fn update() -> Unit {
  controlPlayer()
  loadLevel()
}
