enum GameState {
  GSInit // 初始状态
  GSGameStart
}

struct GameStat {
  mut game_state : GameState
  vs : String
  ps : @hashmap.T[String, String]
  x : Int
  y : Int
  mut tl : Double
  angle : Double
  mut levels : UInt
  mut color : UInt
  mut show_args_bar : Bool
  mut select_arg : UInt
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
    if self.select_arg < 2 {
      self.select_arg = self.select_arg + 1
    } else {
      self.select_arg = 0
    }
  } else if butRel(gp1.button_left, prevgp1.button_left) {
    if self.select_arg > 0 {
      self.select_arg = self.select_arg - 1
    } else {
      self.select_arg = 2
    }
  } else if butRel(gp1.button_up, prevgp1.button_up) {
    if self.select_arg == 0 && self.tl < 9 {
      if self.levels == 5 && self.tl >= 2 {

      } else {
        self.tl = self.tl + 1
      }
    } else if self.select_arg == 1 && self.levels < 4 {
      
        self.levels = self.levels + 1
      
    } 
  } else if butRel(gp1.button_down, prevgp1.button_down) {
    if self.select_arg == 0 && self.tl > 1 {
      self.tl = self.tl - 1
    } else if self.select_arg == 1 && self.levels > 1 {
      self.levels = self.levels - 1
    } 
  }

}


let gs : GameStat = GameStat::new()

pub fn GameStat::new() -> GameStat {
  {
    game_state: GSInit,
    vs: "A",
    ps: @hashmap.of([("A", "-BF+AFA+FB-"), ("B", "+AF-BFB-FA+")]),
    x: 1,
    y: 1,
    tl: 2.0,
    angle: 90.0,
    levels: 2U,
    color: 2,
    show_args_bar: true,
    select_arg: 0,
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
      @wasm4.set_draw_colors(4)
      @wasm4.text("L-System", 10, 10)
      
      @wasm4.text("Hilbert Curve", 30, 20)
     
      @wasm4.text("Emulator V1.0", 40, 30)
       @wasm4.set_draw_colors(3)
      @wasm4.text("Press x to start", 20, 150)
      fractal(50, 40, "A", @hashmap.of([("A", "-BF+AFA+FB-"), ("B", "+AF-BFB-FA+")]), 4.0, 90.0, 4, self.color)
    }
    GSGameStart => {
      if self.show_args_bar {
        @wasm4.set_draw_colors(2)
        if self.select_arg == 0 {
          @wasm4.set_draw_colors(3)
        }
        @wasm4.text("l:" + self.tl.to_string(), 1, 150)
        @wasm4.set_draw_colors(2)
        if self.select_arg == 1 {
          @wasm4.set_draw_colors(3)
        }
        @wasm4.text("lv:" + self.levels.to_string(), 45, 150)
        @wasm4.set_draw_colors(2)
        if self.select_arg == 2 {
          @wasm4.set_draw_colors(3)
        }


      }
      fractal(
        10,
        20,
        self.vs,
        self.ps,
        self.tl,
        self.angle,
        self.levels,
        self.color,
      )
    }
  }
}

pub fn generate_string(
  vs : String,
  ps : @hashmap.T[String, String],
  levels : UInt
) -> String {
  let mut this_vs : String = vs
  for i = 0U; i < levels; i = i + 1 {
    let mut next_rule = ""
    for v in this_vs {
      let cv : String = v.to_string()
      match ps.get(cv) {
        Some(value) => next_rule = next_rule + value
        None => next_rule = next_rule + cv
      }
    }
    this_vs = next_rule
  }
  this_vs
}

fn l_system(
  vs : String,
  ps : @hashmap.T[String, String],
  x : Int,
  y : Int,
  tl : Double,
  langle : Double,
  levels : UInt
) -> Array[(Int, Int)] {
  let l_string = generate_string(vs, ps, levels)
  let mut x = x
  let mut y = y
  let coordinates = []
  let mut angle = 90.0
  // let  langle = langle
  let st : @stack.Stack[(Int, Int, Double)] = @stack.Stack::new()
  fn coord(length : Double, langle : Double) {
    let rad : Double = langle * @math.pi / 180.0
    let steps = 4.0
    for i = 0.0; i < steps + 1; i = i + 1 {
      let nx = x + @math.round(i * length / steps * @math.cos(rad)).to_int()
      let ny = y + @math.round(i * length / steps * @math.sin(rad)).to_int()
      coordinates.push((nx, ny))
    }
    x = x + @math.round(length * @math.cos(rad)).to_int()
    y = y + @math.round(length * @math.sin(rad)).to_int()
  }

  // @wasm4.trace(l_system)
  for char in l_string {
    match char {
      'F' | 'G' => coord(tl, angle)
      '+' => angle = angle + langle
      '-' => angle = angle - langle
      '[' => st.push((x, y, angle))
      ']' =>
        match st.pop() {
          Some(value) => {
            x = value.0
            y = value.1
            angle = value.2
          }
          None => {
            ()
            @wasm4.trace("character not found")
          }
        }
      _ => ()
    }
  }
  coordinates
}

pub fn fractal(
  offset_x : Int,
  offset_y : Int,
  vs : String,
  ps : @hashmap.T[String, String],
  tl : Double,
  angle : Double,
  levels : UInt,
  color : UInt
) -> Unit {
  let thetas = l_system(vs, ps, offset_x, offset_y, tl, angle, levels)
  for theta in thetas {
    let x = theta.0.reinterpret_as_uint()
    let y = (160 - theta.1).reinterpret_as_uint()
    @wasm4.set_frame_buffer(y * 160 + x, color)
  }
}
