```
const ttWidth = 36;
const ttHeight = 52;
const ttFlags = 1; // BLIT_2BPP
const tt = memory.data<u8>([ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x10,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x10,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x50,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x01,0xa9,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x01,0xa9,0x40,0x00,0x00,0x00,0x00,0x00,0x00,0x01,0xa9,0x40,0x00,0x00,0x00,0x00,0x00,0x00,0x01,0xa9,0x40,0x00,0x00,0x00,0x00,0x00,0x00,0x77,0x77,0x74,0x00,0x00,0x00,0x00,0x00,0x00,0xff,0xff,0xfc,0x00,0x00,0x00,0x00,0x00,0x00,0x7f,0xff,0xf4,0x00,0x00,0x00,0x00,0x00,0x00,0x2a,0xaa,0xa0,0x00,0x00,0x00,0x00,0x00,0x00,0x0f,0xff,0x80,0x00,0x00,0x00,0x00,0x00,0x10,0x0f,0xdf,0x80,0x01,0x00,0x00,0x00,0x00,0x10,0x0f,0xdf,0x80,0x01,0x00,0x00,0x00,0x00,0x10,0x0f,0xdf,0x80,0x01,0x00,0x00,0x00,0x00,0x10,0x07,0x77,0x40,0x01,0x00,0x00,0x00,0x00,0x54,0x0f,0xff,0xe0,0x05,0x40,0x00,0x00,0x01,0xa9,0x0f,0xff,0xe0,0x1a,0x90,0x00,0x00,0x06,0xaa,0x43,0xff,0xe0,0x6a,0xa4,0x00,0x00,0x07,0xfe,0x42,0xaa,0xa0,0x6a,0xa4,0x00,0x00,0x07,0xfe,0x43,0xff,0x80,0x7f,0xe4,0x00,0x00,0x03,0xde,0x03,0xff,0x80,0x7f,0xe4,0x00,0x00,0x03,0xde,0x03,0xff,0x80,0x7f,0xe4,0x00,0x00,0x03,0xfe,0x03,0xff,0x80,0x3d,0xa0,0x00,0x00,0x03,0xfe,0x03,0xff,0x80,0x3d,0xa0,0x00,0x00,0x03,0xfe,0x0f,0xff,0x80,0x3f,0xe0,0x00,0x00,0x03,0xfe,0x0f,0xff,0x80,0x3f,0xe0,0x00,0x00,0x03,0xfe,0x0f,0xff,0x80,0x3f,0xe4,0x00,0x00,0x07,0xfe,0x0f,0xff,0x80,0xff,0xe4,0x00,0x00,0x07,0xfe,0x0f,0xff,0x80,0xff,0xe4,0x00,0x00,0x07,0xfe,0x0f,0xff,0x80,0xff,0xe4,0x00,0x00,0x07,0xfe,0x0f,0xff,0x80,0x15,0x7d,0x54,0x1d,0x5d,0xf5,0x0f,0xff,0x80,0x1f,0xff,0xd4,0x1f,0xfd,0xd5,0x0f,0xff,0x80,0xbf,0xff,0xa4,0x1f,0xfe,0x96,0x0f,0xff,0x80,0xbf,0xff,0xa4,0x1f,0xfe,0x96,0xff,0xff,0x80,0xbf,0xff,0xf4,0x1f,0xff,0xd7,0xfd,0xdd,0xff,0xff,0xff,0xf4,0x1f,0xaa,0xbf,0xfd,0xdd,0xff,0xff,0xef,0xf4,0x07,0xfa,0xbf,0xff,0xff,0xff,0xff,0xfe,0xa0,0x07,0xfe,0xbf,0xff,0xff,0xff,0xd5,0xff,0xa0,0x07,0xfe,0xbf,0x5f,0xff,0xff,0xd5,0xff,0xd0,0x07,0xfe,0xbf,0x5f,0xff,0xff,0xd5,0xff,0xd0,0x07,0xfe,0xbf,0x5f,0xff,0xff,0xd5,0xff,0xd0,0x07,0xfe,0xbf,0xff,0xd5,0xff,0xff,0xff,0xd0,0x07,0xfe,0xbf,0xff,0xd5,0xff,0xff,0xff,0xd0,0x07,0xfe,0xbf,0xff,0x6a,0x7f,0xff,0xff,0xd0,0x07,0xfe,0xbf,0xff,0x6a,0x7f,0xff,0xff,0xd0,0x06,0xaa,0xbf,0xff,0x6a,0x7f,0xff,0xff,0xd0,0x0a,0xaa,0xaa,0xaa,0x6a,0x55,0x55,0x55,0x50,0x0a,0xaa,0xaa,0xaa,0x55,0x6a,0xaa,0xaa,0xa0,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00 ]);
```

```mbt
// 旧的绘制城堡代码

fn draw_castle(x : Int, y : Int, ~size : Int = 2) -> Unit {

  // 主要颜色
  @wasm.set_draw_colors(2, index=2)
  for i = 0; i < 1 * size; i = i + 1 {
    for j = 0; j < 1 * size; j = j + 1 {
      // 底部
      for k = 1; k < 33; k = k + 1 {
        for l = 32; l < 48; l = l + 1 {
          @lib.draw_pixel(x + i + k * size, y + j + l * size)
        }
      }

      // 左侧
      for k = 6; k < 10; k = k + 1 {
        for l = 19; l < 32; l = l + 1 {
          @lib.draw_pixel(x + i + k * size, y + j + l * size)
        }
      }

      // 中间
      for k = 13; k < 20; k = k + 1 {
        for l = 11; l < 32; l = l + 1 {
          @lib.draw_pixel(x + i + k * size, y + j + l * size)
        }
      }

      // 右侧
      for k = 23; k < 28; k = k + 1 {
        for l = 20; l < 31; l = l + 1 {
          @lib.draw_pixel(x + i + k * size, y + j + l * size)
        }
      }
      @lib.draw_pixel(x + i + 28 * size, y + j + 31 * size)
      @lib.draw_pixel(x + i + 29 * size, y + j + 31 * size)
      // 顶部
      for k = 11; k < 22; k = k + 1 {
        for l = 7; l < 10; l = l + 1 {
          @lib.draw_pixel(x + i + k * size, y + j + l * size)
        }
      }
    }
  }

  // 空掉部分 
  @wasm.set_draw_colors(1, index=2)
  for i = 0; i < 1 * size; i = i + 1 {
    for j = 0; j < 1 * size; j = j + 1 {
      for k = 11; k < 13; k = k + 1 {
        for l = 32; l < 35; l = l + 1 {
          @lib.draw_pixel(x + i + k * size, y + j + l * size)
        }
      }
      for k = 20; k < 23; k = k + 1 {
        for l = 32; l < 36; l = l + 1 {
          @lib.draw_pixel(x + i + k * size, y + j + l * size)
        }
      }
      for l = 23; l < 33; l = l + 1 {
        if l > 27 && l < 31 {
          continue
        }
        @lib.draw_pixel(x + i + 23 * size, y + j + l * size)
      }
      //
      for l = 18; l < 25; l = l + 1 {
        @lib.draw_pixel(x + i + 13 * size, y + j + l * size)
      }
    }
  }
  // 其他点缀
  @wasm.set_draw_colors(3, index=2)
  for i = 0; i < 1 * size; i = i + 1 {
    for j = 0; j < 1 * size; j = j + 1 {
      // 左塔
      for k = 7; k < 10; k = k + 1 {
        @lib.draw_pixel(x + i + k * size, y + j + 17 * size)
      }
      for k = 6; k < 11; k = k + 1 {
        @lib.draw_pixel(x + i + k * size, y + j + 18 * size)
        @lib.draw_pixel(x + i + k * size, y + j + 34 * size)
        @lib.draw_pixel(x + i + k * size, y + j + 35 * size)
      }
      for k = 18; k < 36; k = k + 1 {
        @lib.draw_pixel(x + i + 10 * size, y + j + k * size)
      }
      // 中塔
      for k = 15; k < 18; k = k + 1 {
        for l = 3; l < 7; l = l + 1 {
          @lib.draw_pixel(x + i + k * size, y + j + l * size)
        }
      }
      for k = 12; k < 21; k = k + 1 {
        @lib.draw_pixel(x + i + k * size, y + j + 10 * size)
        @lib.draw_pixel(x + i + @math.maximum(14, k) * size, y + j + 19 * size)
      }
      for k = 10; k < 15; k = k + 1 {
        @lib.draw_pixel(x + i + 19 * size, y + j + k * size)
      }
      for k = 16; k < 20; k = k + 1 {
        @lib.draw_pixel(x + i + 20 * size, y + j + k * size)
      }
      for k = 19; k < 35; k = k + 1 {
        @lib.draw_pixel(x + i + 19 * size, y + j + k * size)
      }

      // 右塔
      for k = 25; k < 28; k = k + 1 {
        @lib.draw_pixel(x + i + k * size, y + j + 17 * size)
      }
      for k = 24; k < 29; k = k + 1 {
        @lib.draw_pixel(x + i + k * size, y + j + 18 * size)
        @lib.draw_pixel(x + i + k * size, y + j + 19 * size)
      }
      for k = 30; k < 33; k = k + 1 {
        @lib.draw_pixel(x + i + k * size, y + j + 38 * size)
        @lib.draw_pixel(x + i + k * size, y + j + 39 * size)
      }
      for k = 18; k < 31; k = k + 1 {
        @lib.draw_pixel(x + i + 28 * size, y + j + k * size)
      }
      for k = 33; k < 35; k = k + 1 {
        @lib.draw_pixel(x + i + 23 * size, y + j + k * size)
        @lib.draw_pixel(x + i + 31 * size, y + j + k * size)
        @lib.draw_pixel(x + i + 32 * size, y + j + k * size)
      }
      @lib.draw_pixel(x + i + 28 * size, y + j + 37 * size)

      // 底侧
      for k = 3; k < 8; k = k + 1 {
        @lib.draw_pixel(x + i + k * size, y + j + 37 * size)
      }
      @lib.draw_pixel(x + i + 5 * size, y + j + 38 * size)
      for k = 2; k < 8; k = k + 1 {
        @lib.draw_pixel(x + i + k * size, y + j + 47 * size)
      }
      for k = 1; k < 15; k = k + 1 {
        @lib.draw_pixel(x + i + k * size, y + j + 48 * size)
        @lib.draw_pixel(x + i + k * size, y + j + 49 * size)
      }
      for k = 20; k < 33; k = k + 1 {
        @lib.draw_pixel(x + i + k * size, y + j + 49 * size)
      }
      for k = 37; k < 49; k = k + 1 {
        @lib.draw_pixel(x + i + 6 * size, y + j + k * size)
        @lib.draw_pixel(x + i + 7 * size, y + j + k * size)
      }
      for k = 45; k < 49; k = k + 1 {
        @lib.draw_pixel(x + i + 16 * size, y + j + k * size)
        @lib.draw_pixel(x + i + 17 * size, y + j + k * size)
        @lib.draw_pixel(x + i + 18 * size, y + j + k * size)
      }
    }
  }
  // 边框部分
  @wasm.set_draw_colors(4, index=2)
  for i = 0; i < 1 * size; i = i + 1 {
    for j = 0; j < 1 * size; j = j + 1 {
      // 主塔尖
      @lib.draw_pixel(x + i + 16 * size, y + j + 0 * size)
      @lib.draw_pixel(x + i + 16 * size, y + j + 1 * size)
      @lib.draw_pixel(x + i + 16 * size, y + j + 2 * size)
      @lib.draw_pixel(x + i + 15 * size, y + j + 2 * size)
      @lib.draw_pixel(x + i + 14 * size, y + j + 3 * size)
      @lib.draw_pixel(x + i + 14 * size, y + j + 4 * size)
      @lib.draw_pixel(x + i + 14 * size, y + j + 5 * size)
      @lib.draw_pixel(x + i + 14 * size, y + j + 6 * size)
      @lib.draw_pixel(x + i + 18 * size, y + j + 3 * size)
      @lib.draw_pixel(x + i + 18 * size, y + j + 4 * size)
      @lib.draw_pixel(x + i + 18 * size, y + j + 5 * size)
      @lib.draw_pixel(x + i + 18 * size, y + j + 6 * size)
      @lib.draw_pixel(x + i + 19 * size, y + j + 4 * size)
      @lib.draw_pixel(x + i + 19 * size, y + j + 5 * size)
      @lib.draw_pixel(x + i + 19 * size, y + j + 6 * size)

      // 装饰
      @lib.draw_pixel(x + i + 11 * size, y + j + 7 * size)
      @lib.draw_pixel(x + i + 13 * size, y + j + 7 * size)
      @lib.draw_pixel(x + i + 15 * size, y + j + 7 * size)
      @lib.draw_pixel(x + i + 17 * size, y + j + 7 * size)
      @lib.draw_pixel(x + i + 19 * size, y + j + 7 * size)
      @lib.draw_pixel(x + i + 21 * size, y + j + 7 * size)
      @lib.draw_pixel(x + i + 11 * size, y + j + 9 * size)
      @lib.draw_pixel(x + i + 21 * size, y + j + 9 * size)
      @lib.draw_pixel(x + i + 16 * size, y + j + 12 * size)
      @lib.draw_pixel(x + i + 16 * size, y + j + 13 * size)
      @lib.draw_pixel(x + i + 16 * size, y + j + 14 * size)
      @lib.draw_pixel(x + i + 13 * size, y + j + 15 * size)
      @lib.draw_pixel(x + i + 15 * size, y + j + 15 * size)
      @lib.draw_pixel(x + i + 17 * size, y + j + 15 * size)
      @lib.draw_pixel(x + i + 19 * size, y + j + 15 * size)

      // 左塔尖
      @lib.draw_pixel(x + i + 8 * size, y + j + 12 * size)
      @lib.draw_pixel(x + i + 8 * size, y + j + 13 * size)
      @lib.draw_pixel(x + i + 8 * size, y + j + 14 * size)
      @lib.draw_pixel(x + i + 8 * size, y + j + 15 * size)
      @lib.draw_pixel(x + i + 8 * size, y + j + 16 * size)
      @lib.draw_pixel(x + i + 9 * size, y + j + 16 * size)
      @lib.draw_pixel(x + i + 7 * size, y + j + 16 * size)
      @lib.draw_pixel(x + i + 10 * size, y + j + 17 * size)
      @lib.draw_pixel(x + i + 6 * size, y + j + 17 * size)
      @lib.draw_pixel(x + i + 11 * size, y + j + 18 * size)
      @lib.draw_pixel(x + i + 11 * size, y + j + 19 * size)
      @lib.draw_pixel(x + i + 11 * size, y + j + 20 * size)
      @lib.draw_pixel(x + i + 5 * size, y + j + 18 * size)
      @lib.draw_pixel(x + i + 5 * size, y + j + 19 * size)
      @lib.draw_pixel(x + i + 5 * size, y + j + 20 * size)
      @lib.draw_pixel(x + i + 8 * size, y + j + 21 * size)
      @lib.draw_pixel(x + i + 8 * size, y + j + 22 * size)

      //右塔尖
      @lib.draw_pixel(x + i + 26 * size, y + j + 12 * size)
      @lib.draw_pixel(x + i + 26 * size, y + j + 13 * size)
      @lib.draw_pixel(x + i + 26 * size, y + j + 14 * size)
      @lib.draw_pixel(x + i + 26 * size, y + j + 15 * size)
      @lib.draw_pixel(x + i + 26 * size, y + j + 16 * size)
      @lib.draw_pixel(x + i + 27 * size, y + j + 16 * size)
      @lib.draw_pixel(x + i + 25 * size, y + j + 16 * size)
      @lib.draw_pixel(x + i + 28 * size, y + j + 17 * size)
      @lib.draw_pixel(x + i + 24 * size, y + j + 17 * size)
      for k = 18; k < 23; k = k + 1 {
        @lib.draw_pixel(x + i + 23 * size, y + j + k * size)
        @lib.draw_pixel(x + i + 29 * size, y + j + k * size)
      }
      for k = 18; k < 23; k = k + 1 {
        @lib.draw_pixel(x + i + 23 * size, y + j + k * size)
      }
      @lib.draw_pixel(x + i + 26 * size, y + j + 23 * size)
      @lib.draw_pixel(x + i + 26 * size, y + j + 24 * size)

      // 左外墙
      for k = 32; k < 38; k = k + 1 {
        @lib.draw_pixel(x + i + 0 * size, y + j + k * size)
      }
      for k = 38; k < 48; k = k + 1 {
        @lib.draw_pixel(x + i + 1 * size, y + j + k * size)
      }
      for k = 28; k < 32; k = k + 1 {
        @lib.draw_pixel(x + i + 5 * size, y + j + k * size)
      }
      for k = 32; k < 34; k = k + 1 {
        @lib.draw_pixel(x + i + 6 * size, y + j + k * size)
        @lib.draw_pixel(x + i + 10 * size, y + j + k * size)
      }
      for k = 33; k < 37; k = k + 1 {
        @lib.draw_pixel(x + i + 8 * size, y + j + k * size)
        @lib.draw_pixel(x + i + 9 * size, y + j + k * size)
      }

      // 右外墙
      @lib.draw_pixel(x + i + 24 * size, y + j + 32 * size)
      for k = 24; k < 28; k = k + 1 {
        @lib.draw_pixel(x + i + k * size, y + j + 31 * size)
      }
      for k = 27; k < 31; k = k + 1 {
        @lib.draw_pixel(x + i + 29 * size, y + j + k * size)
      }
      for k = 30; k < 34; k = k + 1 {
        @lib.draw_pixel(x + i + k * size, y + j + 31 * size)
        @lib.draw_pixel(x + i + @math.maximum(32, k) * size, y + j + 32 * size)
      }
      for k = 33; k < 38; k = k + 1 {
        @lib.draw_pixel(x + i + 33 * size, y + j + k * size)
      }
      for k = 40; k < 49; k = k + 1 {
        @lib.draw_pixel(x + i + 32 * size, y + j + k * size)
      }

      // 門/窗/其他
      for k = 11; k < 13; k = k + 1 {
        for l = 40; l < 43; l = l + 1 {
          @lib.draw_pixel(x + i + k * size, y + j + l * size)
        }
      }
      for k = 24; k < 27; k = k + 1 {
        for l = 39; l < 43; l = l + 1 {
          @lib.draw_pixel(x + i + k * size, y + j + l * size)
        }
      }
      for k = 36; k < 38; k = k + 1 {
        @lib.draw_pixel(x + i + 14 * size, y + j + k * size)
        @lib.draw_pixel(x + i + 16 * size, y + j + k * size)
        @lib.draw_pixel(x + i + 18 * size, y + j + k * size)
      }
      for k = 16; k < 19; k = k + 1 {
        for l = 43; l < 45; l = l + 1 {
          @lib.draw_pixel(x + i + k * size, y + j + l * size)
        }
      }
      for k = 45; k < 49; k = k + 1 {
        @lib.draw_pixel(x + i + 15 * size, y + j + k * size)
        @lib.draw_pixel(x + i + 19 * size, y + j + k * size)
      }
      for k = 15; k < 20; k = k + 1 {
        @lib.draw_pixel(x + i + k * size, y + j + 49 * size)
      }
      for k = 19; k < 33; k = k + 1 {
        @lib.draw_pixel(x + i + k * size, y + j + 48 * size)
      }
    }
  }
}
```