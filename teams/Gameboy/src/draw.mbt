
enum Scene {
  // Welcome
  Menus
  Game1
  Game2
  Choice  
  Victory1
  Victory2
  // End
} derive(Eq)
struct Cd{
  mut count:Int
  mut cd : Int
}
let m_cd:Cd={cd:0,count:0}

fn render_system(entities : Entities) -> Unit {
  match entities.scene {
    // Welcome => render_welcome(entities)
    Menus => render_menus(entities)
    Game1 => render_game1(entities)
    Game2 => render_game2(entities)
    Choice => render_choice(entities)
    Victory1 => render_victory1(entities)
    Victory2 => render_victory2(entities)
    // End => render_End(entities)
  }
}

fn render_menus(entities : Entities) -> Unit {
  bgm(50,20)
  if m_cd.cd==10{m_cd.cd=0}
      else if m_cd.cd==0{}
      else {m_cd.cd+=1}
  @wasm4.set_draw_colors(1, index=1)
  @wasm4.set_draw_colors(1, index=2)
  @wasm4.rect(0, 0, 160, 160)
  @wasm4.set_draw_colors(2, index=1)
  @wasm4.set_draw_colors(1, index=2)
  // @wasm4.text("->", 4, 10+20*m_cd.count)
  @wasm4.rect(14,4+20*m_cd.count,54,18)
  @wasm4.set_draw_colors(1, index=1)
  @wasm4.set_draw_colors(2, index=2)
  @wasm4.rect(16,6+20*m_cd.count,50,14)
  @wasm4.set_draw_colors(4, index=1)
  @wasm4.set_draw_colors(1, index=2)
  @wasm4.text("P1VP2", 20, 10)
  @wasm4.text("STORY", 20, 30)
  @wasm4.text("MUSIC", 20, 50)
  @wasm4.text("EXIST", 20, 70)
  @wasm4.set_draw_colors(1, index=1)
  @wasm4.set_draw_colors(2, index=2)
  @wasm4.set_draw_colors(3, index=3)
  @wasm4.set_draw_colors(4, index=4)
  @wasm4.blit(@wasm4.sprite(background.data),0,90,background.height,background.width,@wasm4.BlitFlag::{one_bit_per_pixel: false,rotate: false,flip_x: false,flip_y: false,})
  @wasm4.blit(@wasm4.sprite(baimianju.data),128,34,baimianju.height,baimianju.width,@wasm4.BlitFlag::{one_bit_per_pixel: false,rotate: false,flip_x: false,flip_y: false,})
  @wasm4.blit(@wasm4.sprite(title.data),70,5,title.height,title.width,@wasm4.BlitFlag::{one_bit_per_pixel: false,rotate: false,flip_x: false,flip_y: false,})
   if @wasm4.get_gamepad(index=1).button_2{
      choice1()
      if m_cd.count==0{ent.scene=Choice}
      else if m_cd.count==1{ent.scene=Game2}
      else if m_cd.count==2{ent.scene=Menus}
      else if m_cd.count==3{ent.scene=Menus}
      else{}}
    if @wasm4.get_gamepad(index=1).button_up{
        if m_cd.cd ==0{
         m_cd.cd+=1
         m_cd.count+=1
         choice2()
        }
    }
    if m_cd.count==4{m_cd.count=0}

}
fn render_choice(entities : Entities) -> Unit {
  @wasm4.set_draw_colors(1, index=1)
  @wasm4.set_draw_colors(1, index=2)
  @wasm4.rect(0, 0, 160, 160)
  @wasm4.set_draw_colors(2, index=1)
  @wasm4.set_draw_colors(1, index=2)
  @wasm4.rect(50, 25, 30, 55)
  @wasm4.rect(80, 25, 30, 55)
  @wasm4.rect(50, 80, 30, 55)
  @wasm4.rect(80, 80, 30, 55)
  @wasm4.set_draw_colors(1, index=1)
  @wasm4.set_draw_colors(2, index=2)
  @wasm4.set_draw_colors(3, index=3)
  @wasm4.set_draw_colors(4, index=4)
  @wasm4.blit(@wasm4.sprite(knight_sprite.data),55,35,scientist_sprite.width,scientist_sprite.height, @wasm4.BlitFlag::{one_bit_per_pixel: false,rotate: false,flip_x: false,flip_y: false,})
  @wasm4.blit(@wasm4.sprite(tanker_sprite.data),85,35,tanker_sprite.width,tanker_sprite.height,@wasm4.BlitFlag::{one_bit_per_pixel: false,rotate: false,flip_x: false,flip_y: false,})
  @wasm4.blit( @wasm4.sprite(scientist_sprite.data),55,90,tanker_sprite.width,tanker_sprite.height,@wasm4.BlitFlag::{one_bit_per_pixel: false,rotate: false,flip_x: false,flip_y: false,})
  @wasm4.blit(@wasm4.sprite(stive_sprite.data),85,90, tanker_sprite.width,tanker_sprite.height,@wasm4.BlitFlag::{one_bit_per_pixel: false,rotate: false,flip_x: false,flip_y: false,})
  @wasm4.set_draw_colors(4, index=1)
  @wasm4.set_draw_colors(1, index=2)
  @wasm4.text("CHOICE", 64, 5)
  @wasm4.text("Press button1", 8, 140)
  choice(player1)
  choice(player2)
}
fn render_game1(entities : Entities) -> Unit {
  bgm2(25,10)
  // @wasm4.set_draw_colors(2, index=1)
  // @wasm4.set_draw_colors(2, index=2)
  // @wasm4.rect(palyer1.direction.x, palyer1.direction.y, 20, 35)
  // @wasm4.rect(palyer2.direction.x, palyer2.direction.y, 20, 35)
  // if g_cd.cd==player1
  //    {g_cd.cd=0}
  //     else if g_cd.cd==0{}
  //     else {g_cd.cd+=1}
  game_init()
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
      @wasm4.blit(
  @wasm4.sprite(player2.playermodel.sprite.data),player2.pos.x,player2.pos.y,
  player1.playermodel.sprite.width,
  player1.playermodel.sprite.height,
  @wasm4.BlitFlag::{
      one_bit_per_pixel: false,
      rotate: false,
      flip_x: player2.direction,
      flip_y: false,})
  @wasm4.set_draw_colors(1,index=1)
  @wasm4.set_draw_colors(4, index=2)
  @wasm4.rect(e_pos.x, e_pos.y, player2.hp, 5)
  @wasm4.rect(p_pos.x, p_pos.y, player1.hp, 5)
  @wasm4.set_draw_colors(3,index=1)
  @wasm4.set_draw_colors(4, index=2)
  @wasm4.rect(e_pos.x, e_pos.y, player2.hp, 5)
  @wasm4.rect(p_pos.x, p_pos.y, player1.hp, 5)
  @wasm4.set_draw_colors(4,index=1)
  @wasm4.set_draw_colors(1, index=2)
  @wasm4.text("P1",0,0)
  @wasm4.text("P2",90,0)
  // @wasm4.set_draw_colors(1, index=1)
  // @wasm4.set_draw_colors(1, index=2)
  // @wasm4.rect(0, 16, 120, 144)
  // entities.tanks.each(Character::draw)
  // entities.bullets.each(Flayer::draw)
}
fn render_victory1(_entities : Entities) -> Unit {
  @wasm4.set_draw_colors(2, index=1)
  @wasm4.set_draw_colors(2, index=2)
  @wasm4.rect(0, 0, 160, 160)
  @wasm4.set_draw_colors(3, index=1)
  @wasm4.set_draw_colors(2, index=2)
  @wasm4.text("P1 Win!", 30, 10)
}
fn render_victory2(_entities : Entities) -> Unit {
  @wasm4.set_draw_colors(2, index=1)
  @wasm4.set_draw_colors(2, index=2)
  @wasm4.rect(0, 0, 160, 160)
  @wasm4.set_draw_colors(3, index=1)
  @wasm4.set_draw_colors(2, index=2)
  @wasm4.text("P2 Win!", 30, 10)
}
fn lose() -> Unit {
  @wasm4.set_draw_colors(2, index=1)
  @wasm4.set_draw_colors(2, index=2)
  @wasm4.rect(0, 0, 160, 160)
  @wasm4.set_draw_colors(3, index=1)
  @wasm4.set_draw_colors(2, index=2)
  @wasm4.text("You lose", 30, 10)
  @wasm4.text("Press R to restart", 0, 20)
}
pub fn start() -> Unit {
  @wasm4.set_palette(1, @wasm4.rgb(0xffffff))
  @wasm4.set_palette(2, @wasm4.rgb(0xe5b083))
  @wasm4.set_palette(3, @wasm4.rgb(0xb8043d))
  @wasm4.set_palette(4, @wasm4.rgb(0x000000))
}