fn open_UI(y:Int) -> Unit {
  @wasm4.set_draw_colors(4, index=1)
  @wasm4.set_draw_colors(2, index=2)
  @wasm4.set_draw_colors(0, index=3)
  @wasm4.set_draw_colors(1, index=4)
  @wasm4.blit(eyes_sprite,0,120,160,40,new_biltlag)
  @wasm4.blit(eyes_sprite,0,80,160,40,new_biltlag2)
  if 40+moon.y_moon>=20&&human_active.state{
  @wasm4.set_draw_colors(0, index=1)
  @wasm4.set_draw_colors(3, index=2)
  @wasm4.set_draw_colors(2, index=3)
  @wasm4.set_draw_colors(4, index=4)
  @wasm4.blit(moon_ui_sprite0,40,40+y,80,80,new_biltlag)
  }
    else if 40+moon.y_moon<=20&& 40+moon.y_moon>=10{
  @wasm4.set_draw_colors(0, index=1)
  @wasm4.set_draw_colors(3, index=2)
  @wasm4.set_draw_colors(2, index=3)
  @wasm4.set_draw_colors(4, index=4)
  @wasm4.blit(moon_ui_sprite1,40,40+y,80,80,new_biltlag)
  
  }
    else if 40+moon.y_moon<=10{map.map_0=1
  start()
  @wasm4.set_draw_colors(0, index=1)
  @wasm4.set_draw_colors(3, index=2)
  @wasm4.set_draw_colors(4, index=3)
  @wasm4.set_draw_colors(2, index=4)
  @wasm4.blit(moon_ui_sprite2,40,40+y,80,80,new_biltlag)}
  @wasm4.set_draw_colors(4, index=1)
  @wasm4.set_draw_colors(2, index=2)
  @wasm4.set_draw_colors(0, index=3)
  @wasm4.set_draw_colors(1, index=4)
  @wasm4.blit(logo_0_Sprite,0,0,160,40,new_biltlag)
}
fn user_UI() ->Unit{
@wasm4.set_draw_colors(1)
  @wasm4.set_draw_colors(1, index=1)
  @wasm4.set_draw_colors(2, index=2)
  @wasm4.set_draw_colors(3, index=3)
  @wasm4.set_draw_colors(4, index=4)

  @wasm4.blit(gun_sprite, 0, 21, 16, 16, new_biltlag)

  @wasm4.set_draw_colors(1, index=1)
  @wasm4.set_draw_colors(2, index=2)
  @wasm4.set_draw_colors(3, index=3)
  @wasm4.set_draw_colors(4, index=4)
  @wasm4.blit(sprite, 0, 3, 16, 16, new_biltlag)
  @wasm4.set_draw_colors(4) //draw UI 绘制UI
  @wasm4.rect(17, 0, 2, 160)
  @wasm4.rect(0, 112, 160, 2)
  @wasm4.rect(0, 0, 17, 2)
  @wasm4.set_draw_colors(3)
  @wasm4.set_draw_colors(2)
  @wasm4.rect(0, 114, 17, 46)
  @wasm4.set_draw_colors(3) 
  if human_active.blood>0{
  @wasm4.rect(0,114,8,human_active.blood/2)}
  if human_active.san>0{
  @wasm4.rect(10,114,8,human_active.san/2)}
  @wasm4.set_draw_colors(2, index=1)
  @wasm4.set_draw_colors(0, index=2)
  @wasm4.set_draw_colors(0, index=3)
  @wasm4.set_draw_colors(0, index=4)
  @wasm4.text("LV "+human_active.lv.to_string(),29,151)
  @wasm4.text("GOLD "+human_active.gold.to_string(),79,151)
}


fn user_UI_1() ->Unit{
  @wasm4.set_draw_colors(1)
  @wasm4.set_draw_colors(1, index=1)
  @wasm4.set_draw_colors(2, index=2)
  @wasm4.set_draw_colors(3, index=3)
  @wasm4.set_draw_colors(4, index=4)
  @wasm4.blit(gun_sprite, 0, 21, 16, 16, new_biltlag)
  @wasm4.set_draw_colors(1, index=1)
  @wasm4.set_draw_colors(2, index=2)
  @wasm4.set_draw_colors(3, index=3)
  @wasm4.set_draw_colors(4, index=4)
  @wasm4.blit(sprite, 0, 3, 16, 16, new_biltlag)
  @wasm4.set_draw_colors(2, index=1)
  @wasm4.set_draw_colors(0, index=2)
  @wasm4.set_draw_colors(0, index=3)
  @wasm4.set_draw_colors(0, index=4)
  @wasm4.set_draw_colors(4) //draw UI 绘制UI
  @wasm4.rect(17, 0, 2, 160)
  @wasm4.rect(0, 112, 160, 2)
  @wasm4.rect(0, 0, 17, 2)
  @wasm4.set_draw_colors(4)
  @wasm4.rect(0, 114, 17, 46)
  @wasm4.set_draw_colors(3) 
  if human_active.blood>0{
  @wasm4.rect(0,114,8,human_active.blood/2)}
  if human_active.san>0{
  @wasm4.rect(10,114,8,human_active.san/2)}
  @wasm4.set_draw_colors(2, index=1)
  @wasm4.set_draw_colors(0, index=2)
  @wasm4.set_draw_colors(0, index=3)
  @wasm4.set_draw_colors(0, index=4)
  @wasm4.text("LV "+human_active.lv.to_string(),29,151)
  @wasm4.text("GOLD "+human_active.gold.to_string(),79,151)
}
fn died_ui() -> Unit{
map.map_0=0
start()
@wasm4.set_draw_colors(2, index=1)
@wasm4.set_draw_colors(1, index=2)
@wasm4.set_draw_colors(3, index=3)
@wasm4.set_draw_colors(4, index=4)
@wasm4.blit(final_c_sprite,40,50,120,40,new_biltlag_0)
@wasm4.set_draw_colors(1, index=1)
@wasm4.set_draw_colors(2, index=2)
@wasm4.set_draw_colors(3, index=3)
@wasm4.set_draw_colors(4, index=4)
@wasm4.blit(state_sprite,40,100,120,20,new_biltlag)
@wasm4.set_draw_colors(1, index=1)
@wasm4.set_draw_colors(2, index=2)
@wasm4.set_draw_colors(4, index=3)
@wasm4.set_draw_colors(3, index=4)
@wasm4.blit(lost_sprite,0,0,40,160,new_biltlag)
@wasm4.set_draw_colors(4, index=1)
@wasm4.set_draw_colors(0, index=2)
@wasm4.set_draw_colors(0, index=3)
@wasm4.set_draw_colors(0, index=4)
@wasm4.text(human_active.lv.to_string(),63,104)
}
fn main_ui() -> Unit{
  @wasm4.set_draw_colors(2) //draw sky 天空
  @wasm4.rect(19, 0, 241, 24)

  @wasm4.set_draw_colors(1)
  let mut sky_0_x:Int=map.map_move_x+1
  sky_0_x=sky_0_x
  for j=0;j<12;j=j+3{
  for i=-10;i<360;i=i+2{
  @wasm4.rect(i+sky_0_x,j,1,1)  }}

  //basic background 基础背景

  @wasm4.set_draw_colors(2, index=1)
  @wasm4.set_draw_colors(3, index=2)
  @wasm4.set_draw_colors(1, index=3)
  @wasm4.set_draw_colors(0, index=4)
  @wasm4.blit(star_0_sprite,40+map.map_move_x,63,8,8,new_biltlag)
  @wasm4.blit(star_1_sprite,40+map.map_move_x,63,8,8,new_biltlag)
  @wasm4.set_draw_colors(3, index=1)
  @wasm4.set_draw_colors(2, index=2)
  @wasm4.set_draw_colors(0, index=3)
  @wasm4.set_draw_colors(4, index=4)
for i=1;i<5;i=i+1{
  @wasm4.blit(
    tree_sprite,
    (-30+map.map_move_x)+25*i ,
    3 ,
    32,
    32,
    new_biltlag,
  )}

for i=1;i<5;i=i+1{
  @wasm4.blit(
    tree_sprite,
    (-30+map.map_move_x)+25*i ,
    80 ,
    32,
    32,
    new_biltlag,
  )}

for i=1;i<7;i=i+1{
  @wasm4.blit(
    tree_sprite,
    (70+map.map_move_x)+25*i ,
    3 ,
    32,
    32,
    new_biltlag,
  )}

for i=1;i<7;i=i+1{
  @wasm4.blit(
    tree_sprite,
    (70+map.map_move_x)+25*i ,
    80 ,
    32,
    32,
    new_biltlag,
  )}

  if pit.pit_state_0==true{

  @wasm4.set_draw_colors(4)
  @wasm4.rect(130+map.map_move_x,23,16,16)
  @wasm4.rect(130+map.map_move_x,83,16,16)
  if false{
    pit.pit_state_0=true 
  }

  //pit logic check
  if human_active.human_x>= 130+map.map_move_x&&human_active.human_x<= 142+map.map_move_x&&human_active.human_y>= 23&&human_active.human_y<= 32{
    pit.timer+=1
    if pit.timer==60{
    human_active.blood-=10
    pit.timer=0}
  }
  if human_active.human_x>= 130+map.map_move_x&&human_active.human_x<= 146+map.map_move_x&&human_active.human_y>= 53&&human_active.human_y<= 69{
    pit.timer+=1
    if pit.timer==60{
    human_active.blood-=10
    pit.timer=0}
  }
@wasm4.set_draw_colors(1)
@wasm4.set_draw_colors(2)
@wasm4.rect(19,139,monster.monster_blood,4)
  


  user_UI()
  @wasm4.set_draw_colors(0, index=1)
  @wasm4.set_draw_colors(2, index=2)
  @wasm4.set_draw_colors(3, index=3)
  @wasm4.set_draw_colors(4, index=4)
  @wasm4.blit(monster_begin_0,140+map.map_move_x,40,24,24,new_biltlag)
  if word.timer1<=600{
  @wasm4.blit(first_n_sprite,39,0,100,20,new_biltlag)
  word.timer1+=1}
  }}
fn main_ui_1() -> Unit{

  

  @wasm4.set_draw_colors(4) //draw sky 
  @wasm4.rect(19, 0, 241, 24)

  @wasm4.set_draw_colors(1)
  let mut sky_0_x:Int=map.map_move_x+1
  sky_0_x=sky_0_x
  for j=0;j<12;j=j+3{
  for i=-10;i<360;i=i+2{
  @wasm4.rect(i+sky_0_x,j,1,1)  }}

  //basic background 


  @wasm4.set_draw_colors(3, index=1)
  @wasm4.set_draw_colors(2, index=2)
  @wasm4.set_draw_colors(0, index=3)
  @wasm4.set_draw_colors(4, index=4)
for i=1;i<15;i=i+1{
  @wasm4.blit(
    tree_sprite,
    (-30+map.map_move_x)+25*i ,
    3 ,
    32,
    32,
    new_biltlag,
  )}


for i=1;i<5;i=i+1{
  @wasm4.blit(
    tree_sprite,
    (350+map.map_move_x) ,
    -20+25*i ,
    32,
    32,
    new_biltlag,
  )}
  @wasm4.set_draw_colors(1, index=1)
  @wasm4.set_draw_colors(0, index=2)
  @wasm4.set_draw_colors(3, index=3)
  @wasm4.set_draw_colors(4, index=4)
@wasm4.blit(hole_sprite,218+map.map_move_x,36,68,68,new_biltlag)


  @wasm4.set_draw_colors(0, index=1)
  @wasm4.set_draw_colors(2, index=2)
  @wasm4.set_draw_colors(3, index=3)
  @wasm4.set_draw_colors(4, index=4)

monster_2.m_y1=monster_2.m_y1
monster_2.m_y2=monster_2.m_y2
monster_2.m_y3=monster_2.m_y3
if monster_2.hp1>=0{
@wasm4.blit(monster2_sprite,124+map.map_move_x,monster_2.m_y1,64,32,new_biltlag)
} 
if monster_2.hp2>=0{
@wasm4.blit(monster2_sprite,124+map.map_move_x,monster_2.m_y2,64,32,new_biltlag)
}
if monster_2.hp3>=0{
@wasm4.blit(monster2_sprite,124+map.map_move_x,monster_2.m_y3,64,32,new_biltlag)
} 
  if word.timer2<=600{
  @wasm4.blit(second_n_sprite,39,0,100,20,new_biltlag)
  word.timer2+=1}

user_UI_1()

}

fn coster_room()->Unit{
  @wasm4.set_draw_colors(1, index=1)
  @wasm4.set_draw_colors(3, index=2)
  @wasm4.set_draw_colors(2, index=3)
  @wasm4.set_draw_colors(4, index=4)
  @wasm4.blit(costeer_room_sprite,19,0,140,112,new_biltlag)
  if word.timer4<=600{
  @wasm4.blit(room_n_sprite,39,0,100,20,new_biltlag)
  word.timer4+=1}
  user_UI()
}
//shop logic
fn shop() ->Unit{
  @wasm4.set_draw_colors(1, index=1)
  @wasm4.set_draw_colors(3, index=2)
  @wasm4.set_draw_colors(2, index=3)
  @wasm4.set_draw_colors(4, index=4)
  @wasm4.blit(tv_shop_sprite,19,0,140,112,new_biltlag)
  if @wasm4.get_gamepad(index=1).button_right{
    shop_0.select_timer+=1
    if shop_0.select_shop==0{
      @wasm4.text("100G",19,114)
      if human_active.gold>=100&&@wasm4.get_gamepad(index=1).button_2{
        human_active.blood+=100
        human_active.gold-=100
      @wasm4.text("HP add 100",19,134)
      }
      if shop_0.select_timer==120{
shop_0.select_timer=0
shop_0.select_shop=30

    }}   
    if shop_0.select_shop==30{
      if human_active.gold>=100&&@wasm4.get_gamepad(index=1).button_2{
        human_active.atk_gun+=1
        human_active.gold-=100
      @wasm4.text("ATK add 1",19,134)
      }

      if shop_0.select_timer==120{
shop_0.select_timer=0
shop_0.select_shop=74

    }}
    if shop_0.select_shop==74{
      if human_active.gold>=2000&&@wasm4.get_gamepad(index=1).button_2{
        human_active.blood+=100
        human_active.gold-=2000
      }      
      @wasm4.text("2000G",19,114)
      if shop_0.select_timer==120{
shop_0.select_timer=0
shop_0.select_shop=104}

    }
    if shop_0.select_shop==104{
      @wasm4.text("???G",19,114)
      if shop_0.select_timer==120{
shop_0.select_timer=0
shop_0.select_shop=0

    }}

  }
  @wasm4.set_draw_colors(1)
  @wasm4.rect(41+shop_0.select_shop,56,8,8)

  user_UI()
}
//cave logic
fn fall_0()->Unit{
  map.map_0=0
  start()
  human_active.state=false
if @wasm4.get_gamepad(index=1).button_1||@wasm4.get_gamepad(index=1).button_2&&all_meun.next_am==6{
fall1.timer+=1
if fall1.timer==60{
  fall1.y+=1
  fall1.timer=0
  all_meun.next_am=7
  all_M(all_meun.next_am)
}
}
if fall1.y==0{  
  @wasm4.set_draw_colors(1, index=1)
  @wasm4.set_draw_colors(3, index=2)
  @wasm4.set_draw_colors(2, index=3)
  @wasm4.set_draw_colors(4, index=4)
@wasm4.blit(cave0_sprite,19,0,140,112,new_biltlag)}
user_UI()
}

//monster map2 sttack logic
fn monster2_attack() -> Unit {

if monster_2.state==true{
  if monster_2.hp1>=0{
  @wasm4.rect(monster_2.shot,monster_2.m_y1+2,2,2)
  @wasm4.rect(monster_2.shot,monster_2.m_y1+12,2,2)
  @wasm4.rect(monster_2.shot,monster_2.m_y1+22,2,2)}
  if monster_2.hp1>=0{
  @wasm4.rect(monster_2.shot,monster_2.m_y3+2,2,2)
  @wasm4.rect(monster_2.shot,monster_2.m_y3+12,2,2)
  @wasm4.rect(monster_2.shot,monster_2.m_y3+22,2,2)}
  if monster_2.hp1>=0{
  @wasm4.rect(monster_2.shot,monster_2.m_y3+2,2,2)
  @wasm4.rect(monster_2.shot,monster_2.m_y3+12,2,2)
  @wasm4.rect(monster_2.shot,monster_2.m_y3+22,2,2)}
  monster_2.timer+=1
  if monster_2.timer==2{
    monster_2.shot+=3
    monster_2.timer=0
}}

if monster_2.shot==180{
  monster_2.shot=84
}
if monster_2.shot>=human_active.human_x&&monster_2.shot<=human_active.human_x&&(((monster_2.m_y1+2>=human_active.human_y&&monster_2.m_y1+2<=human_active.human_y+16)||(monster_2.m_y1+12>=human_active.human_y&&monster_2.m_y1+12<=human_active.human_y+16)||(monster_2.m_y1+22>=human_active.human_y&&monster_2.m_y1+22<=human_active.human_y+16))||((monster_2.m_y2+2>=human_active.human_y&&monster_2.m_y2+2<=human_active.human_y+16)||(monster_2.m_y2+12>=human_active.human_y&&monster_2.m_y2+12<=human_active.human_y+16)||(monster_2.m_y2+22>=human_active.human_y&&monster_2.m_y2+22<=human_active.human_y+16))||((monster_2.m_y3+2>=human_active.human_y&&monster_2.m_y3+2<=human_active.human_y+16)||(monster_2.m_y3+12>=human_active.human_y&&monster_2.m_y3+12<=human_active.human_y+16)||(monster_2.m_y3+22>=human_active.human_y&&monster_2.m_y3+22<=human_active.human_y+16))){
  human_active.blood-=10
}}
//bossroom logic
fn final_room() ->Unit{

  @wasm4.set_draw_colors(0, index=1)
  @wasm4.set_draw_colors(3, index=2)
  @wasm4.set_draw_colors(2, index=3)
  @wasm4.set_draw_colors(4, index=4)
//reset position
  if (100-boss.move_xb<=gun_shot.gunshot_x)&&(gun_shot.gunshot_x<=(180-boss.move_xb))&&(gun_shot.gunshot_y>=10 &&gun_shot.gunshot_y<=90)&&@wasm4.get_gamepad(index=1).button_2&&all_meun.next_am==7{
boss.timer+=1
if boss.timer==60{
boss.hp-=human_active.atk_gun
gun_shot.gunshot_x=human_active.human_x
boss.timer=0}}
  if boss.state==true&& boss.hp<=10000&&boss.hp>5000{
  @wasm4.blit(moon_ui_sprite0,100-boss.move_xb,10,80,80,new_biltlag)}
  if boss.hp<5000&&boss.hp>=2000{
  @wasm4.blit(moon_ui_sprite1,100-boss.move_xb,10,80,80,new_biltlag)}
  if boss.hp<2000&&boss.hp+map.map_move_x>0&&boss.state==true{
  @wasm4.blit(moon_ui_sprite2,100-boss.move_xb,10,80,80,new_biltlag)}
  if boss.hp<=0{
    boss.state=false
    all_meun.next_am=8
  }
  //check boss state and draw shot
if boss.state == true  && all_meun.next_am==7{
  @wasm4.oval(boss.shotx1,boss.shoty1,6,6)
  @wasm4.oval(boss.shotx2,boss.shoty2,6,6)
  @wasm4.oval(boss.shotx3,boss.shoty3,6,6)
  let check_turn_xb1: Int = human_active.human_x - boss.shotx1
  let check_turn_yb1 : Int = human_active.human_y - boss.shoty1
//check shot follow human
    if check_turn_xb1 < 0 && human_active.human_x != boss.shotx1 {
      boss.movetimer+=1
      if boss.movetimer==3{
      map.map_move_x+=1
      boss.shotx1 -= 1
      boss.movetimer=0
      }
    }
    if check_turn_xb1 >= 0 && human_active.human_x != boss.shotx1 {
      boss.movetimer+=1
      if boss.movetimer==3{
      map.map_move_x+=1
      boss.shotx1 += 1
      boss.movetimer=0}
    }
    if check_turn_yb1 <= 0 && human_active.human_y != boss.shoty1 {
      boss.movetimer+=1
      if boss.movetimer==3{
    
      boss.shoty1 -= 1
      boss.movetimer=0
    }
    }
    if check_turn_yb1 > -1 && human_active.human_y != boss.shoty1 {
      boss.movetimer+=1
      if boss.movetimer==3{
  
      boss.shoty1 += 1
      boss.movetimer=0}
    }}
  let check_turn_xb2: Int = human_active.human_x - boss.shotx2
  let check_turn_yb2 : Int = human_active.human_y - boss.shoty2

    if check_turn_xb2 < 0 && human_active.human_x != boss.shotx2 {
      boss.movetimer+=1
      if boss.movetimer==3{

      boss.shotx2 -= 1
      boss.movetimer=0
      }
    }
    if check_turn_xb2 >= 0 && human_active.human_x != boss.shotx2 {
      boss.movetimer+=1
      if boss.movetimer==3{

      boss.shotx2 += 1
      boss.movetimer=0}
    }
    if check_turn_yb2 <= 0 && human_active.human_y != boss.shoty2 {
      boss.movetimer+=1
      if boss.movetimer==3{
    
      boss.shoty2 -= 1
      boss.movetimer=0
    }}
    if check_turn_yb2 > -1 && human_active.human_y != boss.shoty2 {
      boss.movetimer+=1
      if boss.movetimer==3{
  
      boss.shoty2 += 1
      boss.movetimer=0
    }}
    let check_turn_xb3: Int = human_active.human_x - boss.shotx3
    let check_turn_yb3 : Int = human_active.human_y - boss.shoty3

if check_turn_xb3 < 0 && human_active.human_x != boss.shotx3 {
      boss.movetimer+=1
      if boss.movetimer==3{
      
      boss.shotx3 -= 1
      boss.movetimer=0
      }
    }
    if check_turn_xb3 >= 0 && human_active.human_x != boss.shotx3 {
      boss.movetimer+=1
      if boss.movetimer==3{
  
      boss.shotx3 += 1
      boss.movetimer=0}
    }
    if check_turn_yb3 <= 0 && human_active.human_y != boss.shoty3 {
      boss.movetimer+=1
      if boss.movetimer==3{
    
      boss.shoty3 -= 1
      boss.movetimer=0
    }
    }
    if check_turn_yb3 > -1 && human_active.human_y != boss.shoty3 {
      boss.movetimer+=1
      if boss.movetimer==3{
  
      boss.shoty3 += 1
      boss.movetimer=0}
    }
if boss.shotx1==human_active.human_x&&boss.shoty1==human_active.human_y{
  boss.shot_timer+=1
  if boss.shot_timer==10{
  human_active.blood-=1
  boss.shot_timer=0}
}
if boss.shotx2==human_active.human_x&&boss.shoty2==human_active.human_y{
  boss.shot_timer+=1
  if boss.shot_timer==10{
  human_active.blood-=1
  boss.shot_timer=0}
}
if boss.shotx3==human_active.human_x&&boss.shoty3==human_active.human_y{
  boss.shot_timer+=1
  if boss.shot_timer==10{
  human_active.blood-=1
  boss.shot_timer=0}
}

@wasm4.set_draw_colors(1)
@wasm4.set_draw_colors(2)
@wasm4.rect(19,139,boss.hp/2,4)

  gun_shot.gunshot_y += 0

  if all_meun.next_am==7&&word.timer7<=600{
  @wasm4.blit(final_n_sprite,39,0,100,20,new_biltlag)
  word.timer7+=1

  }
  user_UI()
}
fn win() ->Unit{
  @wasm4.blit(logo_0_Sprite,0,30,160,40,new_biltlag)
  @wasm4.text("you win \n\nand save youself\nbut......",0,79)
}

