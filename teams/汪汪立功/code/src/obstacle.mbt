enum Obstacle {
  Jar(Int, Int)
  Tombstone(Int, Int)
}

fn get_obstacle_hitbox(self : Obstacle) -> Shape {
  match self {
    Jar(x, y) =>
      Rect(x.to_float(), y.to_float(), x.to_float() + 12, y.to_float() + 12)
    Tombstone(x, y) =>
      Rect(x.to_float(), y.to_float(), x.to_float() + 7, y.to_float() + 13)
  }
}

fn render_obstacle(self : Obstacle) -> Unit {
  match self {
    Jar(x, y) => jar_texture.render_texture(x, y)
    Tombstone(x, y) => tombstone_texture.render_texture(x, y)
  }
}
