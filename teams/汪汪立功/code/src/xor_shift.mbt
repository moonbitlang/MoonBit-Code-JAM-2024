struct RandomGenerator {
  mut seed : Int
}

fn RandomGenerator::new(seed : Int) -> RandomGenerator {
  { seed, }
}

fn next(self : RandomGenerator, range_l : Int, range_r : Int) -> Int {
  self.seed = self.seed ^ (self.seed << 13)
  self.seed = self.seed ^ (self.seed >> 17)
  self.seed = self.seed ^ (self.seed << 5)
  range_l + self.seed.abs() % (range_r - range_l + 1)
}

fn next_pos(self : RandomGenerator) -> Position {
  { x: self.next(40, 100).to_float(), y: self.next(40, 100).to_float() }
}

let random : RandomGenerator = RandomGenerator::new(114514)
