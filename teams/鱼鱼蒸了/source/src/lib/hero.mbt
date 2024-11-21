pub fn hero_body(x : Int, y : Int, ~size : Int = 1) -> Unit {
  @wasm.set_draw_colors(4, index=2)
  for i = 0; i < 1 * size; i = i + 1 {
    for j = 0; j < 1 * size; j = j + 1 {

      // 头发
      draw_pixel(x + i + 2 * size, y + j)
      draw_pixel(x + i + 3 * size, y + j)
      draw_pixel(x + i + 1 * size, y + j + 1 * size)
      draw_pixel(x + i + 1 * size, y + j + 2 * size)
      draw_pixel(x + i + 1 * size, y + j + 3 * size)
      draw_pixel(x + i + 2 * size, y + j + 2 * size)
      draw_pixel(x + i + 2 * size, y + j + 3 * size)

      // 帽子和眼睛
      draw_pixel(x + i + 5 * size, y + j)
      draw_pixel(x + i + 2 * size, y + j + 5 * size)
      draw_pixel(x + i + 3 * size, y + j + 5 * size)
      draw_pixel(x + i + 4 * size, y + j + 5 * size)
      draw_pixel(x + i + 5 * size, y + j + 5 * size)
      draw_pixel(x + i, y + j + 7 * size)
      draw_pixel(x + i + 1 * size, y + j + 6 * size)
      draw_pixel(x + i + 1 * size, y + j + 7 * size)
      draw_pixel(x + i + 4 * size, y + j + 2 * size)
      draw_pixel(x + i + 6 * size, y + j + 2 * size)

      // 脚和剑
      draw_pixel(x + i + 1 * size, y + j + 8 * size)
      draw_pixel(x + i + 2 * size, y + j + 8 * size)
      draw_pixel(x + i + 5 * size, y + j + 8 * size)
      draw_pixel(x + i + 6 * size, y + j + 8 * size)
    }
  }
  @wasm.set_draw_colors(2, index=2)
  for i = 0; i < 1 * size; i = i + 1 {
    for j = 0; j < 1 * size; j = j + 1 {
      draw_pixel(x + i, y + j + 4 * size)
      draw_pixel(x + i, y + j + 5 * size)
      draw_pixel(x + i + 2 * size, y + j + 4 * size)
      draw_pixel(x + i + 3 * size, y + j + 2 * size)
      draw_pixel(x + i + 3 * size, y + j + 3 * size)
      draw_pixel(x + i + 3 * size, y + j + 4 * size)
      draw_pixel(x + i + 4 * size, y + j + 3 * size)
      draw_pixel(x + i + 5 * size, y + j + 2 * size)
      draw_pixel(x + i + 5 * size, y + j + 3 * size)
      draw_pixel(x + i + 5 * size, y + j + 4 * size)
      draw_pixel(x + i + 7 * size, y + j + 5 * size)
      draw_pixel(x + i + 8 * size, y + j + 5 * size)
      draw_pixel(x + i + 1 * size, y + j + 8 * size)
      draw_pixel(x + i + 2 * size, y + j + 8 * size)
      draw_pixel(x + i + 5 * size, y + j + 8 * size)
      draw_pixel(x + i + 6 * size, y + j + 8 * size)
    }
  }
  @wasm.set_draw_colors(3, index=2)
  for i = 0; i < 1 * size; i = i + 1 {
    for j = 0; j < 1 * size; j = j + 1 {

      // 头盔和剑其他部分
      draw_pixel(x + i + 4 * size, y + j)
      draw_pixel(x + i + 2 * size, y + j + 1 * size)
      draw_pixel(x + i + 3 * size, y + j + 1 * size)
      draw_pixel(x + i + 4 * size, y + j + 1 * size)
      draw_pixel(x + i + 5 * size, y + j + 1 * size)

      // 衣服
      draw_pixel(x + i + 1 * size, y + j + 5 * size)
      draw_pixel(x + i + 2 * size, y + j + 6 * size)
      draw_pixel(x + i + 2 * size, y + j + 7 * size)
      draw_pixel(x + i + 3 * size, y + j + 6 * size)
      draw_pixel(x + i + 3 * size, y + j + 7 * size)
      draw_pixel(x + i + 4 * size, y + j + 6 * size)
      draw_pixel(x + i + 4 * size, y + j + 7 * size)
      draw_pixel(x + i + 5 * size, y + j + 6 * size)
      draw_pixel(x + i + 5 * size, y + j + 7 * size)
      draw_pixel(x + i + 6 * size, y + j + 5 * size)
    }
  }
}

pub fn hero_sword(x : Int, y : Int, ~size : Int = 1) -> Unit {
  @wasm.set_draw_colors(4, index=2)
  for i = 0; i < 1 * size; i = i + 1 {
    for j = 0; j < 1 * size; j = j + 1 {
      draw_pixel(x + i + 7 * size, y + j + 4 * size)
      draw_pixel(x + i + 8 * size, y + j + 4 * size)
      draw_pixel(x + i + 9 * size, y + j + 4 * size)
    }
  }
  @wasm.set_draw_colors(3, index=2)
  for i = 0; i < 1 * size; i = i + 1 {
    for j = 0; j < 1 * size; j = j + 1 {
      draw_pixel(x + i + 8 * size, y + j)
      draw_pixel(x + i + 8 * size, y + j + 1 * size)
      draw_pixel(x + i + 8 * size, y + j + 2 * size)
      draw_pixel(x + i + 8 * size, y + j + 3 * size)
      draw_pixel(x + i + 8 * size, y + j + 6 * size)
    }
  }
}

pub fn sword_1(x : Int, y : Int, ~size : Int = 1) -> Unit {
  @wasm.set_draw_colors(3, index=2)
  for i = 0; i < 1 * size; i = i + 1 {
    for j = 0; j < 1 * size; j = j + 1 {
      for k = 0; k < 4; k = k + 1 {
        draw_pixel(x + i + 8 * size, y + j + k * size)
      }
      for k = 6; k < 11; k = k + 1 {
        draw_pixel(x + i + k * size, y + j - 2 * size)
      }
      for k = 9; k < 12; k = k + 1 {
        for l = 0; l < 2; l = l + 1 {
          draw_pixel(x + i + k * size, y + j - l * size)
          draw_pixel(x + i + @math.minimum(k, 10) * size, y + j + 1 * size)
        }
      }
      draw_pixel(x + i + 7 * size, y + j + 4 * size)
      draw_pixel(x + i + 7 * size, y + j - 1 * size)
      draw_pixel(x + i + 9 * size, y + j + 2 * size)
    }
  }
}

pub fn sword_2(x : Int, y : Int, ~size : Int = 1) -> Unit {
  @wasm.set_draw_colors(4, index=2)
  for i = 0; i < 1 * size; i = i + 1 {
    for j = 0; j < 1 * size; j = j + 1 {
      draw_pixel(x + i + 9 * size, y + j + 4 * size)
      draw_pixel(x + i + 9 * size, y + j + 6 * size)
    }
  }
  @wasm.set_draw_colors(3, index=2)
  for i = 0; i < 1 * size; i = i + 1 {
    for j = 0; j < 1 * size; j = j + 1 {
      draw_pixel(x + i + 9 * size, y + j + 5 * size)
      for k = 10; k < 17; k = k + 1 {
        for l = 5; l < 7; l = l + 1 {
          draw_pixel(x + i + k * size, y + j + l * size)
        }
      }
      for k = 12; k < 16; k = k + 1 {
        draw_pixel(x + i + k * size, y + j + 7 * size)
      }
      for k = 12; k < 15; k = k + 1 {
        draw_pixel(x + i + k * size, y + j + 3 * size)
      }
      // 
      draw_pixel(x + i + 11 * size, y + j + 4 * size)
      draw_pixel(x + i + 12 * size, y + j + 4 * size)
      draw_pixel(x + i + 13 * size, y + j + 2 * size)
      draw_pixel(x + i + 14 * size, y + j + 4 * size)
      for k = 16; k < 18; k = k + 1 {
        for l = 2; l < 6; l = l + 1 {
          draw_pixel(x + i + k * size, y + j + l * size)
        }
      }
      draw_pixel(x + i + 15 * size, y + j + 2 * size)
      draw_pixel(x + i + 14 * size, y + j + 1 * size)
      draw_pixel(x + i + 15 * size, y + j + 1 * size)
      draw_pixel(x + i + 16 * size, y + j + 1 * size)
      draw_pixel(x + i + 13 * size, y + j)
      draw_pixel(x + i + 14 * size, y + j)
      draw_pixel(x + i + 15 * size, y + j)
      draw_pixel(x + i + 12 * size, y + j - 1 * size)
      draw_pixel(x + i + 13 * size, y + j - 1 * size)
    }
  }
}

pub fn sword_3(x : Int, y : Int, ~size : Int = 1) -> Unit {
  @wasm.set_draw_colors(3, index=2)
  for i = 0; i < 1 * size; i = i + 1 {
    for j = 0; j < 1 * size; j = j + 1 {
      draw_pixel(x + i + 2 * size, y + j + 5 * size)
      draw_pixel(x + i + 8 * size, y + j + 5 * size)
      draw_pixel(x + i + 10 * size, y + j + 5 * size)
      draw_pixel(x + i + 12 * size, y + j + 5 * size)
      draw_pixel(x + i + 14 * size, y + j + 5 * size)
      draw_pixel(x + i + 13 * size, y + j + 4 * size)
      draw_pixel(x + i + 14 * size, y + j + 4 * size)
      draw_pixel(x + i + 15 * size, y + j + 4 * size)
      draw_pixel(x + i + 15 * size, y + j + 3 * size)
      //
      draw_pixel(x + i + 3 * size, y + j + 6 * size)
      draw_pixel(x + i + 4 * size, y + j + 6 * size)
      draw_pixel(x + i + 5 * size, y + j + 6 * size)
      draw_pixel(x + i + 6 * size, y + j + 6 * size)
      draw_pixel(x + i + 7 * size, y + j + 6 * size)
      draw_pixel(x + i + 9 * size, y + j + 6 * size)
      draw_pixel(x + i + 10 * size, y + j + 6 * size)
      draw_pixel(x + i + 11 * size, y + j + 6 * size)
      draw_pixel(x + i + 12 * size, y + j + 6 * size)
      draw_pixel(x + i + 13 * size, y + j + 6 * size)
      draw_pixel(x + i + 5 * size, y + j + 7 * size)
      draw_pixel(x + i + 6 * size, y + j + 7 * size)
      draw_pixel(x + i + 7 * size, y + j + 7 * size)
      draw_pixel(x + i + 8 * size, y + j + 7 * size)
      draw_pixel(x + i + 9 * size, y + j + 7 * size)
    }
  }
}
