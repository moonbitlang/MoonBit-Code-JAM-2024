pub fn bug(self : GameStat) -> Unit {
  let bugs_bytes2 : Bytes = Bytes::from_array(player)
  @wasm4.blit(
    @wasm4.sprite(bugs_bytes2),
    self.bug_x,
    self.bug_y,
    8,
    9,
    @wasm4.BlitFlag::{
      one_bit_per_pixel: false,
      rotate: false,
      flip_x: false,
      flip_y: false,
    },
  )
}
