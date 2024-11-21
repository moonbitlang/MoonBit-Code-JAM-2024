extern "wasm" fn float_to_int(f : Float) -> Int =
  #| (func (param f32) (result i32) local.get 0 i32.trunc_f32_s)

struct Position {
  x : Float
  y : Float
}

fn to_wasm4_pos(self : Position) -> (Int, Int) {
  (float_to_int(self.x), float_to_int(self.y))
}

fn distance(self : Position, other : Position) -> Float {
  ((self.x - other.x) * (self.x - other.x) +
  (self.y - other.y) * (self.y - other.y)).sqrt()
}

fn get_hitbox_f(self : Position, f : Float) -> Shape {
  Rect(self.x - f, self.y - f, self.x + f, self.y + f)
}

fn find_way(self : Position, to : Position, speed : Float) -> Position {
  let x_diff = speed * (to.x - self.x).compare(0).to_float()
  let y_diff = speed * (to.y - self.y).compare(0).to_float()
  { x: self.x + x_diff, y: self.y + y_diff }
}
