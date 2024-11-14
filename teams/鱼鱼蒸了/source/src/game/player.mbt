struct PlayerStatus {
  mut hp : Int
  mut max_hp : Int
  mut level : Int
  map_pos : Coordinate
  round_pos : Coordinate
  bonus_pos : Coordinate
  mut battle : BattleStatus
  mut round : RoundStatus
  mut finish : Int
  mut damage : Int
  mut selfround : Bool
}

let player : PlayerStatus = PlayerStatus::default()

fn PlayerStatus::default() -> PlayerStatus {
  {
    hp: 14,
    level: 1,
    max_hp: 14,
    map_pos: Coordinate::{ x: 20, y: 10 },
    round_pos: Coordinate::{ x: 20, y: 35 },
    bonus_pos: Coordinate::{ x: 85, y: 150 },
    battle: Default,
    round: Default,
    finish: 0,
    damage: 0,
    selfround: false,
  }
}

fn draw_hero(
  x : Int,
  y : Int,
  ~size : Int = 1,
  ~scene : RoundStatus = Default
) -> Unit {
  @lib.hero_body(x, y, ~size)
  if scene == Default {
    @lib.hero_sword(x, y, ~size)
  }
}

fn sword_attack(enemy : EnemyStatus) -> Unit {
  match player.round {
    Anime =>
      if game.r_time < 50 {
        draw_hero(player.round_pos.x + game.r_time, player.round_pos.y, size=3)
      } else if game.r_time >= 51 && game.r_time < 57 {
        draw_hero(
          player.round_pos.x + 50,
          player.round_pos.y,
          size=3,
          scene=Anime,
        )
        @lib.sword_1(player.round_pos.x + 50, player.round_pos.y, size=3)
      } else if game.r_time >= 57 && game.r_time < 63 {
        draw_hero(
          player.round_pos.x + 50,
          player.round_pos.y,
          size=3,
          scene=Anime,
        )
        @lib.sword_2(player.round_pos.x + 50, player.round_pos.y, size=3)
        @lib.draw_hit(enemy.round_pos.x + 2, enemy.round_pos.y - 2, size=3)
      } else if game.r_time >= 63 && game.r_time < 70 {
        draw_hero(
          player.round_pos.x + 50,
          player.round_pos.y,
          size=3,
          scene=Anime,
        )
        @lib.sword_3(player.round_pos.x + 50, player.round_pos.y, size=3)
        @lib.draw_hit(enemy.round_pos.x + 2, enemy.round_pos.y - 2, size=3)
        if game.r_time == 69 {
          sound()
          player.round = Action
        }
      } else if game.r_time >= 70 && game.r_time < 120 {
        draw_hero(
          player.round_pos.x + (120 - game.r_time),
          player.round_pos.y,
          size=3,
          scene=Default,
        )
        two_color(4, 0)
        if enemy.level == 108 && enemy.attack == 13 {
          @wasm.text("-108", 130, 25)
        } else {
          @wasm.text("-" + player.damage.to_string(), 130, 25)
        }
      } else if game.r_time >= 120 {
        draw_hero(player.round_pos.x, player.round_pos.y, size=3, scene=Default)
        player.damage = 0
        if game.r_time - 120 > 10 {
          player.battle = Default
          round_enemy(enemy, 80)
        }
      }
    Action => {
      draw_hero(player.round_pos.x + 50, player.round_pos.y, size=3)
      let mut damage : Int = 0
      let mut cri : Int = 0
      if choice.cursor.x < 50 || choice.cursor.x >= 110 {
        damage = 1
        cri = 5
      } else if choice.cursor.x < 75 || choice.cursor.x >= 80 {
        damage = 2
        cri = 10
      } else {
        damage = 5
        cri = 20
      }
      player.damage = damage_enemy(player.level * damage, cri, enemy)
      choice.cursor.x = 20
      player.round = Anime
    }
    Default => return
  }
}
