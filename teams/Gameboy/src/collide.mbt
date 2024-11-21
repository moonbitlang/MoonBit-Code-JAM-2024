fn hit(player:Player,player_:Player)->Unit{
  if player.direction{if player.f_state.x<=0{player.f_live=false}
    if player.f_state.x<=player_.pos.x+20&&player.f_state.x>=player_.pos.x&&player.f_state.y<=player_.pos.y+35&&player.f_state.y>=player_.pos.y{
    if not (player_.if_defend)||not(@wasm4.get_gamepad(index=player_.key).button_down){
      fight_s()
      player_.hp-=player.demage.fight}
    player.f_live=false}}
  else{if player.f_state.x>=160{player.f_live=false}
    if player.f_state.x<=player_.pos.x+20&&player.f_state.x>=player_.pos.x&&player.f_state.y<=player_.pos.y+35&&player.f_state.y>=player_.pos.y{
    if not (player_.if_defend)||not(@wasm4.get_gamepad(index=player_.key).button_down){
      fight_s()
      player_.hp-=player.demage.fight}
    player.f_live=false}}
}
fn dash(player:Player,player_:Player)->Unit{
  if player.pos.x<=0||player.pos.x>=140{
    fight_s()
    player.hp-=10
  player.state=0}
  if player.direction{if player.pos.x<player_.pos.x+20&&player.pos.y<=player_.pos.y+35&&player.pos.y>=player_.pos.y{
    if not (player_.if_defend)||not(@wasm4.get_gamepad(index=player_.key).button_down){
      fight_s()
      player_.hp-=player.demage.skill}
    else{
      fight_s()
      player_.hp-=player.demage.skill/2}
    player.pos.x+=10
    player.state=0}}
  else{if player.pos.x>=player_.pos.x-20&&player.pos.y<=player_.pos.y+35&&player.pos.y>=player_.pos.y{
    if not (player_.if_defend)||not(@wasm4.get_gamepad(index=player_.key).button_down){
      fight_s()
      player_.hp-=player.demage.skill}
    else{
      fight_s()
      player_.hp-=player.demage.skill/2}
    player.pos.x-=10
    player.state=0}}
}
fn p_hit(player:Player,player_:Player)->Unit{
  if player.direction{if player.f_state.x<=0{player.f_live=false}
  if player.f_state.x<=player_.pos.x+20&&player.f_state.x>=player_.pos.x&&player.f_state.y<=player_.pos.y+35&&player.f_state.y>=player_.pos.y{
    if not (player_.if_defend)||not(@wasm4.get_gamepad(index=player_.key).button_down){
      fight_s()
      player_.hp-=player.demage.fight}
    player.f_live=false
    // player_.state=3
    }}
  else{if player.f_state.x>=160{player.f_live=false}
  if player.f_state.x<=player_.pos.x+20&&player.f_state.x>=player_.pos.x&&player.f_state.y<=player_.pos.y+35&&player.f_state.y>=player_.pos.y{
    if not (player_.if_defend)||not(@wasm4.get_gamepad(index=player_.key).button_down){
      fight_s()
      player_.hp-=player.demage.fight}
    player.f_live=false
    // player_.state=3
    }}
}