enum GameState {
  GSInit // 初始状态
  GSGameStart
}

struct GameStat {
  mut game_state : GameState
  mut d : Double
  mut lr : Double
  mut br : Double
  mut revs : Double
  niter : Double
  mut color : UInt
  mut show_args_bar : Bool
  mut select_arg : UInt
  rng : @random.Rand
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
    self.game_state = GSGameStart
  }
}

pub fn game_start(self : GameStat) -> Unit {
  draw_game_init(self)
  let gp1 = @wasm4.get_gamepad()
  if butRel(gp1.button_2, prevgp1.button_2) {
    self.show_args_bar = not(self.show_args_bar)
  } else if butRel(gp1.button_1, prevgp1.button_1) {
    if self.color < 4 {
      self.color = self.color + 1
    } else {
      self.color = 2
    }
  } else if butRel(gp1.button_right, prevgp1.button_right) {
    if self.select_arg < 3 {
      self.select_arg = self.select_arg + 1
    } else {
      self.select_arg = 0
    }
  } else if butRel(gp1.button_left, prevgp1.button_left) {
    if self.select_arg > 0 {
      self.select_arg = self.select_arg - 1
    } else {
      self.select_arg = 3
    }
  } else if butRel(gp1.button_up, prevgp1.button_up) {
    if self.select_arg == 0 && self.d < 30 {
      self.d = self.d + 1
    } else if self.select_arg == 1 && self.lr < 30 {
      self.lr = self.lr + 1
    } else if self.select_arg == 2 && self.br < 30 {
      self.br = self.br + 1
    } else if self.select_arg == 3 && self.revs < 30 {
      self.revs = self.revs + 1
    }
  } else if butRel(gp1.button_down, prevgp1.button_down) {
    if self.select_arg == 0 && self.d > 1 {
      self.d = self.d - 1
    } else if self.select_arg == 1 && self.lr > 1 {
      self.lr = self.lr - 1
    } else if self.select_arg == 2 && self.br > 1 {
      self.br = self.br - 1
    } else if self.select_arg == 3 && self.br > 1 {
      self.revs = self.revs - 1
    }
  }
}

let gs : GameStat = GameStat::new()

pub fn GameStat::new() -> GameStat {
  {
    game_state: GSInit,
    d: 30,
    lr: 24,
    br: 4,
    revs: 30,
    niter: 2000,
    color: 2,
    show_args_bar: true,
    select_arg: 0,
    rng: @random.new(),
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
  @wasm4.set_palette(2, @wasm4.rgb(0xaa337f)) // 陈玫红 Maximum Red Purple
  @wasm4.set_palette(1, @wasm4.rgb(0xC75B7A)) // 暗岩灰
  @wasm4.set_palette(3, @wasm4.rgb(0xD9ABAB)) // 绿
}

pub fn draw_game_init(self : GameStat) -> Unit {
  match self.game_state {
    GSInit => {
      @wasm4.text("Hypotrochoid", 30, 10)
      @wasm4.text("Emulator V1.0", 30, 20)
      @wasm4.text("Press x to start", 20, 150)
      hypotrochoid_line(
        80,
        80,
        self.d,
        self.lr,
        self.br,
        self.revs,
        self.niter,
        self.color,
      )
    }
    GSGameStart => {
      if self.show_args_bar {
        @wasm4.set_draw_colors(2)
        if self.select_arg == 0 {
          @wasm4.set_draw_colors(3)
        }
        @wasm4.text("d:" + self.d.to_string(), 1, 150)
        @wasm4.set_draw_colors(2)
        if self.select_arg == 1 {
          @wasm4.set_draw_colors(3)
        }
        @wasm4.text("lr:" + self.lr.to_string(), 37, 150)
        @wasm4.set_draw_colors(2)
        if self.select_arg == 2 {
          @wasm4.set_draw_colors(3)
        }
        @wasm4.text("br:" + self.br.to_string(), 82, 150)
        @wasm4.set_draw_colors(2)
        if self.select_arg == 3 {
          @wasm4.set_draw_colors(3)
        }
        @wasm4.text("ti:" + self.revs.to_string(), 120, 150)
      }
      hypotrochoid_line(
        80,
        80,
        self.d,
        self.lr,
        self.br,
        self.revs,
        self.niter,
        self.color,
      )
    }
  }
}

fn x_coordinate(d : Double, lr : Double, br : Double, theta : Double) -> Double {
  (br - lr) * @math.cos(theta) + d * @math.cos((br - lr) / lr * theta)
}

fn y_coordinate(d : Double, lr : Double, br : Double, theta : Double) -> Double {
  (br - lr) * @math.sin(theta) + d * @math.sin((br - lr) / lr * theta)
}

fn linspace(start : Double, stop : Double, num : Double) -> Array[Double] {
  let step : Double = (stop - start) / (num - 1)
  let value = []
  for x = 0.0; x < num; x = x + 1 {
    value.push(start + step * x)
  } else {
    return value
  }
}

pub fn hypotrochoid_line(
  offset_x : Int,
  offset_y : Int,
  d : Double,
  lr : Double,
  br : Double,
  revs : Double,
  niter : Double,
  color : UInt
) -> Unit {
  let revs = revs
  let d = d
  let lr = lr
  let br = br
  let niter = niter
  let thetas = linspace(0.0, revs * 2.0 * @math.pi, niter)
  for theta in thetas {
    let x = (@math.round(x_coordinate(d, lr, br, theta)).to_int() + offset_x).reinterpret_as_uint()
    let y = (@math.round(y_coordinate(d, lr, br, theta)).to_int() + offset_y).reinterpret_as_uint()
    @wasm4.set_frame_buffer(y * 160 + x, color)
  }
}
