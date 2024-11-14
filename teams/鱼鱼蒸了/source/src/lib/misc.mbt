pub fn draw_pixel(x : Int, y : Int) -> Unit {
  @wasm.rect(x, y, 1, 1)
}

pub type DrawEnemy (Int, Int, Int) -> Unit

pub let draw_default : DrawEnemy = fn(x : Int, y : Int, size : Int) -> Unit {
  @wasm.rect(x, y, size, size)
}
