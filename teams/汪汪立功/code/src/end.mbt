fn render_end_ui() -> Unit {
  set_main_color_with_transparent(Black)
  @wasm4.rect(22, 22, 116, 116)
  set_main_color_with_transparent(LightBrown)
  @wasm4.text("YOU ARE DEAD", 30, 50)
  @wasm4.text("Press R to restart", 10, 75)
}
