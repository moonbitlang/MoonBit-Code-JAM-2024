pub fn info() -> Unit {
  @wasm.text(game.scene.to_string(), 20, 20)
  @wasm.text(game.r_time.to_string(), 20, 20)
}
