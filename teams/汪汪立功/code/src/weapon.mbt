enum Weapon {
  Sword(Sword)
  Slingshot(Slingshot)
}

fn switch_weapon(self : Player) -> Unit {
  if self.weapon_type == true {
    self.weapon = Slingshot(self.slingshot)
    self.weapon_type = false
  } else {
    self.weapon = Sword(self.sword)
    self.weapon_type = true
  }
  self.switch_cd.refersh()
}

fn attack(
  self : Weapon,
  pos : Position,
  room : Room,
  mouse_x : Int,
  mouse_y : Int
) -> Unit {
  match self {
    Sword(sword) => sword.sword_attack(pos, room, mouse_x, mouse_y)
    Slingshot(slingshot) =>
      slingshot.slingshot_attack(pos, room, mouse_x, mouse_y)
  }
}

fn get_cd(self : Weapon) -> CD {
  match self {
    Sword(sword) => sword.cd
    Slingshot(slingshot) => slingshot.cd
  }
}

fn update_weapon(self : Player) -> Unit {
  self.switch_cd.decrease()
  match self.weapon {
    Sword(sword) => sword.cd.decrease()
    Slingshot(slingshot) => slingshot.cd.decrease()
  }
}

struct Sword {
  level : Int
  damage : Int
  range : Int
  cd : CD
  repel : Int
}

fn Sword::new(level : Int) -> Sword {
  {
    level,
    damage: 10 + level * 8,
    range: 6 + level / 4,
    cd: CD::new(100, 10 + level / 5),
    repel: 2 + level / 4,
  }
}

fn sword_determine_direction(
  mouse_x : Int,
  mouse_y : Int,
  pos : Position
) -> Direction {
  let dx = mouse_x.to_float() - pos.x
  let dy = mouse_y.to_float() - pos.y
  if dy < 0 && dx.abs() < dy.abs() {
    Up
  } else if dy > 0 && dx.abs() < dy.abs() {
    Down
  } else if dx < 0 && dy.abs() < dx.abs() {
    Left
  } else {
    Right
  }
}

fn sword_generate_attack_hitbox(
  self : Direction,
  sword : Sword,
  pos : Position
) -> Shape {
  let range = sword.range.to_float()
  match self {
    Left => Rect(pos.x - 5 - range, pos.y - 5, pos.x - 5, pos.y)
    Right => Rect(pos.x, pos.y - 5, pos.x + 5 + range, pos.y + 5)
    Up => Rect(pos.x - 5, pos.y - 5 - range, pos.x + 5, pos.y)
    Down => Rect(pos.x - 5, pos.y, pos.x + 5, pos.y + 5 + range)
  }
}

fn sword_attack(
  self : Sword,
  pos : Position,
  room : Room,
  mouse_x : Int,
  mouse_y : Int
) -> Unit {
  for _, enemy in room.enemys {
    let { damage, .. } = self
    let direction = sword_determine_direction(mouse_x, mouse_y, pos)
    let hitbox = direction.sword_generate_attack_hitbox(self, pos)
    if hitbox.intersect(get_hitbox_f(enemy.pos, 5)) {
      enemy.hp -= damage
      music_damage()
      enemy.repel(direction, self.repel)
    }
  }
  self.cd.refersh()
}

struct Slingshot {
  level : Int
  damage : Int
  speed : Float
  cd : CD
}

fn Slingshot::new(level : Int) -> Slingshot {
  {
    level,
    damage: 8 + level * 2,
    speed: 0.5.to_float() + 0.2.to_float() * level.to_float(),
    cd: CD::new(100, 2 + level / 3 * 2),
  }
}

fn slingshot_attack(
  self : Slingshot,
  pos : Position,
  room : Room,
  mouse_x : Int,
  mouse_y : Int
) -> Unit {
  let (id, arrow) = generate_arrow(
    pos,
    { x: mouse_x.to_float(), y: mouse_y.to_float() },
    self.speed,
    self.damage,
    false,
  )
  room.arrows.set(id, arrow)
  self.cd.refersh()
}

fn refersh_weapon(self : Player) -> Unit {
  self.weapon = if self.weapon_type {
    Sword(self.sword)
  } else {
    Slingshot(self.slingshot)
  }
}
