fn role_stand() ->Unit{
@wasm4.set_draw_colors(1,index=1)
@wasm4.set_draw_colors(4,index=2)
@wasm4.set_draw_colors(0,index=3)
@wasm4.set_draw_colors(2,index=4)
@wasm4.blit(mains,pos.r_x,pos.r_y,16,16,mainflag)
}

fn role_move() -> Unit{
//什么都不干，播放角色站着的动画
@wasm4.set_draw_colors(1,index=1)
@wasm4.set_draw_colors(4,index=2)
@wasm4.set_draw_colors(0,index=3)
@wasm4.set_draw_colors(2,index=4)
@wasm4.blit(mains,pos.r_x,pos.r_y,16,16,mainflag)

//把客厅分为四个可行走的矩形区域，分别都写上下左右
if (pos.r_x <= 127 && pos.r_x >= 98) && (pos.r_y <= 125 && pos.r_y >= 17) || (pos.r_x <= 101 && pos.r_x >= 2) && (pos.r_y <= 125 && pos.r_y >= 115) || (pos.r_x <= 52 && pos.r_x >= 23) && (pos.r_y <= 42 && pos.r_y >= 17) || (pos.r_x <= 99 && pos.r_x >= 23) && (pos.r_y <= 54 && pos.r_y >= 40) {

//向下
if @wasm4.get_gamepad(index = 1).button_down&&game.j==0{
  if (pos.r_x <= 127 && pos.r_x >= 98) && (pos.r_y <= 124 && pos.r_y >= 17) || (pos.r_x <= 101 && pos.r_x >= 2) && (pos.r_y <= 124 && pos.r_y >= 115) || (pos.r_x <= 52 && pos.r_x >= 23) && (pos.r_y <= 41 && pos.r_y >= 17) || (pos.r_x <= 99 && pos.r_x >= 23) && (pos.r_y <= 53 && pos.r_y >= 40){
  @wasm4.blit(mains,pos.r_x,pos.r_y,16,16,mainflag)
  pos.r_y += 1
  delay.frames_role += 1
  if delay.frames_role > 5{
    game.j=1
    delay.frames_role = 0
  }
  }
}
else if @wasm4.get_gamepad(index = 1).button_down&&game.j==1{
  if (pos.r_x <= 127 && pos.r_x >= 98) && (pos.r_y <= 124 && pos.r_y >= 17) || (pos.r_x <= 101 && pos.r_x >= 2) && (pos.r_y <= 124 && pos.r_y >= 115) || (pos.r_x <= 52 && pos.r_x >= 23) && (pos.r_y <= 41 && pos.r_y >= 17) || (pos.r_x <= 99 && pos.r_x >= 23) && (pos.r_y <= 53 && pos.r_y >= 40){
  @wasm4.blit(mainens,pos.r_x,pos.r_y,16,16,mainenflag)
  pos.r_y += 1
  game.j=0
  }
}

//向上
if @wasm4.get_gamepad(index = 1).button_up&&game.j==0{
  if (pos.r_x <= 127 && pos.r_x >= 98) && (pos.r_y <= 125 && pos.r_y >= 18) || (pos.r_x <= 101 && pos.r_x >= 2) && (pos.r_y <= 125 && pos.r_y >= 116) || (pos.r_x <= 52 && pos.r_x >= 23) && (pos.r_y <= 42 && pos.r_y >= 18) || (pos.r_x <= 99 && pos.r_x >= 23) && (pos.r_y <= 54 && pos.r_y >= 41) {
  @wasm4.blit(mains,pos.r_x,pos.r_y,16,16,mainflag)
  pos.r_y -= 1
  delay.frames_role += 1
  if delay.frames_role > 5{
    game.j=1
    delay.frames_role = 0
  }
  }
}
else if @wasm4.get_gamepad(index = 1).button_up&&game.j==1{
  if (pos.r_x <= 127 && pos.r_x >= 98) && (pos.r_y <= 125 && pos.r_y >= 18) || (pos.r_x <= 101 && pos.r_x >= 2) && (pos.r_y <= 125 && pos.r_y >= 116) || (pos.r_x <= 52 && pos.r_x >= 23) && (pos.r_y <= 42 && pos.r_y >= 18) || (pos.r_x <= 99 && pos.r_x >= 23) && (pos.r_y <= 54 && pos.r_y >= 41) {
  @wasm4.blit(mainens,pos.r_x,pos.r_y,16,16,mainenflag)
  pos.r_y -= 1
  game.j = 0
  }
}


//向左
if @wasm4.get_gamepad(index = 1).button_left&&game.j==0{
  if (pos.r_x <= 127 && pos.r_x >= 99) && (pos.r_y <= 125 && pos.r_y >= 17) || (pos.r_x <= 101 && pos.r_x >= 3) && (pos.r_y <= 125 && pos.r_y >= 115) || (pos.r_x <= 52 && pos.r_x >= 24) && (pos.r_y <= 42 && pos.r_y >= 17) || (pos.r_x <= 99 && pos.r_x >= 24) && (pos.r_y <= 54 && pos.r_y >= 40){
  @wasm4.blit(mains,pos.r_x,pos.r_y,16,16,mainflag)
  pos.r_x -= 1
  delay.frames_role += 1
  if delay.frames_role > 4{
    game.j=1
    delay.frames_role = 0
  }
  }
}
  else if @wasm4.get_gamepad(index = 1).button_left&&game.j==1{
    if (pos.r_x <= 127 && pos.r_x >= 99) && (pos.r_y <= 125 && pos.r_y >= 17) || (pos.r_x <= 101 && pos.r_x >= 3) && (pos.r_y <= 125 && pos.r_y >= 115) || (pos.r_x <= 52 && pos.r_x >= 24) && (pos.r_y <= 42 && pos.r_y >= 17) || (pos.r_x <= 99 && pos.r_x >= 24) && (pos.r_y <= 54 && pos.r_y >= 40){
  @wasm4.blit(mainens,pos.r_x,pos.r_y,16,16,mainenflag)
  pos.r_x-= 1
  delay.frames_role1 += 1
  if delay.frames_role1 > 3{
    game.j=0
    delay.frames_role1 = 0
  }
  }
}

//向右
if @wasm4.get_gamepad(index = 1).button_right&&game.j==0{
  if (pos.r_x <= 126 && pos.r_x >= 98) && (pos.r_y <= 125 && pos.r_y >= 17) || (pos.r_x <= 100 && pos.r_x >= 2) && (pos.r_y <= 125 && pos.r_y >= 115) || (pos.r_x <= 51 && pos.r_x >= 23) && (pos.r_y <= 42 && pos.r_y >= 17) || (pos.r_x <= 98 && pos.r_x >= 23) && (pos.r_y <= 54 && pos.r_y >= 40) {
  @wasm4.blit(mains,pos.r_x,pos.r_y,16,16,mainflag)
  pos.r_x += 1
  delay.frames_role += 1
  if delay.frames_role > 4{
    game.j=1
    delay.frames_role = 0
  }
  }
}
else if @wasm4.get_gamepad(index = 1).button_right&&game.j==1{
  if (pos.r_x <= 126 && pos.r_x >= 98) && (pos.r_y <= 125 && pos.r_y >= 17) || (pos.r_x <= 100 && pos.r_x >= 2) && (pos.r_y <= 125 && pos.r_y >= 115) || (pos.r_x <= 51 && pos.r_x >= 23) && (pos.r_y <= 42 && pos.r_y >= 17) || (pos.r_x <= 98 && pos.r_x >= 23) && (pos.r_y <= 54 && pos.r_y >= 40) {
  @wasm4.blit(mainens,pos.r_x,pos.r_y,16,16,mainenflag)
  pos.r_x += 1
  delay.frames_role1 += 1
  if delay.frames_role1 > 3{
    game.j=0
    delay.frames_role1 = 0
  }
  }
}
}


}