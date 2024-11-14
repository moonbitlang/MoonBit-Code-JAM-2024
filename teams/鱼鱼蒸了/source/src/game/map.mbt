struct World {
  enemylist : Array[EnemyStatus]
  borderlist : Array[Tree]
  heallist : Array[Tree]
  // mut borderlist: Array[String]
  // relative : Coordinate
  absolute : Coordinate
}

struct Tree {
  map_pos : Coordinate
  draw : @lib.DrawEnemy
  mut lvl : Int
}

struct Coordinate {
  mut x : Int
  mut y : Int
}

struct HitBox {
  width : Int
  height : Int
}

fn World::new() -> World {
  let tree_list : Array[Tree] = Array::new()
  let enemy_list : Array[EnemyStatus] = Array::new()
  let medic_list : Array[Tree] = Array::new()
  if game.scene == World {
    let mut line : Int = 0
    let mut lvl : Int = 1
    let mut flag1 : Bool = true
    let mut flag2 : Bool = true
    for i = 50; i < 1000; i = i + 14 {
      line += 1
      for j = 0; j < 210; j = j + 50 {
        if j == 50 {
          let r = @random.new(seed=sed[(game.g_time + line) % 9])
          game.g_time += 1
          game.rng = r.int(limit=101)
          if line == 1 {
            if game.rng % 4 < 2 {
              enemy_list.push(
                EnemyStatus::sheep(i + 15 + game.rng % 7, 30, lvl, 10 * lvl),
              )
            } else {
              medic_list.push(
                Tree::{
                  map_pos: Coordinate::{ x: i + 15 + game.rng % 7, y: 30 },
                  draw: @lib.draw_heal,
                  lvl,
                },
              )
            }
          }
          if line == 10 {
            if game.rng % 5 == 0 || game.rng % 5 == 3 || game.rng % 5 == 2 {
              flag1 = false
            }
          }
          if flag1 {
            tree_list.push(
              Tree::{
                map_pos: Coordinate::{ x: i, y: j },
                draw: @lib.draw_tree,
                lvl: i,
              },
            )
          }
          if line == 15 {
            flag1 = true
          }
        } else if j == 100 {
          let r = @random.new(seed=sed[(game.g_time + line) % 9])
          game.g_time += 1
          game.rng = r.int(limit=101)
          if line == 1 {
            if game.rng % 2 == 0 {
              enemy_list.push(
                EnemyStatus::sheep(i + 15 + game.rng % 15, 80, lvl, 10 * lvl),
              )
            } else {
              medic_list.push(
                Tree::{
                  map_pos: Coordinate::{ x: i + 15 + game.rng % 7, y: 80 },
                  draw: @lib.draw_heal,
                  lvl,
                },
              )
            }
          }
          if line == 10 {
            if game.rng % 4 == 0 || game.rng % 4 == 3 {
              flag2 = false
            }
          }
          if flag2 {
            tree_list.push(
              Tree::{
                map_pos: Coordinate::{ x: i, y: j },
                draw: @lib.draw_tree,
                lvl: i,
              },
            )
          }
          if line == 15 {
            lvl += 1
            line = 0
            flag2 = true
          }
        } else {
          if j == 150 {
            if line == 1 {
              enemy_list.push(
                EnemyStatus::sheep(i + 15 + game.rng % 30, 130, lvl, 10 * lvl),
              )
            }
          }
          tree_list.push(
            Tree::{
              map_pos: Coordinate::{ x: i, y: j },
              draw: @lib.draw_tree,
              lvl: i,
            },
          )
        }
      }
    }
  }
  enemy_list.push(EnemyStatus::pumpkin(1020, 80))
  return {
    enemylist: enemy_list,
    borderlist: tree_list,
    heallist: medic_list,
    // relative: Coordinate::{ x: 0, y: 0 },
    absolute: Coordinate::{ x: 0, y: 0 },
  }
}

fn Tree::draw(
  self : Tree,
  ~x : Int = self.map_pos.x,
  ~y : Int = self.map_pos.y,
  scene : Scene
) -> Unit {
  if scene == Fight {
    (self.draw._)(x, y, 3)
  } else if scene == World {
    (self.draw._)(x, y, 2)
  }
}

fn World::generate() -> Unit {
  for k in world.wld.enemylist {
    if k.hp <= 0 {
      if k.name == Pumpkin {
        game.scene = Finish
        return
      }
      continue
    } else {
      k.draw(
        World,
        x=k.map_pos.x - world.wld.absolute.x,
        y=k.map_pos.y - world.wld.absolute.y,
      )
    }
  }
  for k in world.wld.borderlist {
    k.draw(
      World,
      x=k.map_pos.x - world.wld.absolute.x,
      y=k.map_pos.y - world.wld.absolute.y,
    )
  }
  for k in world.wld.heallist {
    if k.lvl == 0 {
      continue
    }
    k.draw(
      World,
      x=k.map_pos.x - world.wld.absolute.x,
      y=k.map_pos.y - world.wld.absolute.y,
    )
  }
  draw_hero(
    player.map_pos.x - world.wld.absolute.x,
    player.map_pos.y - world.wld.absolute.y,
  )
  if game.scene == World {
    check_collision()
    check_medic_collision()
  }
}

fn World::fight_anime() -> Unit {
  if game.a_time >= 180 {
    game.scene = Fight
    battle(round.enemy)
    game.a_time = 0
    return
  }
  if game.a_time <= 70 {
    generate()
    @wasm.set_draw_colors(3, index=2)
    for i = 0; i <= 160; i = i + 8 {
      for k = 0; k < 4; k = k + 1 {
        for j = 0; j < game.a_time * 4; j = j + 1 {
          @lib.draw_pixel(i + k, j)
          @lib.draw_pixel(i + k + 4, 160 - j)
        }
      }
    }
  } else if game.a_time <= 110 {
    two_color(3, 3)
    @wasm.rect(0, 0, 160, 160)
    enemy_small(round.enemy)
  } else {
    battle(round.enemy)
    @wasm.set_draw_colors(3, index=2)
    for i = 0; i <= 160; i = i + 8 {
      for k = 0; k < 4; k = k + 1 {
        for j = 0; j < (180 - game.a_time) * 4; j = j + 1 {
          @lib.draw_pixel(i + k + 4, j)
          @lib.draw_pixel(i + k, 160 - j)
        }
      }
    }
  }
  game.a_time += 1
}

// 伪碰撞箱检测
fn check_collision() -> Unit {
  for k in world.wld.enemylist {
    if (
        player.map_pos.x + 8 <= k.map_pos.x ||
        player.map_pos.x >= k.map_pos.x + k.hitbox.width
      ) ||
      player.map_pos.y + 8 <= k.map_pos.y ||
      player.map_pos.y >= k.map_pos.y + k.hitbox.height {
      continue
    } else if k.hp > 0 {
      game.lscene = World
      game.scene = FightAnime
      game.r_time = 0
      round.enemy = k
      return
    }
  }
}

fn check_medic_collision() -> Unit {
  for k in world.wld.heallist {
    if (
        player.map_pos.x + 8 <= k.map_pos.x ||
        player.map_pos.x >= k.map_pos.x + 4
      ) ||
      player.map_pos.y + 8 <= k.map_pos.y ||
      player.map_pos.y >= k.map_pos.y + 4 {
      continue
    } else if k.lvl != 0 {
      game.lscene = game.scene
      game.scene = Bonus
      game.bscene = Heal
      bonus_time.tenzor = k.lvl
      k.lvl = 0
    }
  }
}

fn check_border_collision(x : Int, y : Int) -> Bool {
  for k in world.wld.borderlist {
    if (x + 8 <= k.map_pos.x || x >= k.map_pos.x + 14) ||
      y + 8 <= k.map_pos.y ||
      y >= k.map_pos.y + 14 {
      continue
    } else {
      return false
    }
  }
  return true
}

fn enemy_small(self : EnemyStatus) -> Unit {
  two_color(1, 3)
  // @wasm.text()
  @wasm.rect(40, 40, 70, 60)
  two_color(2, 0)
  @wasm.text(self.name.to_string(), 45, 60)
  (self.draw._)(70, 80, 1)
}
