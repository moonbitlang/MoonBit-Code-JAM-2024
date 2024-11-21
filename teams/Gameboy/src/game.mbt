struct Entities {
  // mut a :Int
  //  character : Array[Character]
  // flyers : Array[Flayer]
   mut scene : Scene
  //  player:Player
  // pressedpad : @w4x.PressedPad//按键
  // mut levels : Array[Level]//敌人等级
  // mut level_idx : Int
  // random_state : @random.Rand
}

struct Game{
 mut  mod:Int
}
let game1:Game={mod:1}
let game2:Game={mod:2}
fn game_init()->Unit{
  move(player1,player2)
  if game1.mod==1{
  player1.cd.s1_cd=player1.playermodel.cd.s1_cd
  player1.cd.f1_cd=player1.playermodel.cd.f1_cd
  player1.cd.d1_cd=player1.playermodel.cd.d1_cd
  player1.cd.s2_cd=player1.playermodel.cd.s2_cd
  player1.cd.f2_cd=player1.playermodel.cd.f2_cd
  player1.cd.d2_cd=player1.playermodel.cd.d2_cd
  player1.hp=player1.playermodel.hp 
  player1.demage.fight=player1.playermodel.demage.fight
  player2.cd.s1_cd=player2.playermodel.cd.s1_cd
  player2.cd.f1_cd=player2.playermodel.cd.f1_cd
  player2.cd.d1_cd=player2.playermodel.cd.d1_cd
  player2.cd.s2_cd=player2.playermodel.cd.s2_cd
  player2.cd.f2_cd=player2.playermodel.cd.f2_cd
  player2.cd.d2_cd=player2.playermodel.cd.d2_cd
  player2.hp=player2.playermodel.hp 
  player2.demage.fight=player2.playermodel.demage.fight
  game1.mod=0}
  
    // player1.pos.y=jump(124)
    if @wasm4.get_gamepad(index=1).button_right && player1.pos.x + 20 < 160{
    if player1.pos.y+35<player2.pos.y||player1.pos.y-35>player2.pos.y{player1.pos.x += player1.playermodel.speed}
    else{if player1.direction{ player1.pos.x += player1.playermodel.speed}
         else{if player1.pos.x<player2.pos.x-20{ player1.pos.x += player1.playermodel.speed}}}
  } 
 
    else if @wasm4.get_gamepad(index=1).button_left && player1.pos.x >= 0{
    if player1.pos.y+35<player2.pos.y||player1.pos.y-35>player2.pos.y{player1.pos.x -= player1.playermodel.speed}
    else{if not(player1.direction){ player1.pos.x -= player1.playermodel.speed}
    else{if player1.pos.x>player2.pos.x+20{ player1.pos.x -= player1.playermodel.speed}}}
  }
   fightpvp(player1)
   skills(player1,player2)
   defend(player1)
   jump(player1,player2,phy1)

  // if player1.hp<=0{
  //   @wasm4.text("P2 Win!",52,88)
  // }
  // if player2.hp<=0{
  //   ent.scene=Victory}
//////////////////////////////////////////////////////////
    // player2.pos.y=jump(124)
  if @wasm4.get_gamepad(index=2).button_right&& player2.pos.x + 20 < 160{
    if player2.pos.y+35<player1.pos.y||player2.pos.y-35>player1.pos.y{player2.pos.x += player2.playermodel.speed}
    else{if player2.direction{ player2.pos.x += player2.playermodel.speed}
    else{if player2.pos.x<player1.pos.x-20{ player2.pos.x += player2.playermodel.speed}}}
  } 
  // else if @wasm4.get_gamepad(index=2).button_up&& player2.pos.y >=35{
  //  if player2.pos.y>=125{
  //   phy.v=-15.0
  //   phy.t=0.0}
  // }
  else if @wasm4.get_gamepad(index=2).button_left && player2.pos.x >= 0{
     if player2.pos.y+35<player1.pos.y||player2.pos.y-35>player1.pos.y{player2.pos.x -= player2.playermodel.speed}
    else{if not(player2.direction){ player2.pos.x -= player2.playermodel.speed}
    else{if player2.pos.x>player1.pos.x+20{ player2.pos.x -= player2.playermodel.speed}}}
  }
   fightpvp(player2)
   skills(player2,player1)
   defend(player2)
   jump(player2,player1,phy2)
  if player2.hp<=0{
    ent.scene=Victory1
  }
  if player1.hp<=0{
    ent.scene=Victory2
  }
  
}