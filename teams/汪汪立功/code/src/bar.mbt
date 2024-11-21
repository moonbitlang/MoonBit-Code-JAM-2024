fn render_hp_bar(player : Player) -> Unit {
  set_main_color_with_transparent(LightBrown)
  let now_hp = if player.hp < 0 { 0 } else { player.hp }
  let progress = now_hp.to_float() / player.hp_max.to_float()
  let break_point = 8 + float_to_int(60.0.to_float() * progress)
  @wasm4.rect(8, 7, 60, 7)
  set_draw_color(1, Brown)
  @wasm4.rect(break_point, 7, 60 - (break_point - 8), 7)
}

fn render_cd_bar(player : Player) -> Unit {
  set_main_color_with_transparent(LightBrown)
  let cd = player.weapon.get_cd()
  let now_cd = if cd.cd < 0 { 0 } else { cd.cd }
  let progress = (cd.total - now_cd).to_float() / cd.total.to_float()
  let break_point = 88 + float_to_int(42.0.to_float() * progress)
  @wasm4.rect(88, 7, 42, 7)
  set_draw_color(1, Brown)
  @wasm4.rect(break_point, 7, 42 - (break_point - 88), 7)
}
