pub let draw_sheep : DrawEnemy = fn(x : Int, y : Int, size : Int) -> Unit {
  // 羊毛
  @wasm.set_draw_colors(3, index=2)
  for i = 0; i < 10 * size; i = i + 1 {
    for j = 0; j < 6 * size; j = j + 1 {
      draw_pixel(x + i, y + j)
    }
  }
  for i = 10 * size; i < 11 * size; i = i + 1 {
    for j = 2 * size; j < 3 * size; j = j + 1 {
      draw_pixel(x + i, y + j)
    }
  }
  for i = 11 * size; i < 12 * size; i = i + 1 {
    for j = 2 * size; j < 5 * size; j = j + 1 {
      draw_pixel(x + i, y + j)
    }
  }

  //去掉羊毛
  @wasm.set_draw_colors(1, index=2)
  for i = 0; i < 1 * size; i = i + 1 {
    for j = 0; j < 1 * size; j = j + 1 {
      draw_pixel(x + i, y + j)
      draw_pixel(x + i, y + 5 * size + j)
      draw_pixel(x + 9 * size + i, y + j)
      draw_pixel(x + 9 * size + i, y + 5 * size + j)
    }
  }

  // 脸耳朵和脚
  @wasm.set_draw_colors(4, index=2)
  for i = 0; i < 1 * size; i = i + 1 {
    for j = 0; j < 1 * size; j = j + 1 {
      draw_pixel(x + i, y + j + 1 * size)
      draw_pixel(x + i + 4 * size, y + j + 1 * size)
      draw_pixel(x + i + 5 * size, y + j + 1 * size)
      draw_pixel(x + i + 3 * size, y + j + 6 * size)
      draw_pixel(x + i + 7 * size, y + j + 6 * size)
      for k = 1 * size; k < 4 * size; k = k + 1 {
        draw_pixel(x + i + k, y + j + 2 * size)
        draw_pixel(x + i + k, y + j + 3 * size)
        draw_pixel(x + i + k, y + j + 4 * size)
      }
    }
  }

  // 眼睛
  @wasm.set_draw_colors(2, index=2)
  for i = 0; i < 1 * size; i = i + 1 {
    for j = 0; j < 1 * size; j = j + 1 {
      draw_pixel(x + 1 * size + i, y + 3 * size + j)
      draw_pixel(x + 3 * size + i, y + 3 * size + j)
    }
  }
}
