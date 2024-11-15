pub fn draw_background(self : GameStat) -> Unit {
  if self.night {
    hypotrochoid_line(120, 40, 12, 9, 3, 6, 300, 4)
    @wasm4.set_palette(4, @wasm4.rgb(0xf9a875)) // 沙粽
    @wasm4.set_palette(1, @wasm4.rgb(0xaa337f)) // 陈玫红 Maximum Red Purple
    @wasm4.set_palette(2, @wasm4.rgb(0xC75B7A)) // 暗岩灰
    @wasm4.set_palette(3, @wasm4.rgb(0xD9ABAB)) // 绿
  } else {
    hypotrochoid_line(120, 40, 12, 13, 9, 19, 300, 4)
    @wasm4.set_palette(4, @wasm4.rgb(0xf9a875)) // 沙粽
    @wasm4.set_palette(2, @wasm4.rgb(0xaa337f)) // 陈玫红 Maximum Red Purple
    @wasm4.set_palette(1, @wasm4.rgb(0xC75B7A)) // 暗岩灰
    @wasm4.set_palette(3, @wasm4.rgb(0xD9ABAB)) // 绿
  }
  if self.lv == 1 {
    fractal_tree(10, 1, "X", 1.0, 35, 2, 2) //小草
    fractal_tree(30, 1, "X", 2.0, 32, 5U, 2) //大树
    fractal_tree(80, 1, "X", 2.0, 36, 4U, 2) // 中等树
    fractal_tree(88, 1, "X", 2.0, 35, 2, 2) //大草
    fractal_tree(121, 1, "X", 1.0, 38, 2, 2) //小草
    fractal_tree(130, 1, "X", 3.0, 28, 3U, 2) // 小树
    fractal_tree(150, 1, "X", 2.0, 24, 5U, 2)
  } else {
    if not(self.lock) {
      self.tx1 = (self.rng.uint(limit=120) + 10).reinterpret_as_int()
      self.tx2 = (self.rng.uint(limit=120) + 10).reinterpret_as_int()
      self.tx3 = (self.rng.uint(limit=120) + 10).reinterpret_as_int()
      self.tx4 = (self.rng.uint(limit=120) + 10).reinterpret_as_int()
      self.tx5 = (self.rng.uint(limit=120) + 10).reinterpret_as_int()
      self.tx6 = (self.rng.uint(limit=120) + 10).reinterpret_as_int()
      self.tx7 = (self.rng.uint(limit=120) + 10).reinterpret_as_int()
      self.tx8 = (self.rng.uint(limit=120) + 10).reinterpret_as_int()
      self.txa1 = (self.rng.uint(limit=28) + 10).reinterpret_as_int()
      self.txa2 = (self.rng.uint(limit=28) + 10).reinterpret_as_int()
      self.txa3 = (self.rng.uint(limit=28) + 10).reinterpret_as_int()
      self.lock = true
    }
    fractal_tree(self.tx1, 1, "X", 2.0, self.txa1.to_double(), 5U, 2)
    fractal_tree(self.tx2, 1, "X", 2.0, self.txa2.to_double(), 5U, 2)
    fractal_tree(self.tx3, 1, "X", 2.0, self.txa3.to_double(), 4, 2)
    fractal_tree(self.tx4, 1, "X", 2.0, self.txa1.to_double(), 4, 2)
    fractal_tree(self.tx6, 1, "X", 3.0, self.txa2.to_double(), 3, 2)
    fractal_tree(self.tx7, 1, "X", 1.0, self.txa3.to_double(), 2, 2)
    fractal_tree(self.tx8, 1, "X", 1.0, self.txa1.to_double(), 2, 2)
    fractal_tree(self.tx5, 1, "X", 2.0, self.txa2.to_double(), 2, 2)
  }
  let player_bytes2 : Bytes = Bytes::from_array(x1)
  @wasm4.blit(
    @wasm4.sprite(player_bytes2),
    self.player_x,
    self.player_y,
    16,
    16,
    @wasm4.BlitFlag::{
      one_bit_per_pixel: false,
      rotate: self.player_rotate,
      flip_x: self.player_flip_x,
      flip_y: false,
    },
  )
}
