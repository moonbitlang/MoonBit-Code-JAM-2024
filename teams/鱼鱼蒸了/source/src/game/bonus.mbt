struct BonusLevel {
  control : LevelControl
  level : B_level
}

struct BonusTime {
  b_time : Array[Int]
  mut tenzor : Int
  mut level_time : Int
}

type B_level (Int, Int) -> Bool

let bonus_time : BonusTime = {
  b_time: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  tenzor: 0,
  level_time: 0,
}

let bonus_levels : Array[BonusLevel] = [
  { control: b0_control, level: bonus_0 },
  { control: b1_control, level: bonus_1 },
]

fn check_Bouns() -> Unit {
  match game.bscene {
    LevelUp => level_up()
    Heal => heal()
    None => return
  }
}

fn men() -> Unit {
  if game.konami == "uuddlrlrzx" && bonus_time.tenzor == 0 {
    game.konami = ""
    game.scene = Secret
    player.max_hp = 1024
    player.level = 19
    player.hp = player.max_hp
  }
  if bonus_time.tenzor >= 60 {
    bonus_time.tenzor = 0
    game.scene = game.lscene
  }
  two_color(2, 0)
  @wasm.text("You Find The Code!", 10, 50)
  @wasm.text("Health Full", 30, 90)
  @wasm.text("Level MAX", 30, 110)
  bonus_time.tenzor += 1
}

fn level_up() -> Unit {
  if bonus_time.level_time == 0 && player.level != 19 {
    bonus_time.level_time = game.g_time
    player.level = player.level + 1
    player.max_hp = player.max_hp + 50
    player.hp += 20
  }
  if game.g_time - bonus_time.level_time >= 30 || player.level == 19 {
    bonus_time.level_time = 0
    game.bscene = None
    game.scene = game.lscene
  }
  two_color(2, 0)
  @wasm.text("Level Up!", 60, 30)
  @wasm.text("MAX_HP UP!", 55, 60)
}

fn heal() -> Unit {
  if bonus_time.level_time == 0 {
    bonus_time.level_time = game.g_time
    player.hp = @math.minimum(player.max_hp, player.hp + 40)
  }
  if game.g_time - bonus_time.level_time >= 30 {
    bonus_time.level_time = 0
    game.bscene = None
    game.scene = game.lscene
    bonus_time.tenzor = 0
  }
  delete_enemy(bonus_time.tenzor)
  two_color(2, 0)
  @wasm.text("HP +40", 60, 80)
}

struct Pipe {
  pos : Coordinate
  hitbox : Coordinate
  move : Int
}

struct Circle {
  pos : Coordinate
  hitbox : Coordinate
  move : Int
  ud : Int
  mut catched : Bool
}

let b0_pipes : Array[Pipe] = Array::new()

let b1_shield : Pipe = {
  pos: { x: 70, y: 117 },
  hitbox: { x: 3, y: 13 },
  move: 0,
}

let b1_circle : Array[Circle] = Array::new()

fn b0_pipe_init(lvl : Int) -> Unit {
  b0_pipes.clear()
  let r = @random.new(seed=sed[game.g_time % 9])
  game.rng = r.int() % 10 + r.int(limit=lvl)
  if player.level == 19 {
    game.rng += 20
  }
  for i = 0; i < game.rng; i = i + 1 {
    b0_pipes.push(
      {
        pos: { x: -25 * (i + 1), y: 80 },
        hitbox: { x: 2, y: @math.maximum(70 - 4 * (i + 1), 35) },
        move: 1,
      },
    )
    b0_pipes.push(
      {
        pos: { x: 160 + 25 * (i + 1), y: @math.maximum(160 - 6 * (i + 1), 120) },
        hitbox: { x: 2, y: @math.maximum(6 * (i + 1), 50) },
        move: -1,
      },
    )
  }
}

let bonus_0 : B_level = fn(speed, lvl) -> Bool {
  if bonus_time.b_time[0] == 0 {
    player.bonus_pos.x = 85
    player.bonus_pos.y = 150
    bonus_time.b_time[0] = game.g_time
    b0_pipe_init(lvl)
  } else {
    for i = 0; i < b0_pipes.length(); i = i + 1 {
      if (game.g_time - bonus_time.b_time[0]) % (4 / speed) == 0 ||
        player.level == 19 {
        b0_pipes[i].pos.x += b0_pipes[i].move
      }
      two_color(3, 0)
      @wasm.rect(
        b0_pipes[i].pos.x,
        b0_pipes[i].pos.y,
        b0_pipes[i].hitbox.x,
        b0_pipes[i].hitbox.y,
      )
      if (
          player.bonus_pos.x + 8 <= b0_pipes[i].pos.x ||
          player.bonus_pos.x >= b0_pipes[i].pos.x + b0_pipes[i].hitbox.x
        ) ||
        player.bonus_pos.y + 8 <= b0_pipes[i].pos.y ||
        player.bonus_pos.y >= b0_pipes[i].pos.y + b0_pipes[i].hitbox.y {
        continue
      } else {
        bonus_time.b_time[0] = 0
        sound()
        return false
      }
    }
  }
  if b0_pipes[b0_pipes.length() - 1].pos.x <= 0 {
    return false
  }
  return true
}

fn b1_circle_init(lvl : Int) -> Unit {
  b1_circle.clear()
  let r = @random.new(seed=sed[game.g_time % 9])
  game.rng = r.int() % 10 + r.int(limit=lvl)
  if player.level == 19 {
    game.rng += 20
  }
  for i = 0; i < 2 * game.rng; i = i + 1 {
    // for i = 0; i < 1; i = i + 1 {
    let k = r.int()
    let dp = r.int() % 2
    let mut j : Int = 0
    if dp == 1 {
      if 2 * (k % 2) - 1 < 0 {
        j = 160 + 15 * (i + 1)
      } else {
        j = 0 - 15 * (i + 1)
      }
      b1_circle.push(
        {
          pos: { x: j, y: 120 },
          hitbox: { x: 4, y: 4 },
          move: 2 * (k % 2) - 1,
          catched: false,
          ud: 0,
        },
      )
    } else {
      if 2 * (k % 2) - 1 < 0 {
        j = 160 + 20 * (i + 1)
      } else {
        j = 80 - 20 * (i + 1)
      }
      b1_circle.push(
        {
          pos: { x: 75, y: j },
          hitbox: { x: 4, y: 4 },
          move: 2 * (k % 2) - 1,
          catched: false,
          ud: 1,
        },
      )
    }
  }
}

let bonus_1 : B_level = fn(speed, lvl) -> Bool {
  if bonus_time.b_time[1] == 0 {
    b1_circle_init(lvl)
    player.bonus_pos.x = 75
    player.bonus_pos.y = 120
    bonus_time.b_time[1] = game.g_time
  } else {
    let mut flag = false
    for i = 0; i < b1_circle.length(); i = i + 1 {
      if b1_circle[i].catched == false {
        flag = true
        if (game.g_time - bonus_time.b_time[1]) % (2 / speed) == 0 ||
          player.level == 19 {
          if b1_circle[i].ud == 0 {
            b1_circle[i].pos.x += b1_circle[i].move
          } else {
            b1_circle[i].pos.y += b1_circle[i].move
          }
        }
        two_color(2, 0)
        if b1_circle[i].pos.y < 80 {
          continue
        }
        @wasm.oval(
          b1_circle[i].pos.x,
          b1_circle[i].pos.y,
          b1_circle[i].hitbox.x,
          b1_circle[i].hitbox.y,
        )
        two_color(3, 0)
        @wasm.rect(
          b1_shield.pos.x,
          b1_shield.pos.y,
          b1_shield.hitbox.x,
          b1_shield.hitbox.y,
        )
        if (
            b1_shield.pos.x + b1_shield.hitbox.x <= b1_circle[i].pos.x ||
            b1_shield.pos.x >= b1_circle[i].pos.x + b1_circle[i].hitbox.x
          ) ||
          b1_shield.pos.y + b1_shield.hitbox.y <= b1_circle[i].pos.y ||
          b1_shield.pos.y >= b1_circle[i].pos.y + b1_circle[i].hitbox.y {

        } else {
          b1_circle[i].catched = true
          continue
        }
        if (
            player.bonus_pos.x + 8 <= b1_circle[i].pos.x ||
            player.bonus_pos.x >= b1_circle[i].pos.x + b1_circle[i].hitbox.x
          ) ||
          player.bonus_pos.y + 8 <= b1_circle[i].pos.y ||
          player.bonus_pos.y >= b1_circle[i].pos.y + b1_circle[i].hitbox.y {
          continue
        } else {
          bonus_time.b_time[1] = 0
          sound()
          return false
        }
      }
    }
    return flag
  }
  return true
}

let bonus_2 : B_level = fn(speed, lvl) -> Bool { return true }
