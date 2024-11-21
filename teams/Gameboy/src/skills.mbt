enum Skills {
  Dash
  Cure
  Fly
  Angry
}

struct Rush {
  mut t1_1 : Bool
  mut t1_2 : Bool
  mut t2 : Bool
}

let rush : Rush = { t1_1: true, t1_2: true, t2: true}

fn skills(player : Player, player_ : Player) -> Unit {
  if player.cd.s2_cd == player.cd.s1_cd {
    player.cd.s2_cd = 0
  } else if player.cd.s2_cd == 0 {
    // else if player.cd.s2_cd == 1 {} 
  } else {
    player.cd.s2_cd += 1
  }
  match player.playermodel.skill {
    Dash =>{
      if player.ai.ai {
        if player.p {
          if player.state == 0 {
            if player.direction {
              rush.t1_1 = true
            } else {
              rush.t1_1 = false
            }
          }
          if player_a2.skill_state && not(player2.ai.think_state) {
            if player.cd.s2_cd == 0 {
              player.cd.s2_cd += 1
              player.state = 1
            }
          }
          
        } else {
          if player.state == 0 {
            if player.direction {
              rush.t1_2 = true
            } else {
              rush.t1_2 = false
            }
          }
          if player_a2.skill_state && not(player2.ai.think_state) {
            if player.cd.s2_cd == 0 {
              player.cd.s2_cd += 1
              player.state = 1
            }
          }
          
        }
      } else if player.p {
        if player.state == 0 {
          if player.direction {
            rush.t1_1 = true
          } else {
            rush.t1_1 = false
          }
        }
        if @wasm4.get_gamepad(index=player.key).button_2 &&
          not(@wasm4.get_gamepad(index=player.key).button_down) {
          if player.cd.s2_cd == 0 {
            player.cd.s2_cd += 1
            player.state = 1
          }
        }
        if player.state == 1 {
          rush_m()
          if rush.t1_1 {
            player.pos.x -= 4
          } else {
            player.pos.x += 4
          }
          dash(player, player_)
        }
      } else {
        if player.state == 0 {
          if player.direction {
            rush.t1_2 = true
          } else {
            rush.t1_2 = false
          }
        }
        if @wasm4.get_gamepad(index=player.key).button_2 &&
          not(@wasm4.get_gamepad(index=player.key).button_down) {
          if player.cd.s2_cd == 0 {
            player.cd.s2_cd += 1
            player.state = 1
          }
        }
        if player.state == 1 {
          rush_m()
          if rush.t1_2 {
            player.pos.x -= 4
          } else {
            player.pos.x += 4
          }
          dash(player, player_)
        }
      }}
    Cure =>{
      if player.ai.ai {
        if player_a2.skill_state && not(player2.ai.think_state) {
          if player.cd.s2_cd == 0 {
            player.cd.s2_cd += 1
            player.state = 2
          }
        }
        
      } else {
        if @wasm4.get_gamepad(index=player.key).button_2 &&
          not(@wasm4.get_gamepad(index=player.key).button_down) {
          if player.cd.s2_cd == 0 {
            player.cd.s2_cd += 1
            player.state = 2
          }
        }
        
      }
      if player.state == 2 {
          if player.hp < 25 {
            cure()
            if player.hp <= 22 {
              player.hp += player.demage.skill
            } else {
              player.hp = 25
            }
          }
          player.state = 0
        }}
    Fly =>
      if player.ai.ai {
        if not(player.f_live) {
          if player_a2.skill_state && not(player2.ai.think_state) {
            // if player.f_live{player.pos.x=player.f_state.x
            //     player.pos.y=player.f_state.y}  
            if player.cd.s2_cd == 0 {
              player.cd.s2_cd += 1
              player.f_state.x = player.pos.x
              player.f_state.y = player.pos.y
              player.f_live = true
            }
          }
        } else if player_a2.skill_state && not(player2.ai.think_state) {
          if player.cd.s2_cd == 0 {
            player.cd.s2_cd += 1
            player.pos.x = player.f_state.x
            player.pos.y = player.f_state.y
            player.f_live = false
          }
        }
        if player.f_live {
          @wasm4.rect(player.f_state.x + 8, player.f_state.y + 30, 5, 5)
        }
      } else {
        if not(player.f_live) {
          if @wasm4.get_gamepad(index=player.key).button_2 &&
            not(@wasm4.get_gamepad(index=player.key).button_down) {
            // if player.f_live{player.pos.x=player.f_state.x
            //     player.pos.y=player.f_state.y}  
            if player.cd.s2_cd == 0 {
              player.cd.s2_cd += 1
              player.f_state.x = player.pos.x
              player.f_state.y = player.pos.y
              player.f_live = true
            }
          }
        } else if @wasm4.get_gamepad(index=player.key).button_2 &&
          not(@wasm4.get_gamepad(index=player.key).button_down) {
          if player.cd.s2_cd == 0 {
            player.cd.s2_cd += 1
            player.pos.x = player.f_state.x
            player.pos.y = player.f_state.y
            player.f_live = false
          }
        }
        if player.f_live {
          @wasm4.rect(player.f_state.x + 8, player.f_state.y + 30, 5, 5)
        }
      }
    Angry =>
      if player.ai.ai {
        //  @wasm4.text("Power:\{player.demage.fight}",player.pos.x-16 , player.pos.y -10 )
        if player_a2.skill_state && not(player2.ai.think_state) {
          if player.cd.s2_cd == 0 {
            player.cd.s2_cd += 1
            player.state = 1
          }
        }
        if player.state == 1 {
          angry()
          player.hp = player.hp / 2
          player.demage.fight += 10
          player.state = 0
        }
      } else {
        if @wasm4.get_gamepad(index=player.key).button_2 &&
          not(@wasm4.get_gamepad(index=player.key).button_down) {
          if player.cd.s2_cd == 0 {
            player.cd.s2_cd += 1
            player.state = 1
          }
        }
        if player.state == 1 {
          angry()
          player.hp = player.hp / 2
          player.demage.fight += 10
          player.state = 0
        }
      }
  }
}
