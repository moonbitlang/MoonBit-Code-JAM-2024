struct Ai{
  mut skill_state:Bool
  mut fight_state:Bool
  mut run_state:Int
  mut defend_state:Bool
  mut jump_state:Bool
  ai:Bool
  prob:Prob
  rng : @random.Rand
  think_time:Int
  mut think_state:Bool
}
struct Prob{
  mut prob1:Int
  mut prob2:Int
  mut prob3:Int
  mut prob4:Int
  mut prob5:Int}//jump
let pro:Prob={prob1:10,prob2:30,prob3:10,prob4:50,prob5:20}
struct Ti {
  mut t:Int
}
let ti1:Ti={t:0}
let player_a:Ai={skill_state:false,fight_state:false,run_state:0,defend_state:false,jump_state:false,ai:false,prob:pro,rng:@random.new(),think_time:60,think_state:false}
let player_a1:Ai={skill_state:false,fight_state:false,run_state:0,defend_state:false,jump_state:false,ai:true,prob:pro,rng:@random.new(),think_time:30,think_state:false}
let player_a2:Ai={skill_state:false,fight_state:false,run_state:0,defend_state:false,jump_state:false,ai:true,prob:pro,rng:@random.new(),think_time:30,think_state:false}
let player_a3:Ai={skill_state:false,fight_state:false,run_state:0,defend_state:false,jump_state:false,ai:true,prob:pro,rng:@random.new(),think_time:30,think_state:false}
let player_a4:Ai={skill_state:false,fight_state:false,run_state:0,defend_state:false,jump_state:false,ai:true,prob:pro,rng:@random.new(),think_time:30,think_state:false}

// fn strength(prob:Int)->Bool {
//   if @random.int(player_a1.rng)%100>=player_a1.prob{
//   return true
//   }
//   else {
//   return false
//   }
  
// }
fn ai_think()->Unit{
if player_a2.think_state{
  ti1.t+=1
if ti1.t==player_a2.think_time{
  ti1.t=0
if @random.int(player_a1.rng)%100>=player_a2.prob.prob1{player_a2.skill_state=false}
else{player_a2.skill_state=true}//技能
if @random.int(player_a1.rng)%100>=player_a2.prob.prob2{player_a2.fight_state=false}
else{player_a2.fight_state=true}//攻击
if @random.int(player_a2.rng)%100>player_a2.prob.prob3{player_a2.defend_state=false}
else{player_a2.defend_state=true}//防御
if @random.int(player_a3.rng)%100>=player_a2.prob.prob4{player_a2.run_state=0}
else{if @random.int(player_a2.rng)%50>=25{
// @wasm4.text("\{@random.int(player_a2.rng)%50}",10,30)
player_a2.run_state=1}
else{player_a2.run_state=2}}//左右移动
if @random.int(player_a4.rng)%100>=player_a2.prob.prob5{player_a2.jump_state=false}
else{player_a2.jump_state=true}//跳跃
player_a2.think_state=false}}
if not(player_a2.think_state){
  ti1.t+=1
if ti1.t==player_a2.think_time{
  ti1.t=0
player_a2.think_state=true}}}
fn ai_run()->Unit{
  
    if aiplayer.ai.run_state==2&&not(aiplayer.ai.think_state)&& aiplayer.pos.x + 20 < 160{
    if aiplayer.pos.y+35<player1.pos.y||aiplayer.pos.y-35>player1.pos.y{aiplayer.pos.x += aiplayer.playermodel.speed}
    else{if aiplayer.direction{ aiplayer.pos.x += aiplayer.playermodel.speed}
    else{if aiplayer.pos.x<player1.pos.x-20{ aiplayer.pos.x += aiplayer.playermodel.speed}}
    }
    
  } 
  // else if @wasm4.get_gamepad(index=2).button_up&& player2.pos.y >=35{
  //  if player2.pos.y>=125{
  //   phy.v=-15.0
  //   phy.t=0.0}
  // }
  
  // else if player2.ai.run_state==1&&not(player2.ai.think_state)&& player2.pos.x + 20 < 160{
  //   if player2.pos.y+35<player1.pos.y||player2.pos.y-35>player1.pos.y{player2.pos.x += player2.playermodel.speed}
  //   else{if player2.direction{ player2.pos.x -= player2.playermodel.speed}
  //   else{if player2.pos.x<player1.pos.x-20{ player2.pos.x -= player2.playermodel.speed}}}
  // } 
  // else if @wasm4.get_gamepad(index=2).button_up&& player2.pos.y >=35{
  //  if player2.pos.y>=125{
  //   phy.v=-15.0
  //   phy.t=0.0}
  // }
  else if aiplayer.ai.run_state==1&&not(aiplayer.ai.think_state)&& aiplayer.pos.x >= 0{
     if aiplayer.pos.y+35<player1.pos.y||aiplayer.pos.y-35>player1.pos.y{aiplayer.pos.x -= aiplayer.playermodel.speed}
    else{if not(aiplayer.direction){ aiplayer.pos.x -= aiplayer.playermodel.speed}
    else{if aiplayer.pos.x>player1.pos.x+20{ aiplayer.pos.x -= aiplayer.playermodel.speed}}}
  }

  //   else{if player2.ai.run_state==2&&not(player2.ai.think_state)&& player2.pos.x + 20 < 160{
  //   if player2.pos.y+35<player1.pos.y||player2.pos.y-35>player1.pos.y{player2.pos.x += player2.playermodel.speed}
  //   else{if player2.direction{ player2.pos.x -= player2.playermodel.speed}
  //   else{if player2.pos.x<player1.pos.x-20{ player2.pos.x += player2.playermodel.speed}}}
  // } }}
  }