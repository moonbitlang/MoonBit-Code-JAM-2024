fn render(room : Room, player : Player) -> Unit {
  render_background_normal()
  if room.upgrade {
    set_main_color_with_transparent(LightBrown)
    render_upgrade_room()
  } else if room.start {
    set_main_color_with_transparent(LightBrown)
    render_start_room()
  }
  render_weapon_column()
  render_player(player)
  render_hp_bar(player)
  render_cd_bar(player)
  render_info(player)
  for obstacle in room.obstacles {
    obstacle.render_obstacle()
  }
  for _, enemy in room.enemys {
    render_enermy(enemy)
  }
  for _, arrow in room.arrows {
    render_arrow(arrow)
  }
}

fn render_upgrade_room() -> Unit {
  @wasm4.text("Upgrade Room", 35, 50)
  @wasm4.text("Player", 60, 25)
  @wasm4.text("HP MAX", 60, 126)
  @wasm4.text("Sword", 15, 75)
  @wasm4.text("Slingshot", 85, 75)
}

fn render_start_room() -> Unit {
  @wasm4.text("SOUL", 62, 40)
  @wasm4.text("OF", 70, 50)
  @wasm4.text("THE", 65, 60)
  @wasm4.text("DESERT", 55, 70)
  @wasm4.text("MOUSE 1 ATTACK", 25, 90)
  @wasm4.text("MOUSE 2 SWITCH", 25, 105)
}

fn render_background_normal() -> Unit {
  render_background()
  set_main_color_with_transparent(Black)
}

fn render_background() -> Unit {
  set_draw_color(1, LightBrown)
  set_draw_color(2, Brown)
  set_draw_color(3, Grey)
  set_draw_color(4, Black)
  map_texture.render_texture(0, 0)
}
