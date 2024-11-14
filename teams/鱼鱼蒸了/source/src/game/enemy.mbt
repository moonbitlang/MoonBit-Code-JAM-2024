// 敌人稀有度

// 敌人列表
enum EnemyName {
  None
  Sheep
  Pumpkin
} derive(Eq, Show)

// 回合状态
// 动画/行动/默认
enum RoundStatus {
  Anime
  Action
  Default
} derive(Eq, Show)

// 战斗状态
// 防御/攻击/治疗/特殊/默认
enum BattleStatus {
  Defense
  Attack
  Default
  Special
} derive(Eq, Show)

type AI (EnemyStatus) -> Unit

struct EnemyStatus {
  mut hp : Int
  max_hp : Int
  level : Int
  name : EnemyName
  draw : @lib.DrawEnemy
  map_pos : Coordinate
  hitbox : HitBox
  mut battle : BattleStatus
  mut round : RoundStatus
  mut attack : Int
  mut defense : Int
  // mut heal:Int
  mut finish : Int
  round_pos : Coordinate
  ai : AI
  skill : Skill
}

struct Skill {
  anime_time : Int
  anime : Anime
  damage : Int
  critical : Int
}

fn delete_enemy(level : Int) -> Unit {
  for i, x in world.wld.enemylist {
    if x.level == level {
      world.wld.enemylist[i].hp = 0
    }
  }
}

fn EnemyStatus::draw(
  self : EnemyStatus,
  ~x : Int = self.map_pos.x,
  ~y : Int = self.map_pos.y,
  scene : Scene
) -> Unit {
  if scene == Fight {
    (self.draw._)(x, y, 3)
  } else if scene == World {
    if self.name == Pumpkin {
      (self.draw._)(x, y, 4)
      return
    }
    (self.draw._)(x, y, 1)
  }
}

fn EnemyStatus::pos(self : EnemyStatus, x : Int, y : Int) -> Unit {
  self.map_pos.x = x
  self.map_pos.y = y
}

fn EnemyStatus::round_reset(self : EnemyStatus) -> Unit {
  self.round = Default
  self.finish = 0
  game.r_time = 0
  round.rng = -1
  player.battle = Default
  self.draw(x=self.round_pos.x, y=self.round_pos.y, Fight)
  round.status = "player"
}

fn EnemyStatus::default() -> EnemyStatus {
  {
    hp: 0,
    level: 0,
    round: Default,
    battle: Default,
    max_hp: 0,
    name: None,
    attack: 0,
    defense: 0,
    finish: 0,
    map_pos: Coordinate::{ x: 0, y: 0 },
    round_pos: Coordinate::{ x: 0, y: 0 },
    hitbox: { width: 0, height: 0 },
    draw: @lib.draw_default,
    skill: Skill::{
      anime_time: 30,
      anime: default_anime,
      damage: 0,
      critical: 0,
    },
    ai: default_ai,
  }
}

fn EnemyStatus::sheep(
  map_x : Int,
  map_y : Int,
  level : Int,
  maxh : Int
) -> EnemyStatus {
  {
    hp: maxh,
    level,
    round: Default,
    battle: Default,
    max_hp: maxh,
    name: Sheep,
    attack: 0,
    defense: 0,
    finish: 0,
    map_pos: Coordinate::{ x: map_x, y: map_y },
    round_pos: Coordinate::{ x: 110, y: 36 },
    hitbox: { width: 12, height: 7 },
    draw: @lib.draw_sheep,
    skill: Skill::{
      anime_time: 30,
      anime: stampede,
      damage: 3 * level,
      critical: 5 * @math.minimum(2, level),
    },
    ai: sheep_ai,
  }
}

fn EnemyStatus::pumpkin(map_x : Int, map_y : Int) -> EnemyStatus {
  {
    hp: 108,
    level: 108,
    round: Default,
    battle: Default,
    max_hp: 108,
    name: Pumpkin,
    attack: 0,
    defense: 0,
    finish: 0,
    map_pos: Coordinate::{ x: map_x, y: map_y },
    round_pos: Coordinate::{ x: 110, y: 36 },
    hitbox: { width: 30, height: 30 },
    draw: @lib.draw_pumpkin,
    skill: Skill::{ anime_time: 30, anime: stampede, damage: 5, critical: 0 },
    ai: pumpkin_ai,
  }
}
// let pumpkin : EnemyStatus = {
//   hp: 200,
//   round: Default,
//   battle: Default,
//   danger: Normal,
//   anime: { "stampede": 30 },
//   max_hp: 200,
//   name: Pumpkin,
//   attack: 0,
//   defense: 0,
//   finish: 0,
//   hitbox: { width: 0, height: 0 },
//   xpos: 0,
//   ypos: 0,
// }
