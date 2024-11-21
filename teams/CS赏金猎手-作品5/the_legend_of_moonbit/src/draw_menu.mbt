pub fn draw_menu(self : GameStat) -> Unit {
  match self.game_state {
    GSInitMenu => {
      @wasm4.text("Start", 60, 60)
      // @wasm4.text("About", 60, 80)
      @wasm4.text(">", 50, 60)
    }
  }
}
