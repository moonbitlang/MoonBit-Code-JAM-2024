fn role_move_liv() -> Unit{
//什么都不干，播放角色站着的动画
@wasm4.set_draw_colors(1,index=1)
@wasm4.set_draw_colors(4,index=2)
@wasm4.set_draw_colors(0,index=3)
@wasm4.set_draw_colors(2,index=4)
@wasm4.blit(mains,pos.r_xl,pos.r_yl,16,16,mainflag)

//把客厅分为四个可行走的矩形区域，分别都写上下左右
if ((pos.r_xl <= 141 && pos.r_xl >= 5) && (pos.r_yl <= 138 && pos.r_yl >= 124)) || ((pos.r_xl <= 141 && pos.r_xl >= 90) && (pos.r_yl <= 87 && pos.r_yl >= 43)) || ((pos.r_xl <= 91 && pos.r_xl >= 42) && (pos.r_yl <= 125 && pos.r_yl >= 43)){

//向下
if @wasm4.get_gamepad(index = 1).button_down&&game.j==0{
  if pos.r_yl < 86 || ((pos.r_xl <= 91 && pos.r_xl >= 5) && (pos.r_yl >= 86 && pos.r_yl <= 137)) || ((pos.r_yl <= 137 && pos.r_yl >=124) && (pos.r_xl < 139 && pos.r_xl >= 89)){
  @wasm4.blit(mains,pos.r_xl,pos.r_yl,16,16,mainflag)
  pos.r_yl += 1
  delay.frames_role += 1
    if delay.frames_role > 5{
      game.j=1
      delay.frames_role = 0
    }
  }
}
else if @wasm4.get_gamepad(index = 1).button_down&&game.j==1{
  if pos.r_yl < 86 || ((pos.r_xl <= 91 && pos.r_xl >= 5) && (pos.r_yl >= 86 && pos.r_yl <= 137)) || ((pos.r_yl <= 137 && pos.r_yl >=124) && (pos.r_xl < 139 && pos.r_xl >= 89)) {
  @wasm4.blit(mainens,pos.r_xl,pos.r_yl,16,16,mainenflag)
  pos.r_yl += 1
  game.j=0
  }
}

//向上
if @wasm4.get_gamepad(index = 1).button_up&&game.j==0{
  if pos.r_yl > 125 || (pos.r_yl > 44 && (pos.r_xl <= 88 && pos.r_xl >= 42)) || ((pos.r_xl <= 140 && pos.r_xl >= 100) && (pos.r_yl <= 87 && pos.r_yl >= 44)){
  @wasm4.blit(mains,pos.r_xl,pos.r_yl,16,16,mainflag)
  pos.r_yl -= 1
  delay.frames_role += 1
  if delay.frames_role > 5{
    game.j=1
    delay.frames_role = 0
  }
  }
}
else if @wasm4.get_gamepad(index = 1).button_up&&game.j==1{
  if pos.r_yl > 125 || (pos.r_yl > 44 && (pos.r_xl <= 88 && pos.r_xl >= 42)) || ((pos.r_xl <= 140 && pos.r_xl >= 100) && (pos.r_yl <= 87 && pos.r_yl >= 44)){
  @wasm4.blit(mainens,pos.r_xl,pos.r_yl,16,16,mainenflag)
  pos.r_yl -= 1
  game.j = 0
  }
}


//向左
if @wasm4.get_gamepad(index = 1).button_left&&game.j==0{
  if (pos.r_xl > 6 && (pos.r_yl <= 137 && pos.r_yl >=124)) || pos.r_xl > 43{
  @wasm4.blit(mains,pos.r_xl,pos.r_yl,16,16,mainflag)
  pos.r_xl -= 1
  delay.frames_role += 1
  if delay.frames_role > 4{
    game.j=1
    delay.frames_role = 0
  }
  }
}
  else if @wasm4.get_gamepad(index = 1).button_left&&game.j==1{
  if (pos.r_xl > 6 && (pos.r_yl <= 137 && pos.r_yl >=124)) || pos.r_xl > 43{
  @wasm4.blit(mainens,pos.r_xl,pos.r_yl,16,16,mainenflag)////
  pos.r_xl -= 1
  delay.frames_role1 += 1
  if delay.frames_role1 > 2{
    game.j=0
    delay.frames_role1 = 0
  }
  }
}

//向右
if @wasm4.get_gamepad(index = 1).button_right&&game.j==0{
  if pos.r_xl < 90 || ((pos.r_xl >= 43 && pos.r_xl <= 140) && (pos.r_yl < 90 && pos.r_yl >= 43)) || ((pos.r_xl >= 6 && pos.r_xl <= 140) && (pos.r_yl < 137 && pos.r_yl > 125)){
  @wasm4.blit(mains,pos.r_xl,pos.r_yl,16,16,mainflag)
  pos.r_xl += 1
  delay.frames_role += 1
  if delay.frames_role > 4{
    game.j=1
    delay.frames_role = 0
  }
  }
}
else if @wasm4.get_gamepad(index = 1).button_right&&game.j==1{
  if pos.r_xl < 90 || ((pos.r_xl >= 43 && pos.r_xl <= 140) && (pos.r_yl < 90 && pos.r_yl >= 43)) || ((pos.r_xl >= 6 && pos.r_xl <= 140) && (pos.r_yl < 137 && pos.r_yl > 125)) {
  @wasm4.blit(mainens,pos.r_xl,pos.r_yl,16,16,mainenflag)
  pos.r_xl += 1
  delay.frames_role1 += 1
  if delay.frames_role1 > 2{
    game.j=0
    delay.frames_role1 = 0
  }
  }
}
}
}