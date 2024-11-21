fn switch_scenes() ->Unit{
  if @wasm4.get_gamepad(index = 1).button_2{
  if (pos.r_x > 21 &&  pos.r_x <31) && pos.r_y < 25{
      change.yesorno_mainscene += 1
  }
}
if (pos.r_x > 105 &&  pos.r_x <116) && pos.r_y < 25 && @wasm4.get_gamepad(index = 1).button_2{
  game.rock_ui += 1
}
else if @wasm4.get_gamepad(index = 1).button_1{
    game.rock_ui = 0
}
if (pos.r_xl > 106 && pos.r_xl < 130) && (pos.r_yl > 42 && pos.r_yl <52) && @wasm4.get_gamepad(index = 1).button_1 && game.gameover == 0{
  game.if_dairy += 1
  game.dairy_book = 0
}
if (@wasm4.get_mouse().x >= 150 && @wasm4.get_mouse().x <= 158) && (@wasm4.get_mouse().y <= 10 && @wasm4.get_mouse().y >= 2) && @wasm4.get_mouse().left{
  game.dairy_book += 1
  game.if_dairy = 0
}

if change.yesorno_mainscene >= 1 && change.render_Hua >= 1 && game.if_dairy == 0 && game.gameover == 0{
  render_bookscene()
  role_move_liv()
}
else if game.if_dairy > 0 && game.dairy_book == 0 && game.gameover == 0{
  render_daiiry()
}
else if change.yesorno_mainscene >= 1&& change.render_Hua == 0 && game.gameover == 0{
  render_board()
  exchange_digi()
}

if change.yesorno_mainscene == 0 && game.stop_dialogue == 0 && game.gameover == 0{
  render_mainscene()
  render_talk()
  role_stand()
  render_ui() 
}
  else if change.yesorno_mainscene == 0 && game.dialogue == 0 && game.stop_dialogue == 1 && game.rock_ui == 0 && game.gameover == 0{
  render_mainscene()
  role_move()
  render_tip()
  render_tool_tip()
}
  else if change.yesorno_mainscene == 0 && game.dialogue == 0 && game.stop_dialogue == 1 && game.rock_ui >= 1 && game.gameover == 0{
  render_rockscene()
  rock_change()
}
  else if change.yesorno_mainscene == 0 && game.dialogue == 0 && game.stop_dialogue == 1 && game.rock_ui >= 1 && game.gameover >= 1{
  render_rockscene()
  rock_change()
  render_gameover()
}
if rock_dig[0][0] == 1 && rock_dig[0][1] == 4 && rock_dig[0][2] == 3 && (@wasm4.get_mouse().x >= 91 && @wasm4.get_mouse().x <= 103) && (@wasm4.get_mouse().y <= 56 && @wasm4.get_mouse().y >= 46) && @wasm4.get_mouse().left{
  game.gameover += 1
}
game.timer+=1
if game.timer==15{
  game.music()   
  game.timer=0
  }
}