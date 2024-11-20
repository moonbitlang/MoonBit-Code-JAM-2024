struct Player {
  mut level : Int
  mut pos : Position
  mut hp : Int
  mut hp_max : Int
  mut sword : Sword
  mut slingshot : Slingshot
  mut weapon : Weapon
  mut weapon_type : Bool
  switch_cd : CD
}

fn Player::new(pos : Position) -> Player {
  {
    level: 1,
    pos,
    hp: 100,
    hp_max: 100,
    sword: Sword::new(1),
    slingshot: Slingshot::new(1),
    weapon: Sword(Sword::new(1)),
    weapon_type: true,
    switch_cd: CD::new(100, 10),
  }
}

// -------------- MOVE --------------

fn apply(self : Player, pos : Position) -> Unit {
  let hitbox = pos.get_hitbox_f(5)
  if game.current_room.move_hitbox().shape_in_box(hitbox).not() {
    self.pos = pos
  }
}

fn move_(self : Player, direction : Direction) -> Unit {
  match direction {
    Up => self.apply({ x: self.pos.x, y: self.pos.y - 1 })
    Down => self.apply({ x: self.pos.x, y: self.pos.y + 1 })
    Left => self.apply({ x: self.pos.x - 1, y: self.pos.y })
    Right => self.apply({ x: self.pos.x + 1, y: self.pos.y })
  }
}

// -------------- RENDER --------------

fn render_player(player : Player) -> Unit {
  player_texture.render_texture(
    float_to_int(player.pos.x - 5),
    float_to_int(player.pos.y - 5),
  )
}

// -------------- UPDATE --------------

fn update_player(self : Player) -> Unit {
  if self.hp < 0 {
    game.stop = true
  }
}

fn level_up(self : Player) -> Unit {
  self.level += 1
  self.hp_max = 100 + self.level * 50
}
