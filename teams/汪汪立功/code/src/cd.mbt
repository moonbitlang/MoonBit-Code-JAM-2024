struct CD {
  mut cd : Int
  total : Int
  decrease : Int
}

fn CD::new(total : Int, decrease : Int) -> CD {
  { cd: total, total, decrease }
}

fn decrease(self : CD) -> Unit {
  if self.cd > 0 {
    self.cd -= self.decrease
  }
}

fn refersh(self : CD) -> Unit {
  self.cd = self.total
}

fn check(self : CD) -> Bool {
  self.cd <= 0
}
