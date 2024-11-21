enum Shape {
  Rect(Float, Float, Float, Float)
}

struct HitBox {
  shapes : Array[Shape]
}

fn HitBox::new() -> HitBox {
  { shapes: [] }
}

fn add(self : HitBox, shape : Shape) -> Unit {
  self.shapes.push(shape)
}

fn merge(self : HitBox, other : HitBox) -> HitBox {
  { shapes: self.shapes + other.shapes }
}

fn intersect(self : Shape, other : Shape) -> Bool {
  let Rect(x1, y1, x2, y2) = self
  let Rect(x3, y3, x4, y4) = other
  (x1 > x4 || x3 > x2 || y1 > y4 || y3 > y2).not()
}

fn init_wall() -> HitBox {
  let hitbox : HitBox = HitBox::new()
  hitbox.add(Rect(3, 3, 70, 20))
  hitbox.add(Rect(3, 3, 20, 71))
  hitbox.add(Rect(3, 85, 20, 154))
  hitbox.add(Rect(3, 137, 71, 154))
  hitbox.add(Rect(85, 137, 154, 154))
  hitbox.add(Rect(137, 85, 154, 154))
  hitbox.add(Rect(84, 3, 154, 20))
  hitbox.add(Rect(137, 3, 154, 71))
  hitbox
}

fn frame() -> HitBox {
  let hitbox : HitBox = HitBox::new()
  hitbox.add(Rect(3, 71, 20, 85))
  hitbox.add(Rect(70, 3, 84, 20))
  hitbox.add(Rect(137, 71, 154, 85))
  hitbox.add(Rect(72, 138, 86, 155))
  hitbox
}

fn shape_in_box(self : HitBox, shape : Shape) -> Bool {
  for current_shape in self.shapes {
    if intersect(current_shape, shape) {
      return true
    }
  }
  false
}
