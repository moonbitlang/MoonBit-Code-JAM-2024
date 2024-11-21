pub fn draw_hit(x : Int, y : Int, ~size : Int = 1) -> Unit {
  @wasm.set_draw_colors(1, index=1)
  @wasm.set_draw_colors(1, index=2)
  for i = 0; i < size; i = i + 1 {
    for j = 0; j < size; j = j + 1 {
      for k = 0; k < 7; k = k + 1 {
        let l = 13 - k * 2
        draw_pixel(x + i + k * size, y + j + l * size)
        draw_pixel(x + i + k * size, y + j + (l - 1) * size)
      }
    }
  }
}
