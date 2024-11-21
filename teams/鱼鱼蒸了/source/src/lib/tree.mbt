pub let draw_tree : DrawEnemy = fn(x : Int, y : Int, size : Int) -> Unit {
  for k = 0; k < 1 * size; k = k + 1 {
    for l = 0; l < 1 * size; l = l + 1 {
      @wasm.set_draw_colors(2, index=2)
      for i = 2; i < 5; i = i + 1 {
        for j = 1; j < 6; j = j + 1 {
          draw_pixel(x + k + i * size, y + l + j * size)
        }
      }
      draw_pixel(x + k + 1 * size, y + l + 2 * size)
      draw_pixel(x + k + 1 * size, y + l + 4 * size)
      draw_pixel(x + k + 5 * size, y + l + 2 * size)
      draw_pixel(x + k + 5 * size, y + l + 4 * size)
      for i = 0; i < 7; i = i + 1 {
        draw_pixel(x + k + i * size, y + l + 5 * size)
      }
      @wasm.set_draw_colors(3, index=2)
      draw_pixel(x + k + 3 * size, y + l + 6 * size)
      draw_pixel(x + k + 3 * size, y + l + 7 * size)
    }
  }
}
