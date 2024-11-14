fn render_hp_bar(player : Player) -> Unit {
  set_main_color_with_transparent(LightBrown)
  let now_hp = if player.hp < 0 { 0 } else { player.hp }
  let progress = now_hp.to_double() / player.hp_max.to_double()
  let break_point = 8 + (60.0 * progress).to_int()
  @wasm4.rect(8, 7, 60, 7)
  set_draw_color(1, Brown)
  @wasm4.rect(break_point, 7, 60 - (break_point - 8), 7)
}

fn render_cd_bar(player : Player) -> Unit {
  set_main_color_with_transparent(LightBrown)
  let cd = player.weapon.get_cd()
  let now_cd = if cd.cd < 0 { 0 } else { cd.cd }
  let progress = (cd.total - now_cd).to_double() / cd.total.to_double()
  let break_point = 88 + (42.0 * progress).to_int()
  @wasm4.rect(88, 7, 42, 7)
  set_draw_color(1, Brown)
  @wasm4.rect(break_point, 7, 42 - (break_point - 88), 7)
}
