enum Story {
    Sto1
    Sto2
    Sto3
    Sto4
    End
}
enum Stor {
    Sto1
    Sto2
    Sto3
    Sto4
    Sto5
    End
}
struct Sto{
mut story:Story
mut stor:Stor
}
let sto:Sto={story:Sto1,stor:Sto1}
let count:Point={x:1,y:1}
let ti:Ti={t:0}
fn story()->Unit{
  match sto.story{
    Sto1=>{if count.x==1{
      
      aiplayer.playermodel=tree_model
      aiplayer.ai.prob.prob1=0
      aiplayer.ai.prob.prob2=0
      aiplayer.ai.prob.prob3=0
      aiplayer.ai.prob.prob4=0
      aiplayer.ai.prob.prob5=0
      game2.mod=2
      
      count.x+=1
    }
    @wasm4.text("Welcome to Minecraft", 0, 10)
    @wasm4.text("First step: cut tree", 0, 20)
    
    game2_init()}
    Sto2=>{if count.x==2{
      aiplayer.playermodel=pig_model
      aiplayer.ai.prob.prob1=0
      aiplayer.ai.prob.prob2=50
      aiplayer.ai.prob.prob3=0
      aiplayer.ai.prob.prob4=40
      aiplayer.ai.prob.prob5=20
      game2.mod=2
      player1.pos.x=0
      player1.pos.y=125
      count.x+=1
    }
    // @wasm4.text("First step: cut tree", 0, 20)
    @wasm4.text("kill the pig",40, 20)
    player1.demage.fight=15
    game2_init()}
    Sto3=>{if count.x==3{
      aiplayer.playermodel=mo_model
      aiplayer.pos.x=140
      aiplayer.pos.y=125
      aiplayer.ai.prob.prob1=20
      aiplayer.ai.prob.prob2=80
      aiplayer.ai.prob.prob3=10
      aiplayer.ai.prob.prob4=90
      aiplayer.ai.prob.prob5=30
      game2.mod=2
      player1.hp+=20
      player1.pos.x=0
      player1.pos.y=125
      count.x+=1

    }
    // @wasm4.text("First step: cut tree", 0, 20)
    @wasm4.text("Kill the Enderman", 15, 20)
    player1.demage.fight=15
    game2_init()}
    Sto4=>{if count.x==4{
      aiplayer.playermodel=dra_model
      aiplayer.pos.x=110
      aiplayer.pos.y=110
      aiplayer.ai.prob.prob1=0
      aiplayer.ai.prob.prob2=0
      aiplayer.ai.prob.prob3=0
      aiplayer.ai.prob.prob4=0
      aiplayer.ai.prob.prob5=0
      game2.mod=2
      player1.pos.x=0
      player1.pos.y=125
      player1.hp+=20
      count.x=1
    }
    // @wasm4.text("First step: cut tree", 0, 20)
    @wasm4.text("Kill the EnderDragon", 0, 20)
    player1.demage.fight=15
    game2_init()}
  End=>{
  @wasm4.set_draw_colors(1, index=1)
  @wasm4.set_draw_colors(2, index=2)
  @wasm4.set_draw_colors(3, index=3)
  @wasm4.set_draw_colors(4, index=4)
  @wasm4.blit(@wasm4.sprite(baimianju.data),128,34,baimianju.height,baimianju.width,@wasm4.BlitFlag::{one_bit_per_pixel:false,rotate: false,flip_x: false,flip_y: false,})
  @wasm4.blit(@wasm4.sprite(stive_sprite.data),10,140, tanker_sprite.width,tanker_sprite.height,@wasm4.BlitFlag::{one_bit_per_pixel: false,rotate: true,flip_x: true,flip_y: true,})
  @wasm4.blit(@wasm4.sprite(dragon_sprite.data),110,110, dragon_sprite.height,dragon_sprite.width,@wasm4.BlitFlag::{one_bit_per_pixel: false,rotate: false,flip_x: true,flip_y: false,})

  match sto.stor{
  Sto1=>{
  ti.t+=1
  @wasm4.set_draw_colors(4, index=1)
  @wasm4.set_draw_colors(1, index=2)
  @wasm4.rect(0, 0, 160, 160)
  @wasm4.text("What hanppend", 30, 10)
  @wasm4.text("You Win??????", 30, 20)
  @wasm4.text("Press button X", 30, 40)
  end()
  if @wasm4.get_gamepad(index=1).button_1{
    if ti.t>=60{sto.stor=Sto2
    ti.t=0}
 }}
  
  Sto2=>{
  ti.t+=1
  // @wasm4.set_draw_colors(1, index=1)
  // @wasm4.set_draw_colors(1, index=2)
  // @wasm4.rect(0, 0, 160, 160)
  @wasm4.set_draw_colors(4, index=1)
  @wasm4.set_draw_colors(1, index=2)
  @wasm4.text("Dragon killer?", 10, 40)
  @wasm4.text("Junk!!", 10, 50)
  @wasm4.set_draw_colors(1, index=1)
  @wasm4.set_draw_colors(4, index=2)
  @wasm4.blit(@wasm4.sprite(shenwei_sprite.data),10,10,shenwei_sprite.width,shenwei_sprite.height, @wasm4.BlitFlag::{one_bit_per_pixel: true,rotate: false,flip_x: false,flip_y: false,})
   if @wasm4.get_gamepad(index=1).button_1{
    if ti.t>=60{sto.stor=Sto3
    ti.t=0}
  }}
  
  Sto3=>{ti.t+=1
  @wasm4.set_draw_colors(4, index=1)
  @wasm4.set_draw_colors(1, index=2)
  // @wasm4.rect(0, 0, 80, 160)
  @wasm4.text("Killed the dragon?", 10, 10)
  @wasm4.text("For princess?!", 10, 20)
  // @wasm4.text("神威难藏泪", 30, 10)
  // @wasm4.set_draw_colors(1, index=1)
  // @wasm4.set_draw_colors(4, index=2)
  // @wasm4.blit(@wasm4.sprite(shenwei_sprite.data),10,10,shenwei_sprite.width,shenwei_sprite.height, @wasm4.BlitFlag::{one_bit_per_pixel: true,rotate: false,flip_x: false,flip_y: false,})
  @wasm4.set_draw_colors(1, index=1)
  @wasm4.set_draw_colors(2, index=2)
  @wasm4.set_draw_colors(3, index=3)
  @wasm4.set_draw_colors(4, index=4)
  // @wasm4.blit(@wasm4.sprite(baimianju.data),128,34,baimianju.height,baimianju.width,@wasm4.BlitFlag::{one_bit_per_pixel:false,rotate: false,flip_x: false,flip_y: false,})
  @wasm4.blit(@wasm4.sprite(knight_sprite.data),10,140, tanker_sprite.width,tanker_sprite.height,@wasm4.BlitFlag::{one_bit_per_pixel: false,rotate: true,flip_x: false,flip_y: true,})
  if @wasm4.get_gamepad(index=1).button_1{
    if ti.t>=60{sto.stor=Sto4
    ti.t=0}
  }}
  Sto4=>{ti.t+=1
  @wasm4.set_draw_colors(4, index=1)
  @wasm4.set_draw_colors(1, index=2)
  // @wasm4.rect(0, 0, 80, 160)
  @wasm4.text("For living forever", 10, 10)
  @wasm4.text("Unscrupulously!", 10, 20)
  // @wasm4.text("神威难藏泪", 30, 10)
  // @wasm4.set_draw_colors(1, index=1)
  // @wasm4.set_draw_colors(4, index=2)
  // @wasm4.blit(@wasm4.sprite(shenwei_sprite.data),10,10,shenwei_sprite.width,shenwei_sprite.height, @wasm4.BlitFlag::{one_bit_per_pixel: true,rotate: false,flip_x: false,flip_y: false,})
  @wasm4.set_draw_colors(1, index=1)
  @wasm4.set_draw_colors(2, index=2)
  @wasm4.set_draw_colors(3, index=3)
  @wasm4.set_draw_colors(4, index=4)
  // @wasm4.blit(@wasm4.sprite(baimianju.data),128,34,baimianju.height,baimianju.width,@wasm4.BlitFlag::{one_bit_per_pixel:false,rotate: false,flip_x: false,flip_y: false,})
  @wasm4.blit(@wasm4.sprite(scientist_sprite.data),10,140, tanker_sprite.width,tanker_sprite.height,@wasm4.BlitFlag::{one_bit_per_pixel: false,rotate: true,flip_x: true,flip_y: true,})
  if @wasm4.get_gamepad(index=1).button_1{
 
    if ti.t>=60{sto.stor=Sto5
    ti.t=0}
  }}
  Sto5=>{ti.t+=1
  @wasm4.set_draw_colors(4, index=1)
  @wasm4.set_draw_colors(1, index=2)
  // @wasm4.rect(0, 0, 80, 160)
  @wasm4.text("You did it, too?", 30, 10)
  @wasm4.text("A robot???", 30, 20)
  @wasm4.text("F**K!!!!", 30, 30)
  // @wasm4.text("神威难藏泪", 30, 10)
  // @wasm4.set_draw_colors(1, index=1)
  // @wasm4.set_draw_colors(4, index=2)
  // @wasm4.blit(@wasm4.sprite(shenwei_sprite.data),10,10,shenwei_sprite.width,shenwei_sprite.height, @wasm4.BlitFlag::{one_bit_per_pixel: true,rotate: false,flip_x: false,flip_y: false,})
  @wasm4.set_draw_colors(1, index=1)
  @wasm4.set_draw_colors(2, index=2)
  @wasm4.set_draw_colors(3, index=3)
  @wasm4.set_draw_colors(4, index=4)
  // @wasm4.blit(@wasm4.sprite(baimianju.data),128,34,baimianju.height,baimianju.width,@wasm4.BlitFlag::{one_bit_per_pixel:false,rotate: false,flip_x: false,flip_y: false,})
  @wasm4.blit(@wasm4.sprite(tanker_sprite.data),10,140, tanker_sprite.width,tanker_sprite.height,@wasm4.BlitFlag::{one_bit_per_pixel: false,rotate: true,flip_x: true,flip_y: true,})
  if @wasm4.get_gamepad(index=1).button_1{
    if ti.t>=60{sto.stor=End
    ti.t=0}
  }}
  End=>{ti.t+=1
  @wasm4.set_draw_colors(4, index=1)
  @wasm4.set_draw_colors(1, index=2)
  // @wasm4.rect(0, 0, 80, 160)
  @wasm4.text("You were strongers", 0, 0)
  @wasm4.text("But are slaves now", 0, 10)
  @wasm4.text("Kill each other", 0, 20)
  @wasm4.text("Winner will could", 0, 30)
  @wasm4.text("challenge me ", 0, 40)
  @wasm4.text("For freedom! ", 0, 50)
  // @wasm4.set_draw_colors(1, index=1)
  // @wasm4.set_draw_colors(4, index=2)
  // @wasm4.blit(@wasm4.sprite(shenwei_sprite.data),10,10,shenwei_sprite.width,shenwei_sprite.height, @wasm4.BlitFlag::{one_bit_per_pixel: true,rotate: false,flip_x: false,flip_y: false,})
  @wasm4.set_draw_colors(1, index=1)
  @wasm4.set_draw_colors(2, index=2)
  @wasm4.set_draw_colors(3, index=3)
  @wasm4.set_draw_colors(4, index=4)
  // @wasm4.blit(@wasm4.sprite(baimianju.data),128,34,baimianju.height,baimianju.width,@wasm4.BlitFlag::{one_bit_per_pixel:false,rotate: false,flip_x: false,flip_y: false,})
  // @wasm4.blit(@wasm4.sprite(knight_sprite.data),10,140, tanker_sprite.width,tanker_sprite.height,@wasm4.BlitFlag::{one_bit_per_pixel: false,rotate: true,flip_x: true,flip_y: true,})
  @wasm4.blit(@wasm4.sprite(background.data),0,90,background.height,background.width,@wasm4.BlitFlag::{one_bit_per_pixel: false,rotate: false,flip_x: false,flip_y: false,})
 if @wasm4.get_gamepad(index=1).button_1{
    if ti.t>=60{ent.scene=Menus
    ti.t=0}
  }}
  }}}}

fn render_game2(entities:Entities)->Unit{
  story()
}