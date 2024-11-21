
fn game2_init()->Unit{
       bgm1(25,10)
 
  @wasm4.set_draw_colors(0, index=1)
  @wasm4.set_draw_colors(2, index=2)
  @wasm4.set_draw_colors(3, index=3)
  @wasm4.set_draw_colors(4, index=4)
  @wasm4.blit(
  @wasm4.sprite(player1.playermodel.sprite.data),player1.pos.x,player1.pos.y,
  player1.playermodel.sprite.width,
  player1.playermodel.sprite.height,
  @wasm4.BlitFlag::{
      one_bit_per_pixel: false,
      rotate: false,
      flip_x: player1.direction,
      flip_y: false,})
      if aiplayer.playermodel.sprite.data==mo_sprite.data{
        @wasm4.set_draw_colors(1,index=1)
        @wasm4.set_draw_colors(4, index=2)
        @wasm4.blit(
      @wasm4.sprite(aiplayer.playermodel.sprite.data),aiplayer.pos.x,aiplayer.pos.y,
      aiplayer.playermodel.sprite.height,
      aiplayer.playermodel.sprite.width,
      @wasm4.BlitFlag::{
      one_bit_per_pixel: true,
      rotate: false,
      flip_x: aiplayer.direction,
      flip_y: false,})}
      else{@wasm4.blit(
  @wasm4.sprite(aiplayer.playermodel.sprite.data),aiplayer.pos.x,aiplayer.pos.y,
  aiplayer.playermodel.sprite.height,
  aiplayer.playermodel.sprite.width,
  @wasm4.BlitFlag::{
      one_bit_per_pixel: false,
      rotate: false,
      flip_x: not(aiplayer.direction),
      flip_y: false,})}
  @wasm4.set_draw_colors(1,index=1)
  @wasm4.set_draw_colors(4, index=2)
  @wasm4.rect(e_pos.x, e_pos.y, aiplayer.hp, 5)
  @wasm4.rect(p_pos.x, p_pos.y, player1.hp, 5)
  @wasm4.set_draw_colors(3,index=1)
  @wasm4.set_draw_colors(4, index=2)
  @wasm4.rect(e_pos.x, e_pos.y, aiplayer.hp, 5)
  @wasm4.rect(p_pos.x, p_pos.y, player1.hp, 5)
  @wasm4.set_draw_colors(4,index=1)
  @wasm4.set_draw_colors(1, index=2)
  @wasm4.text("P1",0,0)
  @wasm4.text("PC",90,0)
    move(player1,aiplayer)
  if game2.mod==2{
  player1.cd.s1_cd=player1.playermodel.cd.s1_cd
  player1.cd.f1_cd=player1.playermodel.cd.f1_cd
  player1.cd.d1_cd=player1.playermodel.cd.d1_cd
  player1.cd.s2_cd=player1.playermodel.cd.s2_cd
  player1.cd.f2_cd=player1.playermodel.cd.f2_cd
  player1.cd.d2_cd=player1.playermodel.cd.d2_cd
  player1.hp=player1.playermodel.hp 
  player1.demage.fight=player1.playermodel.demage.fight
  aiplayer.cd.s1_cd=aiplayer.playermodel.cd.s1_cd
  aiplayer.cd.f1_cd=aiplayer.playermodel.cd.f1_cd
  aiplayer.cd.d1_cd=aiplayer.playermodel.cd.d1_cd
  aiplayer.cd.s2_cd=aiplayer.playermodel.cd.s2_cd
  aiplayer.cd.f2_cd=aiplayer.playermodel.cd.f2_cd
  aiplayer.cd.d2_cd=aiplayer.playermodel.cd.d2_cd
  aiplayer.hp=aiplayer.playermodel.hp 
  aiplayer.demage.fight=aiplayer.playermodel.demage.fight
  game2.mod=0}
  
  // @wasm4.text("\{player.demage.fight}",10,30)
    // player1.pos.y=jump(124)
    if @wasm4.get_gamepad(index=1).button_right && player1.pos.x + 20 < 160{
    if aiplayer.playermodel.sprite.data==dragon_sprite.data{if player1.pos.x + 20 < 110{if player1.pos.y+35<aiplayer.pos.y||player1.pos.y-35>aiplayer.pos.y{
      player1.pos.x += player1.playermodel.speed}
    else{if player1.direction{ player1.pos.x += player1.playermodel.speed}
         else{if player1.pos.x<aiplayer.pos.x-20{ player1.pos.x += player1.playermodel.speed}}}
  }}
    else{
    if player1.pos.y+35<aiplayer.pos.y||player1.pos.y-35>aiplayer.pos.y{
      player1.pos.x += player1.playermodel.speed}
    else{if player1.direction{ player1.pos.x += player1.playermodel.speed}
         else{if player1.pos.x<aiplayer.pos.x-20{ player1.pos.x += player1.playermodel.speed}}}
  } }
 
    else if @wasm4.get_gamepad(index=1).button_left && player1.pos.x >= 0{
    if player1.pos.y+35<aiplayer.pos.y||player1.pos.y-35>aiplayer.pos.y{player1.pos.x -= player1.playermodel.speed}
    else{if not(player1.direction){ player1.pos.x -= player1.playermodel.speed}
    else{if player1.pos.x>aiplayer.pos.x+20{ player1.pos.x -= player1.playermodel.speed}}}
  }
   fightpve(player1)//优化点：把按键识别放在函数外
   skills(player1,aiplayer)
   defend(player1)
   jump(player1,aiplayer,phy1)

  // if player1.hp<=0{
  //   @wasm4.text("P2 Win!",52,88)
  // }
  // if aiplayer.hp<=0{
  //   ent.scene=Victory}
//////////////////////////////////////////////////////////
    // aiplayer.pos.y=jump(124)

    
    ai_run()
   fightpve(aiplayer)
   skills(aiplayer,player1)
   defend(aiplayer)
   jump(aiplayer,player1,phy2)
   if count.x==2{
    if aiplayer.hp<=0{
    sto.story=Sto2}
    
  
  }
  else if count.x==3{
    if aiplayer.hp<=0{
    sto.story=Sto3}
    }
   else if count.x==4{
    if aiplayer.hp<=0{
    sto.story=Sto4}
    }
   else if count.x==1{
    if aiplayer.hp<=0{
    sto.story=End}
    }
    if player1.hp<=0{
    lose()}
    
}