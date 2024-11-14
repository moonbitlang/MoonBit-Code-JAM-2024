pub let draw_pumpkin : DrawEnemy = fn(x : Int, y : Int, size : Int) -> Unit {

  // 条纹框框  
  @wasm.set_draw_colors(2, index=2)
  for i = 1 * size; i < 6 * size; i = i + 1 {
    for j = 0; j < 1 * size; j = j + 1 {
      draw_pixel(x + j + 2 * size, y + i)
      draw_pixel(x + j + 4 * size, y + i)
      draw_pixel(x + j + 6 * size, y + i)
    }
  }
  for i = 0; i < 1 * size; i = i + 1 {
    for j = 0; j < 1 * size; j = j + 1 {
      draw_pixel(x + j, y + 6 * size + i)
      draw_pixel(x + j + 8 * size, y + 4 * size + i)
    }
  }
  @wasm.set_draw_colors(3, index=2)
  for i = 1 * size; i < 6 * size; i = i + 1 {
    for j = 0; j < 1 * size; j = j + 1 {
      draw_pixel(x + j + 3 * size, y + i)
      draw_pixel(x + j + 5 * size, y + i)
    }
  }
  for i = 0; i < 1 * size; i = i + 1 {
    for j = 0; j < 1 * size; j = j + 1 {
      draw_pixel(x + 2 * size + i, y + 9 * size + j)
      draw_pixel(x + 3 * size + i, y + 9 * size + j)
      draw_pixel(x + 6 * size + i, y + 9 * size + j)
      draw_pixel(x + 7 * size + i, y + 9 * size + j)
    }
  }

  // 眼睛和头发(?)
  @wasm.set_draw_colors(4, index=2)
  for i = 0; i < 1 * size; i = i + 1 {
    for j = 0; j < 1 * size; j = j + 1 {
      draw_pixel(x + i + 4 * size, y + j)
      draw_pixel(x + i + 4 * size, y + j + 2 * size)
      draw_pixel(x + i + 2 * size, y + j + 2 * size)
      draw_pixel(x + i + 4 * size, y + j + 4 * size)
      draw_pixel(x + i + 3 * size, y + j + 4 * size)

      // 衣服
      draw_pixel(x + i + 1 * size, y + j + 6 * size)
      draw_pixel(x + i + 2 * size, y + j + 6 * size)
      for k = 3; k < 7; k = k + 1 {
        for v = 6; v < 9; v = v + 1 {
          draw_pixel(x + i + k * size, y + j + v * size)
        }
      }
      draw_pixel(x + i + 7 * size, y + j + 6 * size)
      draw_pixel(x + i + 8 * size, y + j + 5 * size)
      draw_pixel(x + i + 8 * size, y + j + 6 * size)
    }
  }
}
