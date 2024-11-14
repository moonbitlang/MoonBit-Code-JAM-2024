struct Arrow {
  mut pos : Position
  speed : Double
  k : Double
  damage : Int
  direction : Bool
  vert : Bool
  belong : Bool
}

fn Arrow::new(
  pos : Position,
  speed : Double,
  k : Double,
  damage : Int,
  direction : Bool,
  vert : Bool,
  belong : Bool
) -> Arrow {
  { pos, speed, k, damage, direction, vert, belong }
}

fn get_hitbox(self : Arrow) -> Shape {
  Rect(self.pos.x - 2.5, self.pos.y - 2.5, self.pos.x + 2.5, self.pos.y + 2.5)
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
  speed : Double,
  damage : Int,
  belong : Bool
) -> (UInt, Arrow) {
  let id = id_pool.get_id()
  if from_pos.x == to_pos.x {
    (
      id,
      Arrow::new(
        from_pos,
        speed,
        1,
        damage,
        from_pos.y < to_pos.y,
        true,
        belong,
      ),
    )
  } else {
    let k = (from_pos.y - to_pos.y) / (from_pos.x - to_pos.x)
    (
      id,
      Arrow::new(
        from_pos,
        speed,
        k,
        damage,
        from_pos.x < to_pos.x,
        false,
        belong,
      ),
    )
  }
}

fn update_arrow(self : Room) -> Unit {
  let erase_list : Array[UInt] = []
  for id, arrow in self.arrows {
    let hitbox = arrow.get_hitbox()
    let mut flag = false
    if game.current_room.arrow_walls.shape_in_box(hitbox) {
      erase_list.push(id)
      flag = true
    } else if arrow.belong == true &&
      game.player.pos.get_hitbox_player().intersect(hitbox) {
      game.player.damage(arrow.damage)
      erase_list.push(id)
      flag = true
    } else if arrow.belong == false {
      if game.current_room.move_hitbox().shape_in_box(hitbox) {
        erase_list.push(id)
        flag = true
      }
      for _, enemy in self.enemys {
        if enemy.get_hitbox().intersect(hitbox) {
          enemy.damage(arrow.damage)
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

fn ai(self : Arrow) -> Unit {
  let k_signum = self.k.signum()
  let direction = (if self.direction { 1.0 } else { -1.0 }) *
    (if k_signum == 0 { 1 } else { k_signum })
  self.pos = if self.vert.not() {
    let k_s = self.k * self.k
    let sin = (k_s / (k_s + 1)).sqrt()
    let cos = if self.k == 0 { 1.0 } else { sin / self.k }
    let dy = self.speed * sin * direction
    let dx = self.speed * cos * direction
    { x: self.pos.x + dx, y: self.pos.y + dy }
  } else {
    { x: self.pos.x, y: self.pos.y + self.speed * direction }
  }
}
