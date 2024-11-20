enum Enemy {
  Mummy(Mummy)
  Skeleton(Skeleton)
  Bug(Bug)
}

fn get_pos(self : Enemy) -> Position {
  match self {
    Mummy({ pos, .. }) => pos
    Skeleton({ pos, .. }) => pos
    Bug({ pos, .. }) => pos
  }
}

fn get_hp(self : Enemy) -> Int {
  match self {
    Mummy({ hp, .. }) => hp
    Skeleton({ hp, .. }) => hp
    Bug({ hp, .. }) => hp
  }
}

fn get_id(self : Enemy) -> UInt {
  match self {
    Mummy({ id, .. }) => id
    Skeleton({ id, .. }) => id
    Bug({ id, .. }) => id
  }
}

fn get_hitbox(self : Enemy, pos~ : Position = self.get_pos()) -> Shape {
  match self {
    Mummy(_) => pos.get_hitbox_mummy()
    Skeleton(_) => pos.get_hitbox_skeleton()
    Bug(_) => pos.get_hitbox_bug()
  }
}

fn damage(self : Enemy, damage : Int) -> Unit {
  match self {
    Mummy(mummy) => mummy.hp -= damage
    Skeleton(skeleton) => skeleton.hp -= damage
    Bug(mummy) => mummy.hp -= damage
  }
}

fn render_enermy(enemy : Enemy) -> Unit {
  match enemy {
    Mummy({ pos, .. }) => {
      let (x, y) = pos.to_wasm4_pos()
      mummy_texture.render_texture(x - 5, y - 5)
    }
    Skeleton({ pos, .. }) => {
      let (x, y) = pos.to_wasm4_pos()
      skeleton_texture.render_texture(x - 5, y - 5)
    }
    Bug({ pos, .. }) => {
      let (x, y) = pos.to_wasm4_pos()
      bug_texture.render_texture(x - 5, y - 5)
    }
  }
}

fn update_enemy(self : Room) -> Unit {
  let erase_list : Array[UInt] = []
  for id, enemy in self.enemys {
    if enemy.get_hp() <= 0 {
      erase_list.push(id)
    } else {
      match enemy {
        Mummy(mummy) => mummy.ai()
        Skeleton(skeleton) => skeleton.ai()
        Bug(bug) => bug.ai()
      }
    }
  }
  for id in erase_list {
    self.enemys.remove(id)
  }
}

fn set_pos(self : Enemy, pos : Position) -> Unit {
  match self {
    Mummy(mummy) => mummy.pos = pos
    Skeleton(skeleton) => skeleton.pos = pos
    Bug(mummy) => mummy.pos = pos
  }
}

fn apply(self : Enemy, pos : Position) -> Unit {
  let hitbox = self.get_hitbox(pos~)
  if game.current_room.move_hitbox().shape_in_box(hitbox).not() &&
    game.player.pos.get_hitbox_player().intersect(hitbox).not() {
    self.set_pos(pos)
  }
}

// -------------- Mummy --------------
// size: 10*10
struct Mummy {
  id : UInt
  speed : Double
  mut pos : Position
  mut hp : Int
  hit : Int
  hitcd : CD
}

fn Mummy::new(id : UInt, pos : Position, level : Int) -> Mummy {
  {
    id,
    pos,
    hp: 50 + level * 5,
    speed: 0.35,
    hit: 10 + level * 2,
    hitcd: CD::new(100, 3 + level / 10),
  }
}

fn get_hitbox_mummy(self : Position) -> Shape {
  Rect(self.x - 5, self.y - 5, self.x + 5, self.y + 5)
}

pub fn ai(self : Mummy) -> Unit {
  let distance = self.pos.distance(game.player.pos)
  self.hitcd.decrease()
  if distance <= 11 && self.hitcd.check() {
    game.player.damage(self.hit)
    self.hitcd.refersh()
  } else if distance > 11 {
    let way = self.pos.find_way(game.player.pos, self.speed)
    Mummy(self).apply({ x: way.x, y: self.pos.y })
    Mummy(self).apply({ x: self.pos.x, y: way.y })
  }
}

// -------------- Skeleton --------------
// size: 10*10
struct Skeleton {
  id : UInt
  mut pos : Position
  mut hp : Int
  hitcd : CD
  speed : Double
  damage : Int
}

fn get_hitbox_skeleton(self : Position) -> Shape {
  Rect(self.x - 5, self.y - 5, self.x + 5, self.y + 5)
}

fn Skeleton::new(id : UInt, pos : Position, level : Int) -> Skeleton {
  {
    id,
    pos,
    hp: 40 + level * 5,
    hitcd: CD::new(100, level),
    speed: 0.3 + 0.05 * level.to_double(),
    damage: 10 + level * 2,
  }
}

fn ai(self : Skeleton) -> Unit {
  let distance = self.pos.distance(game.player.pos)
  self.hitcd.decrease()
  if distance <= 40 && self.hitcd.check() {
    let (id, arrow) = generate_arrow(
      self.pos,
      game.player.pos,
      self.speed,
      self.damage,
      true,
    )
    game.current_room.arrows.set(id, arrow)
    self.hitcd.refersh()
  } else if distance > 40 {
    let way = self.pos.find_way(game.player.pos, 0.25)
    Skeleton(self).apply({ x: way.x, y: self.pos.y })
    Skeleton(self).apply({ x: self.pos.x, y: way.y })
  }
}

// -------------- Bug --------------
// size: 11*10
struct Bug {
  id : UInt
  speed : Double
  mut pos : Position
  mut hp : Int
  hit : Int
  hitcd : CD
}

fn Bug::new(id : UInt, pos : Position, level : Int) -> Bug {
  {
    id,
    pos,
    hp: 20 + level * 2,
    speed: 0.4 + 0.05 * level.to_double(),
    hit: 3 + level,
    hitcd: CD::new(100, 2 + level / 10),
  }
}

fn get_hitbox_bug(self : Position) -> Shape {
  Rect(self.x - 5, self.y - 5, self.x + 6, self.y + 5)
}

fn ai(self : Bug) -> Unit {
  let distance = self.pos.distance(game.player.pos)
  self.hitcd.decrease()
  if distance <= 11 && self.hitcd.check() {
    game.player.damage(self.hit)
    self.hitcd.refersh()
  } else if distance > 11 {
    let way = self.pos.find_way(game.player.pos, self.speed)
    Bug(self).apply({ x: way.x, y: self.pos.y })
    Bug(self).apply({ x: self.pos.x, y: way.y })
  }
}
