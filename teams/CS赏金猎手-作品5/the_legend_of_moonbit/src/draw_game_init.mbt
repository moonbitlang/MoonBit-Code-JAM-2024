pub fn draw_game_init(self : GameStat) -> Unit {
  @wasm4.text("Legend of Moonbit", 10, 10)
  hypotrochoid_line(120, 40, 12, 9, 3, 6, 300, 4)
  fractal_tree(10, 1, "X", 1.0, 35, 2, 2) //小草
  fractal_tree(30, 1, "X", 2.0, 32, 5U, 2) //大树
  fractal_tree(80, 1, "X", 2.0, 36, 4U, 2) // 中等树
  fractal_tree(88, 1, "X", 2.0, 35, 2, 2) //大草
  fractal_tree(121, 1, "X", 1.0, 38, 2, 2) //小草
  fractal_tree(130, 1, "X", 3.0, 28, 3U, 2) // 小树
  fractal_tree(150, 1, "X", 2.0, 24, 5U, 2)
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
