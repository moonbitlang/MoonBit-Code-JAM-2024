let c1_cd:Cd={cd:0,count:1}
let c_cd:Cd={cd:0,count:0}
let c1:Cd={cd:0,count:0}
// let c2:Cd={cd:0,count:0}
fn choice(player:Player)->Unit{
  if player.p{
    if c_cd.cd==10{c_cd.cd=0}
      else if c_cd.cd==0{}
      else {c_cd.cd+=1}
  if @wasm4.get_gamepad(index=player.key).button_up{
        if c_cd.cd ==0{
         c_cd.cd+=1
         c_cd.count+=1
         choiced()
        }
    }
    if c_cd.count==4{c_cd.count=0}
    if c1.count==0{if @wasm4.get_gamepad(index=player1.key).button_1{
    choice1()
    if c_cd.count==0{player.playermodel=knight_model}
    if c_cd.count==1{player.playermodel=tanker_model}
    if c_cd.count==2{player.playermodel=scientist_model}
    if c_cd.count==3{player.playermodel=stive_model}
    // @wasm4.text("READY", 10, 10)
    c1.count=1}
    @wasm4.set_draw_colors(2, index=1)
    @wasm4.set_draw_colors(4, index=2)
    if c_cd.count==0{@wasm4.blit(@wasm4.sprite(p1_sprite.data),57,27, 16,8,@wasm4.BlitFlag::{one_bit_per_pixel: true,rotate: false,flip_x: false,flip_y: false,})
    // @wasm4.set_draw_colors(1, index=1)
    // @wasm4.set_draw_colors(2, index=2)
    // @wasm4.set_draw_colors(3, index=3)
    // @wasm4.set_draw_colors(4, index=4)
    // @wasm4.blit(@wasm4.sprite(knight_sprite.data),10,20,scientist_sprite.width,scientist_sprite.height, @wasm4.BlitFlag::{one_bit_per_pixel: false,rotate: false,flip_x: false,flip_y: false,})
    }
    @wasm4.set_draw_colors(2, index=1)
    @wasm4.set_draw_colors(4, index=2)
    if c_cd.count==1{@wasm4.blit(@wasm4.sprite(p1_sprite.data),87,27, 16,8,@wasm4.BlitFlag::{one_bit_per_pixel: true,rotate: false,flip_x: false,flip_y: false,})
    // @wasm4.set_draw_colors(1, index=1)
    // @wasm4.set_draw_colors(2, index=2)
    // @wasm4.set_draw_colors(3, index=3)
    // @wasm4.set_draw_colors(4, index=4)
    // @wasm4.blit(@wasm4.sprite(tanker_sprite.data),10,20,tanker_sprite.width,tanker_sprite.height,@wasm4.BlitFlag::{one_bit_per_pixel: false,rotate: false,flip_x: false,flip_y: false,})
    }
    @wasm4.set_draw_colors(2, index=1)
    @wasm4.set_draw_colors(4, index=2)
    if c_cd.count==2{@wasm4.blit(@wasm4.sprite(p1_sprite.data),57,82, 16,8,@wasm4.BlitFlag::{one_bit_per_pixel: true,rotate: false,flip_x: false,flip_y: false,})
    // @wasm4.set_draw_colors(1, index=1)
    // @wasm4.set_draw_colors(2, index=2)
    // @wasm4.set_draw_colors(3, index=3)
    // @wasm4.set_draw_colors(4, index=4)
    // @wasm4.blit( @wasm4.sprite(scientist_sprite.data),10,20,tanker_sprite.width,tanker_sprite.height,@wasm4.BlitFlag::{one_bit_per_pixel: false,rotate: false,flip_x: false,flip_y: false,})
    }
    @wasm4.set_draw_colors(2, index=1)
    @wasm4.set_draw_colors(4, index=2)
    if c_cd.count==3{@wasm4.blit(@wasm4.sprite(p1_sprite.data),87,82, 16,8,@wasm4.BlitFlag::{one_bit_per_pixel: true,rotate: false,flip_x: false,flip_y: false,})
    // @wasm4.set_draw_colors(1, index=1)
    // @wasm4.set_draw_colors(2, index=2)
    // @wasm4.set_draw_colors(3, index=3)
    // @wasm4.set_draw_colors(4, index=4)
    // @wasm4.blit(@wasm4.sprite(stive_sprite.data),10,20, tanker_sprite.width,tanker_sprite.height,@wasm4.BlitFlag::{one_bit_per_pixel: false,rotate: false,flip_x: false,flip_y: false,})
    }
}
    @wasm4.set_draw_colors(2, index=1)
    @wasm4.set_draw_colors(4, index=2)
    }
   else{  
    if c1_cd.cd==10{c1_cd.cd=0}
    else if c1_cd.cd==0{}
    else {c1_cd.cd+=1}
    if @wasm4.get_gamepad(index=player.key).button_up{
        if c1_cd.cd ==0{
         c1_cd.cd+=1
         c1_cd.count+=1
         choiced()
        }
    }
    if c1_cd.count==4{c1_cd.count=0}
    if c1.cd==0{if @wasm4.get_gamepad(index=player2.key).button_1{
    choice1()    
    if c1_cd.count==0{player.playermodel=knight_model}
    if c1_cd.count==1{player.playermodel=tanker_model}
    if c1_cd.count==2{player.playermodel=scientist_model}
    if c1_cd.count==3{player.playermodel=stive_model}
    // @wasm4.text("READY", 130, 10)
    c1.cd=1}
    if c1_cd.count==0{@wasm4.blit(@wasm4.sprite(p2_sprite.data),57,70, 16,8,@wasm4.BlitFlag::{one_bit_per_pixel: true,rotate: false,flip_x: false,flip_y: false,})
    // @wasm4.set_draw_colors(1, index=1)
    // @wasm4.set_draw_colors(2, index=2)
    // @wasm4.set_draw_colors(3, index=3)
    // @wasm4.set_draw_colors(4, index=4)
    // @wasm4.blit(@wasm4.sprite(knight_sprite.data),130, 20,scientist_sprite.width,scientist_sprite.height, @wasm4.BlitFlag::{one_bit_per_pixel: false,rotate: false,flip_x: true,flip_y: false,})
    }
    @wasm4.set_draw_colors(2, index=1)
    @wasm4.set_draw_colors(4, index=2)
    
    if c1_cd.count==1{@wasm4.blit(@wasm4.sprite(p2_sprite.data),87,70, 16,8,@wasm4.BlitFlag::{one_bit_per_pixel: true,rotate: false,flip_x: false,flip_y: false,})
    // @wasm4.set_draw_colors(1, index=1)
    // @wasm4.set_draw_colors(2, index=2)
    // @wasm4.set_draw_colors(3, index=3)
    // @wasm4.set_draw_colors(4, index=4)
    // @wasm4.blit(@wasm4.sprite(tanker_sprite.data),130, 20,tanker_sprite.width,tanker_sprite.height,@wasm4.BlitFlag::{one_bit_per_pixel: false,rotate: false,flip_x: true,flip_y: false,})
    }
    @wasm4.set_draw_colors(2, index=1)
    @wasm4.set_draw_colors(4, index=2)
    
    if c1_cd.count==2{@wasm4.blit(@wasm4.sprite(p2_sprite.data),57,125, 16,8,@wasm4.BlitFlag::{one_bit_per_pixel: true,rotate: false,flip_x: false,flip_y: false,})
    // @wasm4.set_draw_colors(1, index=1)
    // @wasm4.set_draw_colors(2, index=2)
    // @wasm4.set_draw_colors(3, index=3)
    // @wasm4.set_draw_colors(4, index=4)
    // @wasm4.blit( @wasm4.sprite(scientist_sprite.data),130, 20,tanker_sprite.width,tanker_sprite.height,@wasm4.BlitFlag::{one_bit_per_pixel: false,rotate: false,flip_x: true,flip_y: false,})
    }
    @wasm4.set_draw_colors(2, index=1)
    @wasm4.set_draw_colors(4, index=2)
    
    if c1_cd.count==3{@wasm4.blit(@wasm4.sprite(p2_sprite.data),87,125, 16,8,@wasm4.BlitFlag::{one_bit_per_pixel: true,rotate: false,flip_x: false,flip_y: false,})
    @wasm4.set_draw_colors(1, index=1)
    // @wasm4.set_draw_colors(2, index=2)
    // @wasm4.set_draw_colors(3, index=3)
    // @wasm4.set_draw_colors(4, index=4)
    // @wasm4.blit(@wasm4.sprite(stive_sprite.data),130, 20, tanker_sprite.width,tanker_sprite.height,@wasm4.BlitFlag::{one_bit_per_pixel: false,rotate: false,flip_x: true,flip_y: false,})
    }
}
    @wasm4.set_draw_colors(2, index=1)
    @wasm4.set_draw_colors(4, index=2)
    }   
if c1.cd==1&&c1.count==1{ent.scene=Game1}
}