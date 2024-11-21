pub let draw_heal : DrawEnemy = fn(x : Int, y : Int, size : Int) -> Unit {
  for k = 0; k < 1 * size; k = k + 1 {
    for l = 0; l < 1 * size; l = l + 1 {
      @wasm.set_draw_colors(2, index=2)
      for i = 0; i < 5; i = i + 1 {
        for j = 2; j < 6; j = j + 1 {
          draw_pixel(x + k + i * size, y + l + j * size)
        }
      }
      @wasm.set_draw_colors(3, index=2)
      draw_pixel(x + k + 1 * size, y + l)
      draw_pixel(x + k + 3 * size, y + l)
      for i = 1; i < 6; i = i + 1 {
        draw_pixel(x + k + 2 * size, y + l + i * size)
      }
      @wasm.set_draw_colors(4, index=2)
      for i = 0; i < 5; i = i + 1 {
        draw_pixel(x + k + i * size, y + l + 2 * size)
      }
    }
  }
}
