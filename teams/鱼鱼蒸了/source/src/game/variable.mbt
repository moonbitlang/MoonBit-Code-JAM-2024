let battleStatus = ["attack", "defense", "heal"]

let default_anime : Anime = fn(self, sk) {  }

let sed : Array[Bytes] = [
  b"11111111111111111111111111111111", b"22222222222222222222222222222222", b"33333333333333333333333333333333",
  b"CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC", b"99999999999999999999999999999999", b"MBTMBTMBTMBTMBTMBTMBTMBTMBTMBTMB",
  b"MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM", b"88888888888888888888888888888888", b"66666666666666666666666666666666",
]

fn critical(x : Int) -> Int {
  let r = @random.new(seed=sed[game.g_time % 9])
  game.rng = r.int(limit=101)
  if x >= game.rng {
    return 2
  }
  game.rng = r.int(limit=101) + r.int(limit=101) + 1
  return 1
}

fn two_color(x : UInt, y : UInt) -> Unit {
  @wasm.set_draw_colors(x, index=1)
  @wasm.set_draw_colors(y, index=2)
}
