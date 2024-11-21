// push-box Game
let user = "u"

let wall = "w"

let box = "b"

let goal = "g"

let empty = "e"

let allLevels : Array[Array[Array[String]]] = [
  [
    // 第一关地图  16*16 地图
    [wall, wall, wall, wall, wall, wall, wall, wall,wall, wall, wall, wall, wall, wall, wall, wall],
    [wall, user, empty, box, empty, empty,empty,empty,empty,empty,empty,empty, goal, empty,empty,wall],
    [wall, empty, empty, empty, empty, empty, empty,empty,empty,empty,empty,empty, empty, empty,empty, wall],
    [wall, empty, empty, empty, empty, empty, empty,empty,empty,empty,empty,empty, empty, empty,empty, wall],
    [wall, empty, wall, wall, wall, wall, wall,wall,wall,wall,wall,empty, empty, empty,empty, wall],
    [wall, empty, wall, empty, empty, empty, goal,empty,empty,empty,wall,empty, empty, empty,empty, wall],
    [wall, empty, wall, empty, empty, empty, empty,empty,empty,empty,wall,empty, empty, empty,empty, wall],
    [wall, empty, wall, empty, empty, empty, empty,empty,empty,empty,wall,empty, empty, empty,empty, wall],
    [wall, empty, wall, empty, empty, empty, empty,empty,empty,empty,wall,empty, empty, empty,empty, wall],
    [wall, empty, wall, empty, empty, empty, empty,empty,empty,empty,wall,empty, empty, empty,empty, wall],
    [wall, empty, wall, empty, empty, empty, box,empty,empty,empty,wall,empty, empty, empty,empty, wall],
    [wall, empty, wall, empty, empty, empty, empty,empty,empty,empty,wall,empty, empty, empty,empty, wall],
    [wall, empty, wall, empty, empty, empty, empty,empty,empty,empty,wall,empty, empty, empty,empty, wall],
    [wall, empty, empty, empty, empty, empty, empty,empty,empty,empty,empty,empty, empty, empty,empty, wall],
    [wall, empty, empty, empty, empty, empty, empty,empty,empty,empty,empty,empty, empty, empty,empty, wall],
    [wall, wall, wall, wall, wall, wall, wall, wall,wall, wall, wall, wall, wall, wall, wall, wall],
    // ... 其他行  
  ],
  [
    // 第二关地图  
    [wall, wall, wall, wall, wall, wall, wall, wall],
    [wall, user, empty, box, empty, goal, empty, wall],
    [wall, empty, wall, empty, empty, empty, empty, wall],
    [wall, empty, wall, empty, empty, empty, empty, wall],
    [wall, empty, empty, empty, empty, box, empty, wall],
    [wall, empty, empty, empty, empty, goal, empty, wall],
    [wall, wall, wall, wall, wall, wall, wall, wall],
  ],
  // 更多关卡待设计  
]

let currentLevelIndex = 0 // 当前关卡索引，从0开始

let tile_size = 10 //瓦片尺寸

// 玩家坐标——类型
struct PlayerModel {
  mut x : Int
  mut y : Int
}

//游戏状态-类型
struct GameStateModel {
  mut isGameOver : Bool
  mut gameTitle : String
}

// 当前关卡-类型
struct CurrentLevelModle {
  data : Array[Array[String]] // 当前关卡地图数据
  mut levelCompleted : Bool //当前关卡是否完成标志
}

// 当前关卡
let currentLevel : CurrentLevelModle = {
  data: allLevels[currentLevelIndex].copy(),
  levelCompleted: false,
}

// 玩家
let player : PlayerModel = { x: 1, y: 1 }

// 游戏状态
let gameState : GameStateModel = { isGameOver: false, gameTitle: "start" }

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
  // ctx.clearRect(0, 0, canvas.width, canvas.height);
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
pub fn drawTile(x : Int, y : Int, tile : String) -> Unit {
  if tile == wall {
    @wasm4.set_draw_colors(3)
    @wasm4.rect(x * tile_size, y * tile_size, tile_size, tile_size)
  } else if tile == box {
    @wasm4.set_draw_colors(3)
    @wasm4.rect(
      x * tile_size + 5,
      y * tile_size + 5,
      tile_size ,
      tile_size ,
    )
    // @wasm4.set_draw_colors(4)
    // @wasm4.rect(
    //   x * tile_size + 15,
    //   y * tile_size + 15,
    //   tile_size - 10,
    //   tile_size - 10,
    // )
  } else if tile == goal {
    @wasm4.set_draw_colors(2)
    @wasm4.rect(
      x * tile_size + 5,
      y * tile_size + 5,
      tile_size ,
      tile_size ,
    )
  } else if tile == user {
    @wasm4.set_draw_colors(4)
    @wasm4.rect(x * tile_size, y * tile_size, tile_size, tile_size)
    // @wasm4.rect(x , y , tile_size, tile_size)

  }
}

// 在地图上查找玩家的初始位置  
pub fn findPlayerIndex(level : Array[Array[String]]) -> Array[Int] {
  for y = 0; y < level.length(); y = y + 1 {
    for x = 0; x < level[y].length(); x = x + 1 {
      if level[y][x] == user {
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

  newX = (player.x + dx) //1
  newY = (player.y + dy) // 2
  if newX >= 0 &&
    newX < currentLevel.data[0].length() &&
    newY >= 0 &&
    newY < currentLevel.data.length() {
    let tile = currentLevel.data[newY][newX]
    if tile == empty || tile == box {
      if tile == box {
        let nextTile = currentLevel.data[newY + dy][newX + dx]
        if nextTile == empty || nextTile == goal {
          currentLevel.data[newY + dy][newX + dx] = box
        } else {
          return
        }
      } // Cannot push box into a wall or another box  
      currentLevel.data[player.y][player.x] = empty
      currentLevel.data[newY][newX] = user
      player.x = newX
      player.y = newY
      if tile == goal {
        currentLevel.data[player.y][player.x] = goal
        currentLevel.data[newY][newX] = empty
      }
    }
  }

  // 检查胜利条件  
  if checkWin() {
    gameState.isGameOver = true
  }
}

// 检查是否胜利

pub fn checkWin() -> Bool {
  for y = 0; y < currentLevel.data.length(); y = y + 1 {
    for x = 0; x < currentLevel.data[y].length(); x = x + 1 {
      if currentLevel.data[y][x] == box &&
        allLevels[currentLevelIndex][y][x] == box &&
        currentLevel.data[y][x] != goal {
        return false
        // 如果箱子不在初始位置且不在目标位置上，则未胜利  
      } else if allLevels[currentLevelIndex][y][x] == box &&
        currentLevel.data[y][x] == goal {
        // 如果箱子已经推到目标位置，则继续检查下一个  
        // 这里不需要额外操作，因为只要箱子在目标位置就视为正确  
      } else if allLevels[currentLevelIndex][y][x] == goal &&
        currentLevel.data[y][x] != goal &&
        currentLevel.data[y][x] != box {
        return false
      }
    }
  }
  // 如果目标位置为空且没有箱子，则未胜利（但这种情况通常不会发生，除非玩家把箱子推错了）  
  // 注意：这个条件可能是多余的，因为只要箱子数量正确且都在目标位置，就视为胜利  
  // 如果所有箱子都在目标位置（或初始就不是箱子但现在为空的情况也被视为正确），则胜利  
  currentLevel.levelCompleted = true // 所有箱子都在目标位置，当前关卡完成  
  return true
}


pub fn controlPlayer() -> Unit {
  if gameState.isGameOver == false && currentLevel.levelCompleted == false {
    if @wasm4.get_gamepad(index=1).button_right {
      movePlayer(1, 0)
    } else if @wasm4.get_gamepad(index=1).button_down {
      movePlayer(0, 1)
    } else if @wasm4.get_gamepad(index=1).button_left {
      movePlayer(-1, 0)
    } else if @wasm4.get_gamepad(index=1).button_up {
      movePlayer(0, -1)
    }
    drawLevel()
  } else if currentLevel.levelCompleted {
    // 当前关卡已完成，询问玩家是否继续下一关（这里简单处理为直接跳到下一关）  
    let currentLevelIndex = currentLevelIndex + 1
    if currentLevelIndex < allLevels.length() {
      // alert('加载下一关')
      loadLevel()
    } else { // 加载下一关  
      // 所有关卡都已完成，可以显示“游戏通关”信息  
      gameState.isGameOver = true // 设置为true以阻止进一步的移动输入  
      @wasm4.set_draw_colors(0x4U, index=4)
      @wasm4.text("Game Over!", 40, 80)
    }
  }
}

pub fn start() -> Unit {

}


struct Position {
  mut x : Int
  mut y : Int
}

let pos : Position = { x: 0, y: 0 }
pub fn update() -> Unit {
  loadLevel()
  controlPlayer()

}
