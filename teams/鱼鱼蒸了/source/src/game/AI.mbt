let default_ai : AI = fn(self) { @wasm.text(self.name.to_string(), 60, 60) }

let sheep_ai : AI = fn(self) {
  // 每两次咩咩冲击进行一次防御
  draw_hero(player.round_pos.x, player.round_pos.y, size=3)
  if self.battle == Special {
    self.draw(x=self.round_pos.x, y=self.round_pos.y, Fight)
    draw_hero(player.bonus_pos.x, player.bonus_pos.y, size=1)
    if not((bonus_levels[round.rng].level._)(1, self.level)) {
      if bonus_time.b_time[round.rng] != 0 {
        bonus_time.b_time[round.rng] = 0
        player.bonus_pos.x = 85
        player.bonus_pos.y = 150
        self.round_reset()
      }
      self.battle = Default
    }
  } else {
    game.r_time += 1
    if self.attack != 0 && self.attack % 2 == 0 {
      self.battle = Defense
      self.attack = 0
      self.round_reset()
    } else {
      if self.round == Default && self.battle == Default {
        self.round = Anime
        self.battle = Attack
      }
      (self.skill.anime._)(self, self.skill)
    }
  }
}

let pumpkin_ai : AI = fn(self) {
  draw_hero(player.round_pos.x, player.round_pos.y, size=3)
  if self.attack == 13 && player.level != 19 {
    if self.finish == 0 {
      self.defense = 1
    }
    self.lose_anime()
    return
  }
  if self.battle == Special {
    self.draw(x=self.round_pos.x, y=self.round_pos.y, Fight)
    draw_hero(player.bonus_pos.x, player.bonus_pos.y, size=1)
    if not(
        (bonus_levels[round.rng].level._)(
          1 + (self.attack > 10).to_int(),
          30 + self.attack,
        ),
      ) {
      if bonus_time.b_time[round.rng] != 0 {
        bonus_time.b_time[round.rng] = 0
        player.bonus_pos.x = 85
        player.bonus_pos.y = 150
        self.round_reset()
      }
      self.battle = Default
    }
  } else {
    game.r_time += 1
    if self.hp < 56 && self.defense == 0 {
      self.hp = 100
      self.defense = 1
      self.round_reset()
    } else {
      if self.round == Default && self.battle == Default {
        self.round = Anime
        self.battle = Attack
      }
      (self.skill.anime._)(self, self.skill)
    }
  }
}
