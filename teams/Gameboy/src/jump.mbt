let phy1 : Physic = { x_v: 0,y_v:0, g: 10, x: 125.0, t: 0.0 }
let phy2 : Physic = { x_v: 0,y_v:0, g: 10, x: 125.0, t: 0.0 }
fn jump(player:Player,player_:Player,phy:Physic)->Unit{
  if player.ai.ai{if player.playermodel.sprite.data==dragon_sprite.data{}
  else{if player_a2.jump_state&&not(player2.ai.think_state){
  if phy.x>=125{phy.x=124
  phy.y_v=-player.playermodel.jump
  phy.t=0.0}}
  // @wasm4.rect(30, phy.x.to_int(),10,10)
  if phy.x<125{      
//   @wasm4.text("\{phy.t}",10,10)
//    player1.playermodel.demage.fight
// @wasm4.text("\{player_.pos.y}",10,30)
        phy.t=0.1
  if player.direction{if player.pos.x+15>player_.pos.x&&player.pos.x-15<player_.pos.x&&player.pos.y>player_.pos.y-37&&player.pos.y<player_.pos.y-33{phy.y_v=-player.playermodel.jump/2
  if player.pos.x>=85{}
  else{}
  }} 
  else{if player.pos.x+15>player_.pos.x&&player.pos.x-15<player_.pos.x&&player.pos.y>player_.pos.y-37&&player.pos.y<player_.pos.y-33{phy.y_v=-player.playermodel.jump/2
  if player.pos.x<=40{}
  else{}
  }}
  //  if @wasm4.get_gamepad(index=player.key).button_down{phy.x=0}     
  //  if phy.t==120{phy.t=0}
   phy.x_v=phy.x_v+phy.g*phy.t
   phy.y_v=phy.y_v+phy.g*phy.t
   phy.x+=phy.y_v*phy.t
   }
   if phy.x.to_int()>=125{
    phy.x=125
   }
   player.pos.y=phy.x.to_int()}}
  
  else{if @wasm4.get_gamepad(index=player.key).button_up{
  if phy.x>=125{phy.x=124
  phy.y_v=-player.playermodel.jump
  phy.t=0.0}}
  // @wasm4.rect(30, phy.x.to_int(),10,10)
  if phy.x<125{      
//   @wasm4.text("\{phy.t}",10,10)
//    @wasm4.text("\{player1.pos.y}",10,20)
// @wasm4.text("\{player_.pos.y}",10,30)
        phy.t=0.1
  if player.direction{if player.pos.x+15>player_.pos.x&&player.pos.x-15<player_.pos.x&&player.pos.y>player_.pos.y-37&&player.pos.y<player_.pos.y-33{phy.y_v=-player.playermodel.jump/2
  if player.pos.x>=85{}
  else{}
  }} 
  else{if player.pos.x+15>player_.pos.x&&player.pos.x-15<player_.pos.x&&player.pos.y>player_.pos.y-37&&player.pos.y<player_.pos.y-33{phy.y_v=-player.playermodel.jump/2
  if player.pos.x<=40{}
  else{}
  }}
  //  if @wasm4.get_gamepad(index=player.key).button_down{phy.x=0}     
  //  if phy.t==120{phy.t=0}
   phy.x_v=phy.x_v+phy.g*phy.t
   phy.y_v=phy.y_v+phy.g*phy.t
   phy.x+=phy.y_v*phy.t
   }
   if phy.x.to_int()>=125{
    phy.x=125
   }
   player.pos.y=phy.x.to_int()}
  
}