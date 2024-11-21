enum GameState {
  GSInit // 初始状态
  GSInitMenu //初始菜单
  GSGameStart
  GS2
}

struct GameStat {
  mut game_state : GameState
  mut player_x : Int
  mut player_y : Int
  mut player_flip_x : Bool
  mut player_rotate : Bool
  mut night : Bool
  mut memory : UInt
  mut hp : UInt
  mut lv : UInt
  mut bn : UInt
  mut lock : Bool
  mut lock_player : Bool
  mut tx1 : Int
  mut tx2 : Int
  mut tx3 : Int
  mut tx4 : Int
  mut tx5 : Int
  mut tx6 : Int
  mut tx7 : Int
  mut tx8 : Int
  mut txa1 : Int
  mut txa2 : Int
  mut txa3 : Int
  mut bug_x : Int
  mut bug_y : Int
  mut show_args_bar : Bool
  rng : @random.Rand
}

let gs : GameStat = GameStat::new()

pub fn GameStat::new() -> GameStat {
  {
    game_state: GSInit,
    night: true,
    player_x: 45,
    player_y: 144,
    player_flip_x: false,
    player_rotate: false,
    memory: 100,
    hp: 100,
    lv: 1,
    bn: 0,
    lock: false,
    lock_player: false,
    tx1: 1,
    tx2: 1,
    tx3: 1,
    tx4: 1,
    tx5: 1,
    tx6: 1,
    tx7: 1,
    tx8: 1,
    txa1: 32,
    txa2: 32,
    txa3: 32,
    bug_x: 140,
    bug_y: 150,
    show_args_bar: true,
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

pub fn game_init(self : GameStat) -> Unit {
  draw_game_init(self)
  let gp1 = @wasm4.get_gamepad()
  if butRel(gp1.button_1, prevgp1.button_1) ||
    butRel(gp1.button_2, prevgp1.button_2) ||
    butRel(gp1.button_down, prevgp1.button_down) ||
    butRel(gp1.button_left, prevgp1.button_left) ||
    butRel(gp1.button_right, prevgp1.button_right) ||
    butRel(gp1.button_up, prevgp1.button_up) {
    self.game_state = GSInitMenu
  }
}

pub fn game_init_menu(self : GameStat) -> Unit {
  draw_game_init(self)
  draw_menu(self)
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

pub fn game_start(self : GameStat) -> Unit {
  show_status(self)
  draw_background(self)
  let gp1 = @wasm4.get_gamepad()
  if self.player_x > 1 &&
    gp1.button_left &&
    not(self.lock_player) &&
    self.lv > 7 {
    self.player_x = self.player_x - 1
    self.player_flip_x = true
  } else if gp1.button_right && not(self.lock_player) {
    self.player_x = self.player_x + 1
    self.player_flip_x = false
    self.bn = 0
  } else if butRel(gp1.button_up, prevgp1.button_up) && self.player_y > 100 {
    for n = 0; n < 30; n = n + 1 {
      self.player_y = self.player_y - 1
    }
  }
  if gp1.button_2 {
    self.bn = self.bn + 1
    self.lock_player = false
  }
  if self.player_y < 144 {
    self.player_y = self.player_y + 1
  }
  if self.player_x > 144 {
    self.lv = self.lv + 1
    self.lock = false
    self.player_x = 1
    self.night = not(self.night)
  }
  draw_msg(self)
}

pub fn gs2(self : GameStat) -> Unit {
  if self.lv > 5 {
    bug(self)
  }
  show_status(self)
  draw_msg(self)
  draw_background(self)
  let gp1 = @wasm4.get_gamepad()
  if self.player_x > 1 &&
    gp1.button_left &&
    not(self.lock_player) &&
    self.lv > 1 {
    self.player_x = self.player_x - 1
    self.player_flip_x = true
  } else if gp1.button_right && not(self.lock_player) {
    self.player_x = self.player_x + 1
    if self.lv > 5 {
      self.show_args_bar = true
      self.bug_x = self.bug_x - 1
    }
    if self.bug_x - self.player_x < 10 {
      if self.memory < 1000 {
        self.memory = self.memory + 1
      }
      self.bug_y = 160
      self.bug_x = 0
    }
    self.player_flip_x = false
    self.bn = 0
  } else if butRel(gp1.button_up, prevgp1.button_up) && self.player_y > 100 {
    for n = 0; n < 30; n = n + 1 {
      self.player_y = self.player_y - 1
    }
  } else if gp1.button_2 {
    self.bn = self.bn + 1
    self.lock_player = false
  } else if butRel(gp1.button_1, prevgp1.button_1) {
    self.show_args_bar = not(self.show_args_bar)
  }
  if self.player_y < 144 {
    self.player_y = self.player_y + 1
  }
  if self.player_x > 144 {
    self.lv = self.lv + 1
    self.lock = false
    self.player_x = 1
    self.bug_x = 140
    self.bug_y = 150
    self.night = not(self.night)
  }
}

pub fn game_end(self : GameStat) -> Unit {

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
    GSInitMenu => gs.game_init_menu()
    GSGameStart => gs.game_start()
    GS2 => gs.gs2()
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
  @wasm4.set_palette(4, @wasm4.rgb(0xf9a875)) // 沙粽
  @wasm4.set_palette(1, @wasm4.rgb(0xaa337f)) // 陈玫红 Maximum Red Purple
  @wasm4.set_palette(2, @wasm4.rgb(0xC75B7A)) // 暗岩灰
  @wasm4.set_palette(3, @wasm4.rgb(0xD9ABAB)) // 绿
}
