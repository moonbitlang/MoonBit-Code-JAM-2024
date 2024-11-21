fn render_info(self : Player) -> Unit {
  set_main_color_with_transparent(LightBrown)
  @wasm4.text(if self.weapon_type == true { "1" } else { "2" }, 135, 7)
  @wasm4.text(
    "\{self.level}/\{self.sword.level}/\{self.slingshot.level}",
    16,
    146,
  )
  @wasm4.text("\{self.hp}/\{self.hp_max}", 97, 146)
}
