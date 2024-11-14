struct Game {
  mut level : Int
  mut stop : Bool
  player : Player
  mut current_room : Room
}

fn Game::new() -> Game {
  {
    level: 1,
    stop: false,
    player: Player::new({ x: 80, y: 120 }),
    current_room: generate_room(1),
  }
}

fn update_level(self : Player) -> Unit {
  match check_next_room(self) {
    Some(Up) => {
      if game.current_room.upgrade {
        self.level += 1
        self.hp += 50
      }
      game.level += 1
      game.current_room = generate_room(game.level)
      self.pos = { x: 73, y: 121 }
    }
    Some(Down) => {
      if game.current_room.upgrade {
        self.hp = self.hp_max
      }
      game.level += 1
      game.current_room = generate_room(game.level)
      self.pos = { x: 31, y: 77 }
    }
    Some(Left) => {
      if game.current_room.upgrade {
        let level = self.slingshot.level
        self.slingshot = Slingshot::new(level + 1)
      }
      game.level += 1
      game.current_room = generate_room(game.level)
      self.pos = { x: 126, y: 73 }
    }
    Some(Right) => {
      if game.current_room.upgrade {
        let level = self.sword.level
        self.sword = Sword::new(level + 1)
      }
      game.level += 1
      game.current_room = generate_room(game.level)
      self.pos = { x: 76, y: 30 }
    }
    None => ()
  }
}

fn check_next_room(self : Player) -> Direction? {
  let (x, y) = self.pos.to_wasm4_pos()
  if x > 0 && x < 160 && y > 0 && y < 160 {
    None
  } else if x <= 0 {
    Some(Left)
  } else if x >= 160 {
    Some(Right)
  } else if y <= 0 {
    Some(Up)
  } else {
    Some(Down)
  }
}
