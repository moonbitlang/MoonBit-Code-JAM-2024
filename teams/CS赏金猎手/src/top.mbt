enum GameState {
  GSInit // 初始状态
  GSGameStart // 游戏中
  GSGameEnd // 游戏结束
}

struct GameStat {
  mut game_state : GameState
  mut score : UInt
  mut times : UInt
  gamemap : FixedArray[FixedArray[Char]]
  mut player_x : Int
  mut player_y : Int
  mut win : String
  mut step : Int
  rng : @random.Rand
}

// 使用 let 声明一个名为 gs 的变量， 并将其初始化为 GameStat 类型的一个新实例。
let gs : GameStat = GameStat::new()

pub fn GameStat::new() -> GameStat {
  let gamemap : FixedArray[FixedArray[Char]] = [
    ['0', '0', '0'],
    ['0', '0', '0'],
    ['0', '0', '0'],
  ]
  {
    game_state: GSInit,
    score: 0,
    times: 0,
    gamemap,
    player_x: 1,
    player_y: 1,
    win: "",
    step: 0,
    rng: @random.new(),
  }
}

pub struct PrevGamePad {
  mut button_1 : Bool
  mut button_2 : Bool
  mut button_left : Bool
  mut button_right : Bool
  mut button_up : Bool
  mut button_down : Bool
} derive(Eq, Default)

pub fn butRel(cur_button : Bool, prev_button : Bool) -> Bool {
  return cur_button && not(prev_button)
}

pub fn put_point(self : GameStat) -> Unit {
  if self.gamemap[self.player_x][self.player_y] == '0' {
    self.gamemap[self.player_x][self.player_y] = '1'
  }
}

pub fn moveLeft(self : GameStat) -> Unit {
  if self.player_x > 0 {
    self.player_x = self.player_x - 1
  }
}

pub fn moveRight(self : GameStat) -> Unit {
  if self.player_x < 2 {
    self.player_x = self.player_x + 1
  }
}

pub fn moveUp(self : GameStat) -> Unit {
  if self.player_y > 0 {
    self.player_y = self.player_y - 1
  }
}

pub fn moveDown(self : GameStat) -> Unit {
  if self.player_y < 2 {
    self.player_y = self.player_y + 1
  }
}

pub fn game_init(self : GameStat) -> Unit {
  draw_game(self)
  let gp1 = @wasm4.get_gamepad()
  if butRel(gp1.button_1, prevgp1.button_1) ||
    butRel(gp1.button_2, prevgp1.button_2) ||
    butRel(gp1.button_down, prevgp1.button_down) ||
    butRel(gp1.button_left, prevgp1.button_left) ||
    butRel(gp1.button_right, prevgp1.button_right) ||
    butRel(gp1.button_up, prevgp1.button_up) {
    self.game_state = GSGameStart
  }
}

pub fn add_score(self : GameStat) -> Unit {
  self.score = self.score + 1
}

pub fn judge(self : GameStat) -> Bool {
  if (
      self.gamemap[0][0] == self.gamemap[1][0] &&
      self.gamemap[0][0] == self.gamemap[2][0] &&
      self.gamemap[0][0] == '1'
    ) ||
    (
      self.gamemap[0][1] == self.gamemap[1][1] &&
      self.gamemap[0][1] == self.gamemap[2][1] &&
      self.gamemap[0][1] == '1'
    ) ||
    (
      self.gamemap[0][2] == self.gamemap[1][2] &&
      self.gamemap[0][2] == self.gamemap[2][2] &&
      self.gamemap[0][2] == '1'
    ) ||
    (
      self.gamemap[0][0] == self.gamemap[0][1] &&
      self.gamemap[0][0] == self.gamemap[0][2] &&
      self.gamemap[0][0] == '1'
    ) ||
    (
      self.gamemap[1][0] == self.gamemap[1][1] &&
      self.gamemap[1][0] == self.gamemap[1][2] &&
      self.gamemap[1][0] == '1'
    ) ||
    (
      self.gamemap[2][0] == self.gamemap[2][1] &&
      self.gamemap[2][0] == self.gamemap[2][2] &&
      self.gamemap[2][0] == '1'
    ) ||
    (
      self.gamemap[0][0] == self.gamemap[1][1] &&
      self.gamemap[0][0] == self.gamemap[2][2] &&
      self.gamemap[0][0] == '1'
    ) ||
    (
      self.gamemap[0][2] == self.gamemap[1][1] &&
      self.gamemap[0][2] == self.gamemap[2][0] &&
      self.gamemap[0][2] == '1'
    ) {
    self.win = "Win"
    self.add_score()
    self.times = self.times + 1
    self.game_state = GSGameEnd
    return false
  }
  if (
      self.gamemap[0][0] == self.gamemap[1][0] &&
      self.gamemap[0][0] == self.gamemap[2][0] &&
      self.gamemap[0][0] == '2'
    ) ||
    (
      self.gamemap[0][1] == self.gamemap[1][1] &&
      self.gamemap[0][1] == self.gamemap[2][1] &&
      self.gamemap[0][1] == '2'
    ) ||
    (
      self.gamemap[0][2] == self.gamemap[1][2] &&
      self.gamemap[0][2] == self.gamemap[2][2] &&
      self.gamemap[0][2] == '2'
    ) ||
    (
      self.gamemap[0][0] == self.gamemap[0][1] &&
      self.gamemap[0][0] == self.gamemap[0][2] &&
      self.gamemap[0][0] == '2'
    ) ||
    (
      self.gamemap[1][0] == self.gamemap[1][1] &&
      self.gamemap[1][0] == self.gamemap[1][2] &&
      self.gamemap[1][0] == '2'
    ) ||
    (
      self.gamemap[2][0] == self.gamemap[2][1] &&
      self.gamemap[2][0] == self.gamemap[2][2] &&
      self.gamemap[2][0] == '2'
    ) ||
    (
      self.gamemap[0][0] == self.gamemap[1][1] &&
      self.gamemap[0][0] == self.gamemap[2][2] &&
      self.gamemap[0][0] == '2'
    ) ||
    (
      self.gamemap[0][2] == self.gamemap[1][1] &&
      self.gamemap[0][2] == self.gamemap[2][0] &&
      self.gamemap[0][2] == '2'
    ) {
    self.win = "Loss"
    self.times = self.times + 1
    self.game_state = GSGameEnd
    return false
  }
  if self.step == 9 {
    self.win = "Tie"
    self.times = self.times + 1
    self.game_state = GSGameEnd
    return false
  }
  return true
}

pub fn game_start(self : GameStat) -> Unit {
  draw_game(self)
  let gp1 = @wasm4.get_gamepad()
  if butRel(gp1.button_left, prevgp1.button_left) {
    moveLeft(self)
  } else if butRel(gp1.button_right, prevgp1.button_right) {
    moveRight(self)
  } else if butRel(gp1.button_up, prevgp1.button_up) {
    moveUp(self)
  } else if butRel(gp1.button_down, prevgp1.button_down) {
    moveDown(self)
  } else if butRel(gp1.button_1, prevgp1.button_1) {
    let x = self.player_x
    let y = self.player_y
    if self.gamemap[x][y] == '0' {
      self.gamemap[x][y] = '1'
      self.step = self.step + 1
      let ju = judge(self)
      draw_game(self)
      let mut flag = true
      while flag && ju {
        let limit = 3
        let x = self.rng.int(~limit)
        let y = self.rng.int(~limit)
        if self.gamemap[x][y] == '0' {
          self.gamemap[x][y] = '2'
          self.step = self.step + 1
          flag = false
        }
      }
      draw_game(self)
      if ju {
        let _ = judge(self)

      }
    }
  }
}

pub fn draw_game(self : GameStat) -> Unit {
  @wasm4.set_draw_colors(2)
  @wasm4.text("Tic-Tac-Toe", 10, 10)
  @wasm4.text("S:", 125, 90)
  @wasm4.text("T:", 125, 75)
  let win_times = self.score.to_string()
  let total_times = self.times.to_string()
  @wasm4.text(win_times, 140, 90)
  @wasm4.text(total_times, 140, 75)
  match self.game_state {
    GSInit => @wasm4.text("Press x to start", 10, 20)
    GSGameStart => @wasm4.text("Game Start", 10, 20)
    GSGameEnd => @wasm4.text("Game End", 10, 20)
  }
  if self.win == "Win" {
    @wasm4.set_draw_colors(3)
    @wasm4.text("You Win", 30, 30)
  } else if self.win == "Loss" {
    @wasm4.text("You Loss", 30, 30)
  } else if self.win == "Tie" {
    @wasm4.text("Tie", 30, 30)
  }
  @wasm4.set_draw_colors(4)
  @wasm4.line(1, 40, 120, 40)
  @wasm4.line(1, 80, 120, 80)
  @wasm4.line(1, 120, 120, 120)
  @wasm4.line(1, 40, 1, 160)
  @wasm4.line(40, 40, 40, 160)
  @wasm4.line(80, 40, 80, 160)
  @wasm4.line(120, 40, 120, 160)
  if self.player_x == 0 && self.player_y == 0 {
    @wasm4.set_draw_colors(2)
    @wasm4.line(1, 40, 40, 40)
    @wasm4.line(1, 80, 40, 80)
    @wasm4.line(1, 40, 1, 80)
    @wasm4.line(40, 40, 40, 80)
  }
  if self.player_x == 1 && self.player_y == 0 {
    @wasm4.set_draw_colors(2)
    @wasm4.line(40, 40, 80, 40)
    @wasm4.line(40, 80, 80, 80)
    @wasm4.line(40, 40, 40, 80)
    @wasm4.line(80, 40, 80, 80)
  }
  if self.player_x == 2 && self.player_y == 0 {
    @wasm4.set_draw_colors(2)
    @wasm4.line(80, 40, 120, 40)
    @wasm4.line(80, 80, 120, 80)
    @wasm4.line(80, 40, 80, 80)
    @wasm4.line(120, 40, 120, 80)
  }
  if self.player_x == 0 && self.player_y == 1 {
    @wasm4.set_draw_colors(2)
    @wasm4.line(1, 80, 40, 80)
    @wasm4.line(1, 120, 40, 120)
    @wasm4.line(1, 80, 1, 120)
    @wasm4.line(40, 80, 40, 120)
  } else if self.player_x == 1 && self.player_y == 1 {
    @wasm4.set_draw_colors(2)
    @wasm4.line(40, 80, 80, 80)
    @wasm4.line(40, 120, 80, 120)
    @wasm4.line(40, 80, 40, 120)
    @wasm4.line(80, 80, 80, 120)
  }
  if self.player_x == 2 && self.player_y == 1 {
    @wasm4.set_draw_colors(2)
    @wasm4.line(80, 80, 120, 80)
    @wasm4.line(80, 120, 120, 120)
    @wasm4.line(80, 80, 80, 120)
    @wasm4.line(120, 80, 120, 120)
  }
  if self.player_x == 0 && self.player_y == 2 {
    @wasm4.set_draw_colors(2)
    @wasm4.line(1, 120, 40, 120)
    @wasm4.line(1, 160, 40, 160)
    @wasm4.line(1, 120, 1, 160)
    @wasm4.line(40, 120, 40, 160)
  } else if self.player_x == 1 && self.player_y == 2 {
    @wasm4.set_draw_colors(2)
    @wasm4.line(40, 120, 80, 120)
    @wasm4.line(40, 160, 80, 160)
    @wasm4.line(40, 120, 40, 160)
    @wasm4.line(80, 120, 80, 160)
  }
  if self.player_x == 2 && self.player_y == 2 {
    @wasm4.set_draw_colors(2)
    @wasm4.line(80, 120, 120, 120)
    @wasm4.line(80, 160, 120, 160)
    @wasm4.line(80, 120, 80, 160)
    @wasm4.line(120, 120, 120, 160)
  }
  for x = 0; x < 3; x = x + 1 {
    for y = 0; y < 3; y = y + 1 {
      if self.gamemap[x][y] == '1' {
        @wasm4.set_draw_colors(3)
        @wasm4.text("X", x * 40 + 20, y * 40 + 50)
      } else if self.gamemap[x][y] == '2' {
        @wasm4.set_draw_colors(2)
        @wasm4.text("O", x * 40 + 20, y * 40 + 50)
      }
    }
  }
}

pub fn game_end(self : GameStat) -> Unit {
  draw_game(self)
  let gp1 = @wasm4.get_gamepad()
  if butRel(gp1.button_1, prevgp1.button_1) {
    self.game_state = GSInit
    self.win = "None"
    self.player_x = 1
    self.player_y = 1
    self.step = 0
    for x = 0; x < 3; x = x + 1 {
      for y = 0; y < 3; y = y + 1 {
        self.gamemap[x][y] = '0'
      }
    }
  }
}

let prevgp1 : PrevGamePad = {
  button_1: false,
  button_2: false,
  button_down: false,
  button_left: false,
  button_right: false,
  button_up: false,
}

pub fn update() -> Unit {
  match gs.game_state {
    GSInit => gs.game_init()
    GSGameStart => gs.game_start()
    GSGameEnd => gs.game_end()
  }
  let gp1 = @wasm4.get_gamepad()
  prevgp1.button_1 = gp1.button_1
  prevgp1.button_2 = gp1.button_2
  prevgp1.button_down = gp1.button_down
  prevgp1.button_left = gp1.button_left
  prevgp1.button_right = gp1.button_right
  prevgp1.button_up = gp1.button_up
}

pub fn start() -> Unit {
  @wasm4.trace("Hello world!")
  @wasm4.set_palette(1, @wasm4.rgb(0x282e30)) // 暗岩灰
  @wasm4.set_palette(2, @wasm4.rgb(0xaa337f)) // 陈玫红 Maximum Red Purple
  @wasm4.set_palette(3, @wasm4.rgb(0xd4392e)) // 茜红
  @wasm4.set_palette(4, @wasm4.rgb(0x898f92)) // 
}
