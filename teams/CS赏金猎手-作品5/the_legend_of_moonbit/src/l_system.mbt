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
    let steps = 2.0
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

pub fn fractal_tree(
  offset_x : Int,
  offset_y : Int,
  vs : String,
  tl : Double,
  angle : Double,
  levels : UInt,
  color : UInt
) -> Unit {
  let ps : @hashmap.T[String, String] = @hashmap.of(
    [("X", "F[-X][+X]FX"), ("F", "FF")],
  )
  let thetas = l_system(vs, ps, offset_x, offset_y, tl, angle, levels)
  for theta in thetas {
    let x = theta.0.reinterpret_as_uint()
    let y = (160 - theta.1).reinterpret_as_uint()
    @wasm4.set_frame_buffer(y * 160 + x, color)
  }
}
