pub struct Game {
  mut player_x : Int
  mut player_y : Int
  mut box_positions : Array[(Int, Int)] // 箱子的位置
  mut goal_positions : Array[(Int, Int)] // 目标位置
  mut walls : Array[(Int, Int)] // 墙壁的位置数组
  mut prev_gamepad : @wasm4.GamePad
  mut won : Bool // 标志游戏是否胜利
  mut level : Int
} // 当前关卡数

// 定义玩家精灵
let player_sprite : @wasm4.Sprite = @wasm4.sprite(
  b"\x3C\x42\x81\xA5\x81\xA5\x81\x42\x3C", // 一个8x8的二进制数据
)

// 初始化游戏状态
let g : Game = Game::{
  player_x: 4,
  player_y: 4,
  box_positions: [(3, 3)], // 初始只有一个箱子
  goal_positions: [(6, 6)], // 初始目标位置
  walls: [], // 初始墙壁为空，稍后在关卡初始化中设置
  prev_gamepad: @wasm4.GamePad::default(),
  won: false,
  level: 1,
}

// 初始化不同关卡
// 初始化不同关卡
fn initialize_level(level : Int) -> Unit {
  // 定义边框位置
  let border_walls = [
    (0, 0),
    (0, 1),
    (0, 2),
    (0, 3),
    (0, 4),
    (0, 5),
    (0, 6),
    (0, 7), // 左边框
    (7, 0),
    (7, 1),
    (7, 2),
    (7, 3),
    (7, 4),
    (7, 5),
    (7, 6),
    (7, 7), // 右边框
    (1, 0),
    (2, 0),
    (3, 0),
    (4, 0),
    (5, 0),
    (6, 0), // 上边框
    (1, 7),
    (2, 7),
    (3, 7),
    (4, 7),
    (5, 7),
    (6, 7), // 下边框
  ]
  match level {
    1 => {
      g.player_x = 4
      g.player_y = 4
      g.box_positions = [(3, 3)]
      g.goal_positions = [(6, 6)]
      g.walls = border_walls
      g.won = false
    }
    2 => {
      g.player_x = 1
      g.player_y = 1
      g.box_positions = [(2, 2), (5, 5)]
      g.goal_positions = [(1, 6), (6, 1)]
      g.walls = border_walls + [(3, 3), (4, 4)]
      g.won = false
    }
    3 => {
      g.player_x = 1
      g.player_y = 1
      g.box_positions = [(2, 2), (3, 4), (5, 5)]
      g.goal_positions = [(1, 6), (6, 1), (5, 6)]
      g.walls = border_walls + [(2, 3), (4, 3), (4, 5)]
      g.won = false
    }
    _ => {
      g.won = true
      @wasm4.text("All levels completed!", 0, 80)
    }
  }
}

// 初始化游戏
pub fn start() -> Unit {
  initialize_level(1) // 初始化第1级
}

// 检查是否为墙壁或其他障碍
fn is_wall(x : Int, y : Int) -> Bool {
  match g.walls.iter().find_first(fn { (wx, wy) => wx == x && wy == y }) {
    Some(_) => true
    None => false
  }
}

// 检查是否为目标位置
fn is_goal(x : Int, y : Int) -> Bool {
  g.goal_positions.iter().any(fn { (gx, gy) => gx == x && gy == y })
}

// 检查是否为箱子位置
fn is_box(x : Int, y : Int) -> Bool {
  g.box_positions.iter().any(fn { (bx, by) => bx == x && by == y })
}

// 检查胜利条件
fn check_win() -> Bool {
  g.box_positions.iter().all(fn { (bx, by) => is_goal(bx, by) })
}

// 更新游戏状态
pub fn update() -> Unit {
  let gamepad = @wasm4.get_gamepad()

  // 按下 button_1 进入下一关
  if g.won && gamepad.button_1 {
    g.level += 1
    initialize_level(g.level)
    return
  }

  // 控制移动
  if gamepad != g.prev_gamepad && not(g.won) {
    let mut move_x = 0
    let mut move_y = 0
    if gamepad.button_up {
      move_y = -1
    }
    if gamepad.button_down {
      move_y = 1
    }
    if gamepad.button_left {
      move_x = -1
    }
    if gamepad.button_right {
      move_x = 1
    }
    let new_player_x = g.player_x + move_x
    let new_player_y = g.player_y + move_y

    // 检查玩家是否尝试移动到墙壁或箱子上
    if not(is_wall(new_player_x, new_player_y)) {
      let mut pushed = false
      for i = 0; i < g.box_positions.length(); i = i + 1 {
        let (bx, by) = g.box_positions[i]
        if new_player_x == bx && new_player_y == by {
          // 玩家尝试推动箱子
          let new_box_x = bx + move_x
          let new_box_y = by + move_y
          // 检查新位置是否有墙壁或另一个箱子
          if not(is_wall(new_box_x, new_box_y)) &&
            not(is_box(new_box_x, new_box_y)) {
            g.box_positions[i] = (new_box_x, new_box_y)
            g.player_x = bx
            g.player_y = by
            pushed = true
          }
          break
        }
      }
      if not(pushed) {
        // 如果没有推动箱子，正常移动玩家
        g.player_x = new_player_x
        g.player_y = new_player_y
      }
    }
    g.prev_gamepad = gamepad
  }

  // 胜利检测
  if check_win() && not(g.won) {
    g.won = true
    @wasm4.tone(
      (600, 800),
      @wasm4.ADSR::new(30, release=5),
      @wasm4.ADSRVolume::new(40, peak=80),
      @wasm4.ToneFlag::new(),
    )
  }
  if g.won {
    @wasm4.text("You Win! Press X", 5, 140)
    @wasm4.text("Into next Level", 5, 150)
  }

  // 绘制元素
  @wasm4.set_draw_colors(3, index=1)
  g.goal_positions
  .iter()
  .each(fn { (gx, gy) => @wasm4.rect(gx * 8 + 32, gy * 8 + 32, 8, 8) }) // 目标位置居中
  @wasm4.set_draw_colors(2)
  g.walls
  .iter()
  .each(fn { (x, y) => @wasm4.rect(x * 8 + 32, y * 8 + 32, 8, 8) }) // 墙壁和边框
  @wasm4.set_draw_colors(4)
  g.box_positions
  .iter()
  .each(fn { (bx, by) => @wasm4.rect(bx * 8 + 32, by * 8 + 32, 8, 8) }) // 箱子

  // 使用玩家精灵绘制玩家
  @wasm4.set_draw_colors(3, index=2)
  player_sprite.blit(
    g.player_x * 8 + 32,
    g.player_y * 8 + 32,
    8,
    8,
    { one_bit_per_pixel: true, flip_x: false, flip_y: false, rotate: false },
  )
}
