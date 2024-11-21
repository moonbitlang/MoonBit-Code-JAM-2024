type Anime (EnemyStatus, Skill) -> Unit

let stampede : Anime = fn(self, sk) {
  let animetime = self.skill.anime_time
  match self.round {
    Anime =>
      if game.r_time <= animetime {
        self.draw(x=110 - game.r_time * 2, y=self.round_pos.y, Fight)
      } else if self.finish == 0 {
        self.draw(x=50, y=self.round_pos.y, Fight)
        self.round = Action
      } else if game.r_time - self.finish <= animetime {
        self.draw(
          x=50 + (game.r_time - self.finish) * 2,
          y=self.round_pos.y,
          Fight,
        )
      } else {
        self.battle = Default
        self.attack += 1
        self.round_reset()
        return
      }
    Action => {
      self.draw(x=50, y=self.round_pos.y, Fight)
      if self.battle == Attack {
        damage_player(sk.damage, sk.critical, player)
        self.round = Anime
        self.finish = game.r_time
      }
    }
    Default => {
      self.round_reset()
      return
    }
  }
}

fn lose_anime(self : EnemyStatus) -> Unit {
  self.finish += 1
  if self.finish % 20 == 0 {
    self.defense = -self.defense
  }
  self.draw(
    x=self.round_pos.x + 5 * self.defense,
    y=self.round_pos.y + 5 * self.defense,
    Fight,
  )
  two_color(2, 2)
  for i = 0; i <= self.finish / 8; i = i + 1 {
    for j = 0; j <= self.finish / 8; j = j + 1 {
      @lib.draw_pixel(80 + i, 80 + j)
      @lib.draw_pixel(80 + i, 80 - j)
      @lib.draw_pixel(80 - i, 80 + j)
      @lib.draw_pixel(80 - i, 80 - j)
    }
  }
  if self.finish >= 640 {
    game.scene = Finish
    return
  }
}
