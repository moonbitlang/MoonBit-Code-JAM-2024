let game : Game = Game::new()

pub fn start() -> Unit {
  init_color()
}

pub fn update() -> Unit {
  render(game.current_room, game.player)
  if game.stop {
    render_end_ui()
  } else {
    update_level(game.player)
    update_room(game.current_room)
    update_player(game.player)
    if game.pause_cd.check() {
      update_enemy(game.current_room)
    } else {
      game.pause_cd.decrease()
    }
    update_weapon(game.player)
    update_arrow(game.current_room)
    inputer(game.player)
  }
}
