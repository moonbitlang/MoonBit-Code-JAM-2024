struct Round {
  mut status : String
  mut enemy : EnemyStatus
  mut rng : Int
}

let round : Round = Round::default()

fn Round::default() -> Round {
  { status: "player", enemy: EnemyStatus::default(), rng: -1 }
}

fn Round::fight(state : String, enemy : EnemyStatus) -> Unit {
  if state == "attack" {
    if player.round == Default && player.battle == Default {
      player.round = Anime
      player.battle = Special
      game.r_time = game.g_time
    }
    if player.battle == Attack {
      game.r_time += 1
      sword_attack(enemy)
    }
    if player.battle == Special {
      draw_hero(player.round_pos.x, player.round_pos.y, size=3)
      @wasm.set_draw_colors(0, index=2)
      @wasm.set_draw_colors(2, index=1)
      @wasm.rect(20, 115, 30, 5)
      @wasm.rect(110, 115, 30, 5)
      @wasm.set_draw_colors(3, index=1)
      @wasm.rect(50, 115, 25, 5)
      @wasm.rect(80, 115, 30, 5)
      @wasm.set_draw_colors(4, index=1)
      @wasm.rect(75, 115, 5, 5)
      if choice.cursor.x <= 20 {
        choice.cursor.y = 1
      } else if choice.cursor.x >= 140 {
        choice.cursor.y = -1
      }
      choice.cursor.x += choice.cursor.y
      @wasm.set_draw_colors(3, index=1)
      @wasm.rect(choice.cursor.x, 105, 3, 25)
      if keyboard.button == X &&
        keyboard.pressed &&
        game.g_time - game.r_time > 1 {
        player.battle = Attack
        choice.cursor.y = 1
        game.r_time = 0
      }
    }
  } else if state == "defense" {
    player.battle = Defense
    round_enemy(enemy, player.finish)
  } else if state == "heal" {
    player.battle = Default
    player.hp = @math.minimum(player.hp + 10, player.max_hp)
    round_enemy(enemy, player.finish)
  }
  enemy.battle = Special
}

fn Round::battle(enemy : EnemyStatus) -> Unit {
  if player.hp <= 0 {
    game.scene = Defeat
  }
  if enemy.hp <= 0 {
    game.scene = Victory
    delete_enemy(round.enemy.level)
    round.round_reset()
    return
  }
  round_scene(enemy)
  // @wasm.text(player.battle.to_string(), 20, 20)
  if round.status == "player" {
    if enemy.level == 108 && enemy.attack == 13 {
      two_color(4, 0)
      @wasm.text("Finish it!", 45, 25)
      battleStatus[1] = "Fight"
      battleStatus[2] = "Fight"
    }
    if round.rng == -1 {
      let r = @random.new(seed=sed[game.g_time % 9])
      round.rng = r.int(limit=bonus_levels.length())
      // round.rng = 1
    }
    enemy.draw(x=enemy.round_pos.x, y=enemy.round_pos.y, Fight)
    if player.selfround {
      player.finish += 1
      if player.battle == Defense {
        player.battle = Default
      }
      if enemy.level == 108 && enemy.attack == 13 {
        fight(battleStatus[0], round.enemy)
        return
      }
      fight(battleStatus[choice.option - 1], round.enemy)
    } else {
      game.r_time = 0
      player.finish = 0
      draw_hero(player.round_pos.x, player.round_pos.y, size=3)
    }
  } else {
    choice.option = 0
    (enemy.ai._)(enemy)
  }
}

fn damage_enemy(power : Int, crit : Int, enemy : EnemyStatus) -> Int {
  let damage = power * critical(crit)
  if enemy.name == Pumpkin {
    if player.level != 19 {
      enemy.hp = enemy.hp - 10 - 2 * (player.level > 3).to_int()
      enemy.battle = Default
      return 10 + 2 * (player.level > 3).to_int()
    } else {
      enemy.hp -= 3
      enemy.battle = Default
      return 3
    }
  }
  if enemy.battle == Defense {
    enemy.hp -= 1
    enemy.battle = Default
    return 1
  } else {
    enemy.hp -= damage
    return damage
  }
}

fn damage_player(power : Int, crit : Int, hero : PlayerStatus) -> Unit {
  let damage = power * critical(crit)
  if hero.level == 19 {
    hero.hp -= 102
    hero.battle = Default
    return
  }
  if hero.battle == Defense {
    hero.hp -= 1
    hero.battle = Default
  } else {
    hero.hp -= damage
  }
}

fn Round::round_reset(self : Round) -> Unit {
  self.status = "player"
  player.hp = player.max_hp
  player.battle = Default
  player.round = Default
  choice.option = 0
  player.selfround = false
  self.enemy = EnemyStatus::default()
}

fn Round::round_enemy(enemy : EnemyStatus, clock : Int) -> Unit {
  if clock > 30 {
    round.status = "enemy"
    enemy.battle = Default
    enemy.round = Default
    player.selfround = false
    player.round = Default
    game.r_time = 0
  }
  draw_hero(player.round_pos.x, player.round_pos.y, size=3)
}
