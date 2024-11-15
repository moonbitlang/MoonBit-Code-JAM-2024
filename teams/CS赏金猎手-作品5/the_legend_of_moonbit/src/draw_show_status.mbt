pub fn show_status(self : GameStat) -> Unit {
  if self.show_args_bar {
    @wasm4.text("DAY ", 1, 5)
    @wasm4.text(self.lv.to_string(), 25, 5)
    @wasm4.text("HP ", 45, 5)
    @wasm4.text(self.hp.to_string(), 65, 5)
    @wasm4.text("Mem", 90, 5)
    @wasm4.text(self.memory.to_string(), 120, 5)
  }
}
