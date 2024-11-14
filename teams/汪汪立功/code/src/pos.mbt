struct Position {
  x : Double
  y : Double
}

fn to_wasm4_pos(self : Position) -> (Int, Int) {
  (self.x.to_int(), self.y.to_int())
}

fn distance(self : Position, other : Position) -> Double {
  ((self.x - other.x) * (self.x - other.x) +
  (self.y - other.y) * (self.y - other.y)).sqrt()
}

fn find_way(self : Position, to : Position, speed : Double) -> Position {
  let x_diff = speed * (to.x - self.x).compare(0).to_double()
  let y_diff = speed * (to.y - self.y).compare(0).to_double()
  { x: self.x + x_diff, y: self.y + y_diff }
}
