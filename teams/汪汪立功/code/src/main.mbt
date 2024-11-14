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
    update_weapon(game.player)
    update_enemy(game.current_room)
    update_arrow(game.current_room)
    inputer(game.player)
  }
}
