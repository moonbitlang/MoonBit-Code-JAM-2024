struct Game {
  mut level : Int
  mut stop : Bool
  mut pause_cd : CD
  player : Player
  mut current_room : Room
}

fn Game::new() -> Game {
  {
    level: 1,
    stop: false,
    pause_cd: CD::new(100, 100),
    player: Player::new({ x: 80, y: 120 }),
    current_room: generate_room(1),
  }
}

fn update_level(self : Player) -> Unit {
  match check_next_room(self) {
    Some(direction) => {
      game.level += 1
      match direction {
        Up => {
          if game.current_room.upgrade {
            self.level += 1
            self.hp += 50
          }
          self.pos = { x: 73, y: 121 }
        }
        Down => {
          if game.current_room.upgrade {
            self.hp = self.hp_max
          }
          self.pos = { x: 31, y: 77 }
        }
        Left => {
          if game.current_room.upgrade {
            self.sword = Sword::new(self.sword.level + 1)
          }
          self.pos = { x: 76, y: 30 }
        }
        Right => {
          if game.current_room.upgrade {
            self.slingshot = Slingshot::new(self.slingshot.level + 1)
          }
          self.pos = { x: 126, y: 73 }
        }
      }
      game.current_room = generate_room(game.level)
      game.pause_cd = CD::new(50 + game.level * 2, 1)
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
