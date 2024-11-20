struct Arrow {
  mut pos : Position
  speed : Float
  k : Float
  damage : Int
  direction : Bool
  vert : Bool
  belong : Bool
}

fn Arrow::new(
  pos : Position,
  speed : Float,
  k : Float,
  damage : Int,
  direction : Bool,
  vert : Bool,
  belong : Bool
) -> Arrow {
  { pos, speed, k, damage, direction, vert, belong }
}

fn render_arrow(arrow : Arrow) -> Unit {
  set_draw_color(1, LightBrown)
  set_draw_color(2, Brown)
  let (x, y) = arrow.pos.to_wasm4_pos()
  @wasm4.oval(x, y, 5, 5)
}

fn generate_arrow(
  from_pos : Position,
  to_pos : Position,
  speed : Float,
  damage : Int,
  belong : Bool
) -> (UInt, Arrow) {
  let id = id_pool.get_id()
  let is_x_pos_equal = from_pos.x == to_pos.x
  (
    id,
    Arrow::new(
      from_pos,
      speed,
      if is_x_pos_equal {
        1
      } else {
        (from_pos.y - to_pos.y) / (from_pos.x - to_pos.x)
      },
      damage,
      from_pos.x < to_pos.x,
      is_x_pos_equal,
      belong,
    ),
  )
}

fn update_arrow(self : Room) -> Unit {
  let erase_list : Array[UInt] = []
  for id, arrow in self.arrows {
    let hitbox = get_hitbox_f(arrow.pos, 2.5)
    let mut flag = false
    if game.current_room.arrow_walls.shape_in_box(hitbox) {
      erase_list.push(id)
      flag = true
    } else if arrow.belong == true &&
      game.player.pos.get_hitbox_f(5).intersect(hitbox) {
      game.player.hp -= arrow.damage
      music_attack()
      erase_list.push(id)
      flag = true
    } else if arrow.belong == false {
      if game.current_room.move_hitbox().shape_in_box(hitbox) {
        erase_list.push(id)
        flag = true
      }
      for _, enemy in self.enemys {
        if get_hitbox_f(enemy.pos, 5).intersect(hitbox) {
          enemy.hp -= arrow.damage
          music_damage()
          erase_list.push(id)
          flag = true
          break
        }
      }
    }
    if flag.not() {
      arrow.ai()
    }
  }
  for id in erase_list {
    self.arrows.remove(id)
  }
}

fn signum(f : Float) -> Int {
  if f == 0 {
    0
  } else if f < 0 {
    -1
  } else {
    1
  }
}

fn ai(self : Arrow) -> Unit {
  let k_signum = signum(self.k)
  let direction = (if self.direction { 1.0 } else { -1.0 }).to_float() *
    (if k_signum == 0 { 1 } else { k_signum.to_float() })
  self.pos = if self.vert.not() {
    let k_s = self.k * self.k
    let sin = (k_s / (k_s + 1)).sqrt()
    let cos = if self.k == 0 { 1.0.to_float() } else { sin / self.k }
    let dy = self.speed * sin * direction
    let dx = self.speed * cos * direction
    { x: self.pos.x + dx, y: self.pos.y + dy }
  } else {
    { x: self.pos.x, y: self.pos.y + self.speed * direction }
  }
}
