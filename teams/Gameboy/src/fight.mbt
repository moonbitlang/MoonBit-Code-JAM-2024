fn fightpvp(player : Player) -> Unit {
  if player.cd.f2_cd == player.cd.f1_cd {
    player.cd.f2_cd = 0
  } else if player.cd.f2_cd == 0 {

  } else {
    player.cd.f2_cd += 1
  }
  // if @wasm4.get_gamepad(index=1).button_1&& not(@wasm4.get_gamepad(index=1).button_down){

  //         if player.cd.f2_cd ==0{
  //            player.cd.f2_cd+=1
  //            player.f_state.x=player.pos.x
  //            player.f_state.y=player.pos.y+10
  //            player.f_live=true
  if player.p {
    fight1(player, player2)
  } else {
    fight1(player, player1)
  }
  

}
fn fightpve(player : Player) -> Unit {
  if player.cd.f2_cd == player.cd.f1_cd {
    player.cd.f2_cd = 0
  } else if player.cd.f2_cd == 0 {

  } else {
    player.cd.f2_cd += 1
  }
  // if @wasm4.get_gamepad(index=1).button_1&& not(@wasm4.get_gamepad(index=1).button_down){

  //         if player.cd.f2_cd ==0{
  //            player.cd.f2_cd+=1
  //            player.f_state.x=player.pos.x
  //            player.f_state.y=player.pos.y+10
  //            player.f_live=true
  if player.p {
    fight1(player, aiplayer)
  } else {
    fight1(player, player1)
  }
  

}

fn defend(player : Player) -> Unit {
  if player.cd.d2_cd == player.cd.d1_cd {
    player.cd.d2_cd = 0
    
  } else if player.cd.d2_cd >= 0 &&
    player.cd.d2_cd <= 60 {

  } else {
    player.if_defend=false
    player.cd.d2_cd += 1
  }
  if player.ai.ai{
    if player_a2.defend_state&&not(player2.ai.think_state){
      if player.cd.d2_cd >= 0 && player.cd.d2_cd <= 60 {
        player.cd.d2_cd += 1
        if player.direction{@wasm4.rect(player.pos.x, player.pos.y, 3, 35)}
        else{@wasm4.rect(player.pos.x + 20, player.pos.y, 3, 35)}
        player.if_defend=true
      }
      }}
      else{if @wasm4.get_gamepad(index=player.key).button_down &&
      not(@wasm4.get_gamepad(index=player.key).button_1) {
      if player.cd.d2_cd >= 0 && player.cd.d2_cd <= 60 {
        player.cd.d2_cd += 1
        if player.direction{@wasm4.rect(player.pos.x, player.pos.y, 3, 35)}
        else{@wasm4.rect(player.pos.x + 20, player.pos.y, 3, 35)}
        player.if_defend=true
      }}}
    
}

struct Physic {
  mut x_v : Double
  mut y_v : Double
  g : Double
  mut x : Double
  mut t : Double
}

fn fight1(player : Player, player_ : Player) -> Unit {
  // match player.playermodel.fight{
  // Short=>@wasm4.rect(player.pos.x-20, player.pos.y+10, 15, 5)
  // Long=>@wasm4.rect(player.pos.x-20, player.pos.y+10, 15, 5)
  // }
  match player.playermodel.fight {
    Bullet => {
      if player.ai.ai{if player_a2.fight_state&&not(player2.ai.think_state){
        if player.direction{rush.t2=true}
        else{rush.t2=false}
        if player.cd.f2_cd == 0 {
          player.cd.f2_cd += 1
          player.f_state.x = player.pos.x
          player.f_state.y = player.pos.y + 10
          player.f_live = true
        }
      }
      if player.f_live == true {
        hit(player, player_)
        
        if rush.t2 {player.f_state.x -= 2
        } else {player.f_state.x += 2}
        
        @wasm4.rect(player.f_state.x,player.f_state.y,5,
          5,
        )
      }}
      else{
        if @wasm4.get_gamepad(index=player.key).button_1 &&
        not(@wasm4.get_gamepad(index=player.key).button_down) {
        if player.direction{rush.t2=true}
        else{rush.t2=false}
        if player.cd.f2_cd == 0 {
          player.cd.f2_cd += 1
          player.f_state.x = player.pos.x
          player.f_state.y = player.pos.y + 10
          player.f_live = true
        }
      }
      if player.f_live == true {
        hit(player, player_)
        
        if rush.t2 {player.f_state.x -= 2
        } else {player.f_state.x += 2}
        
        @wasm4.rect(player.f_state.x,player.f_state.y,5,
          5,
        )
      }
    }}
    Fist =>
    if player.ai.ai{if player_a2.fight_state&&not (player2.if_defend) {
        if player.cd.f2_cd == 0 {
          player.cd.f2_cd += 1
          if player.direction{@wasm4.rect(player.pos.x-20, player.pos.y + 10, 20, 5)
          if player.pos.x - 20 <= player_.pos.x&&player.pos.y<=player_.pos.y+35&&player.pos.y>=player_.pos.y{
            if not (player_.if_defend)||not(@wasm4.get_gamepad(index=player_.key).button_down){
              fight_m()
              player_.hp-=player.demage.fight}}
            }
          else{@wasm4.rect(player.pos.x + 20, player.pos.y + 10, 20, 5)
          if player.pos.x + 40 >= player_.pos.x &&player.pos.y<=player_.pos.y+35&&player.pos.y>=player_.pos.y{
            if not (player_.if_defend)||not(@wasm4.get_gamepad(index=player_.key).button_down){
              fight_m()
              player_.hp-=player.demage.fight}}
            
      }}}}
    else{if @wasm4.get_gamepad(index=player.key).button_1 &&
        not(@wasm4.get_gamepad(index=player.key).button_down) {
        if player.cd.f2_cd == 0 {
          player.cd.f2_cd += 1
          if player.direction{@wasm4.rect(player.pos.x-20, player.pos.y + 10, 20, 5)
          if player.pos.x - 20 <= player_.pos.x&&player.pos.y<=player_.pos.y+35&&player.pos.y>=player_.pos.y{
            if not (player_.if_defend)||not(@wasm4.get_gamepad(index=player_.key).button_down){
              fight_m()
              player_.hp-=player.demage.fight}}
            }
          else{@wasm4.rect(player.pos.x + 20, player.pos.y + 10, 20, 5)
          if player.pos.x + 40 >= player_.pos.x &&player.pos.y<=player_.pos.y+35&&player.pos.y>=player_.pos.y{
            if not (player_.if_defend)||not(@wasm4.get_gamepad(index=player_.key).button_down){
              fight_m()
              player_.hp-=player.demage.fight}}
            
      }}}}
      
    Poke =>if player.ai.ai{if player_a2.fight_state&&not (player2.if_defend) {

        if player.cd.f2_cd == 0 {
          player.cd.f2_cd += 1
          if player.direction{if player.pos.x - 50 <= player_.pos.x &&player.pos.y<=player_.pos.y+35&&player.pos.y>=player_.pos.y{
            if not (player_.if_defend)||not(@wasm4.get_gamepad(index=player_.key).button_down){
              fight_m()
              player_.hp-=player.demage.fight}}
            @wasm4.rect(player.pos.x -30, player.pos.y + 10, 30, 5)
            @wasm4.tone_note_mode((@wasm4.Note::new(60, bend=0), None),@wasm4.ADSR::new(1),@wasm4.ADSRVolume::new(100), @wasm4.ToneFlag::new())}
          else{if player.pos.x + 50 >= player_.pos.x &&player.pos.y<=player_.pos.y+35&&player.pos.y>=player_.pos.y{
            if not (player_.if_defend)||not(@wasm4.get_gamepad(index=player_.key).button_down){
              fight_m()
              player_.hp-=player.demage.fight}}
            @wasm4.rect(player.pos.x + 20, player.pos.y + 10, 30, 5)
            @wasm4.tone_note_mode((@wasm4.Note::new(60, bend=0), None),@wasm4.ADSR::new(1),@wasm4.ADSRVolume::new(100), @wasm4.ToneFlag::new())}
        }
      }
    }
      else{if @wasm4.get_gamepad(index=player.key).button_1 &&
        not(@wasm4.get_gamepad(index=player.key).button_down) {

        if player.cd.f2_cd == 0 {
          player.cd.f2_cd += 1
          if player.direction{if player.pos.x - 50 <= player_.pos.x &&player.pos.y<=player_.pos.y+35&&player.pos.y>=player_.pos.y{
            if not (player_.if_defend)||not(@wasm4.get_gamepad(index=player_.key).button_down){
              fight_m()
              player_.hp-=player.demage.fight}}
            @wasm4.rect(player.pos.x -30, player.pos.y + 10, 30, 5)
            @wasm4.tone_note_mode((@wasm4.Note::new(60, bend=0), None),@wasm4.ADSR::new(1),@wasm4.ADSRVolume::new(100), @wasm4.ToneFlag::new())}
          else{if player.pos.x + 50 >= player_.pos.x &&player.pos.y<=player_.pos.y+35&&player.pos.y>=player_.pos.y{
            if not (player_.if_defend)||not(@wasm4.get_gamepad(index=player_.key).button_down){
              fight_m()
              player_.hp-=player.demage.fight}}
            @wasm4.rect(player.pos.x + 20, player.pos.y + 10, 30, 5)
            @wasm4.tone_note_mode((@wasm4.Note::new(60, bend=0), None),@wasm4.ADSR::new(1),@wasm4.ADSRVolume::new(100), @wasm4.ToneFlag::new())}
        }
      }}
    Bottle =>if player.ai.ai{
      if player_a2.fight_state&&not (player2.if_defend) {
        if player.direction{rush.t2=true}
        else{rush.t2=false} 
        if player.cd.f2_cd == 0 {
          player.cd.f2_cd += 1
          player.f_state.x = player.pos.x
          player.f_state.y = player.pos.y + 10
          player.f_live = true
        }
      }
      if player.f_live == true {
        p_hit(player, player_)
        if rush.t2 {player.f_state.x -= 1
        } else {player.f_state.x += 1}
        
        @wasm4.rect(player.f_state.x,player.f_state.y,10,
          5,
        )
      }}
    else{if @wasm4.get_gamepad(index=player.key).button_1 &&
        not(@wasm4.get_gamepad(index=player.key).button_down) {
        if player.direction{rush.t2=true}
        else{rush.t2=false} 
        if player.cd.f2_cd == 0 {
          player.cd.f2_cd += 1
          player.f_state.x = player.pos.x
          player.f_state.y = player.pos.y + 10
          player.f_live = true
        }
      }
      if player.f_live == true {
        p_hit(player, player_)
        if rush.t2 {player.f_state.x -= 1
        } else {player.f_state.x += 1}
        
        @wasm4.rect(player.f_state.x,player.f_state.y,10,
          5,
        )
      }
    }
  
}}
// fn fight2(player:Player,player_:Player)-> Unit{
//   match player.playermodel.fight{
//   Bullet=>@wasm4.rect(player.pos.x-20, player.pos.y+10, 15, 5)
//   Long=>@wasm4.rect(player.pos.x-20, player.pos.y+10, 15, 5)
//   }
// }

// // pub fn gravity(y:Int) ->Int{
// //   let mut y=y
// //   y=y+1
// //  }
// struct Point {
//   mut x : Int
//   mut y : Int
// }
// let en:Cd={cd:60,count:0}
// let e:Cd={cd:0,count:0}
// let p_pos : Point = { x: 16, y: 0}
// let e_pos : Point = { x: 106, y: 0}
// let palyer1 : Player = { hp :50, mp:100, pos:{ x:0,y:125 },fight_cd:1,skill_cd:10}
// let palyer2 : Player = { hp :50, mp:100, direction:{ x:140,y:125},fight_cd:1,skill_cd:10}
// let ent:Entities={scene:Welcome}
// ////let gamepad1 = @wasm4.get_gamepad() 
// // let ent:Entities={a:0}
// pub fn update() -> Unit {

//   if @wasm4.get_gamepad(index=1).button_1{ent.scene=Menus}
//   // if @wasm4.get_gamepad(index=1).button_1{ent.scene=Game1}
// // }
//   if m_cd.cd==30{m_cd.cd=0}
//   else if m_cd.cd==0{}
//   else {m_cd.cd+=1}
//   render_system(ent)
//   // if en.cd==60{en.cd=0}
//   // else if en.cd==0{}
//   // else {en.cd+=1}
//   // @wasm4.set_draw_colors(2, index=1)
//   // @wasm4.set_draw_colors(2, index=2)
//   // @wasm4.rect(palyer1.direction.x, palyer1.direction.y, 20, 35)
//   // @wasm4.rect(palyer2.direction.x, palyer2.direction.y, 20, 35)
//   // @wasm4.set_draw_colors(1,index=1)
//   // @wasm4.set_draw_colors(3, index=2)
//   // @wasm4.rect(e_pos.x, e_pos.y, 50, 5)
//   // @wasm4.rect(p_pos.x, p_pos.y, 50, 5)
//   // @wasm4.set_draw_colors(2,index=1)
//   // @wasm4.set_draw_colors(3, index=2)
//   // @wasm4.rect(e_pos.x, e_pos.y, palyer2.hp, 5)
//   // @wasm4.rect(p_pos.x, p_pos.y, palyer1.hp, 5)
//   // @wasm4.text("P1",0,0)
//   // @wasm4.text("P2",100,0)
//     if palyer1.direction.y<125{
//        palyer1.direction.y += 1
//     }

//   //@wasm4.rect(palyer1.direction.x+20, palyer1.direction.y+10, 15, 5)
//      if @wasm4.get_gamepad(index=1).button_right && palyer1.direction.x + 20 < 160 &&(palyer1.direction.x+20< palyer2.direction.x||palyer1.direction.y<= palyer2.direction.y-35) {
//     palyer1.direction.x += 1
//   // } else if @wasm4.get_gamepad(index=1).button_down && pos.y + 8 < 160 {
//   //   pos.y += 1
//   } 
//     else if @wasm4.get_gamepad(index=1).button_up&& palyer1.direction.y >=5{
//     if palyer1.direction.y>=125{palyer1.direction.y -= 50}

//     // palyer1.direction.y=y重力

//   }
//     else if @wasm4.get_gamepad(index=1).button_left && palyer1.direction.x >= 0 {
//     palyer1.direction.x -= 1
//   }
//   // } else if @wasm4.get_gamepad(index=1).button_up && pos.y >= 0 {
//   //   pos.y -= 1

//    if @wasm4.get_gamepad(index=1).button_down && palyer1.direction.x + 32 >= palyer2.direction.x&&palyer1.direction.y>= palyer2.direction.y{
//     if en.cd ==0{
//          en.cd+=1
//          palyer2.hp-= 10    
//          @wasm4.rect(palyer1.direction.x+20, palyer1.direction.y+10, 15, 5)   
//     }

//   }
//   if palyer1.hp<=0{
//     @wasm4.text("P2 Win!",52,88)
//   }
//   if palyer2.hp<=0{
//     ent.scene=Victory
//     // @wasm4.text("P1 Win!",52,88)
//   }
// }

// // pub fn input(self : Game) -> Unit {
// //   let gamepad = @wasm4.get_gamepad(index=1)
// //   if gamepad != self.prev_gamepad {
// //     // if gamepad.button_down {
// //     //   self.snake.down()
// //     // }
// //     // if gamepad.button_left {
// //     //   self.snake.left()
// //     // }
// //     // if gamepad.button_right {
// //     //   self.snake.right()
// //     // }
// //     // if gamepad.button_up {
// //     //   self.snake.up()
// //     // }
// //   }
// //   self.prev_gamepad = gamepad
// // }
