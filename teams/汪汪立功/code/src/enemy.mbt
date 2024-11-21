struct Enemy {
  type_ : Int
  id : UInt
  speed : Float
  mut pos : Position
  mut hp : Int
  hit : Int
  hitcd : CD
}

fn render_enermy(enemy : Enemy) -> Unit {
  let (x, y) = enemy.pos.to_wasm4_pos()
  match enemy.type_ {
    1 => mummy_texture.render_texture(x - 5, y - 5)
    2 => skeleton_texture.render_texture(x - 5, y - 5)
    3 => bug_texture.render_texture(x - 5, y - 5)
  }
}

fn update_enemy(self : Room) -> Unit {
  let erase_list : Array[UInt] = []
  for id, enemy in self.enemys {
    if enemy.hp <= 0 {
      erase_list.push(id)
    } else if enemy.type_ == 1 || enemy.type_ == 3 {
      enemy.ai_mummy()
    } else {
      enemy.ai_skeleton()
    }
  }
  for id in erase_list {
    self.enemys.remove(id)
    game.player.hp = if game.player.hp + 5 > game.player.hp_max {
      game.player.hp_max
    } else {
      game.player.hp + 5
    }
  }
}

fn apply(self : Enemy, pos : Position) -> Unit {
  let hitbox = get_hitbox_f(pos, 5)
  if game.current_room.move_hitbox().shape_in_box(hitbox).not() &&
    game.player.pos.get_hitbox_f(5).intersect(hitbox).not() {
    self.pos = pos
  }
}

fn repel(self : Enemy, direction : Direction, range : Int) -> Unit {
  self.apply(
    match direction {
      Up => { x: self.pos.x, y: self.pos.y + range.to_float() }
      Down => { x: self.pos.x, y: self.pos.y - range.to_float() }
      Left => { x: self.pos.x - range.to_float(), y: self.pos.y }
      Right => { x: self.pos.x + range.to_float(), y: self.pos.y }
    },
  )
}

fn new_mummy(id : UInt, pos : Position, level : Int) -> Enemy {
  {
    type_: 1,
    id,
    pos,
    hp: 50 + level * 5,
    speed: 0.35,
    hit: 10 + level * 2,
    hitcd: CD::new(100, 3 + level / 10),
  }
}

fn new_skeleton(id : UInt, pos : Position, level : Int) -> Enemy {
  {
    type_: 2,
    id,
    pos,
    hp: 40 + level * 5,
    hitcd: CD::new(100, level),
    speed: 0.3.to_float(),
    hit: 10 + level * 2,
  }
}

fn go(self : Enemy) -> Unit {
  let way = self.pos.find_way(game.player.pos, self.speed)
  self.apply({ x: way.x, y: self.pos.y })
  self.apply({ x: self.pos.x, y: way.y })
}

fn ai_skeleton(self : Enemy) -> Unit {
  let distance = self.pos.distance(game.player.pos)
  self.hitcd.decrease()
  if distance > 40 {
    self.go()
  } else if self.hitcd.check() {
    let (id, arrow) = generate_arrow(
      self.pos,
      game.player.pos,
      self.speed,
      self.hit,
      true,
    )
    game.current_room.arrows.set(id, arrow)
    self.hitcd.refersh()
  }
}

pub fn ai_mummy(self : Enemy) -> Unit {
  let distance = self.pos.distance(game.player.pos)
  self.hitcd.decrease()
  if distance > 11 {
    self.go()
  } else if self.hitcd.check() {
    game.player.hp -= self.hit
    music_attack()
    self.hitcd.refersh()
  }
}

fn new_bug(id : UInt, pos : Position, level : Int) -> Enemy {
  {
    type_: 3,
    id,
    pos,
    hp: 20 + level * 2,
    speed: 0.4.to_float() + 0.05.to_float() * level.to_float(),
    hit: 3 + level,
    hitcd: CD::new(100, 2 + level / 10),
  }
}
