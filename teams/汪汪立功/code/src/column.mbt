fn render_weapon_column() -> Unit {
  set_main_color_with_transparent(LightBrown)
  @wasm4.rect(1, 40, 15, 18) // patch column
  sword_texture.render_texture(3, 23)
  slingshot_texture.render_texture(3, 43)
}
