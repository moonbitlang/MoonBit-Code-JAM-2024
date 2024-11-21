pub fn start() -> Unit {
//判断设置场景当前的颜色
if map.map_0 == 0{  
  @wasm4.set_palette(1, @wasm4.rgb(0xffffff))//白色
  @wasm4.set_palette(2, @wasm4.rgb(0x403d40))//深灰色
  @wasm4.set_palette(3, @wasm4.rgb(0x706f70))//灰色
  @wasm4.set_palette(4, @wasm4.rgb(0x000000))//黑色
  }
if map.map_0 == 1{  
  @wasm4.set_palette(1, @wasm4.rgb(0xffffff))//白色
  @wasm4.set_palette(2, @wasm4.rgb(0xffc20e))//黄色
  @wasm4.set_palette(3, @wasm4.rgb(0x706f70))//灰色
  @wasm4.set_palette(4, @wasm4.rgb(0xed1c24))//红色
  }

if map.map_0 == 2{  
  @wasm4.set_palette(1, @wasm4.rgb(0xffffff))//白色
  @wasm4.set_palette(2, @wasm4.rgb(0xffc20e))//黄色
  @wasm4.set_palette(3, @wasm4.rgb(0x706f70))//灰色
  @wasm4.set_palette(4, @wasm4.rgb(0x000000))//黑色
  }
if map.map_0 == 3{  
  @wasm4.set_palette(4, @wasm4.rgb(0xffffff))//白色
  @wasm4.set_palette(2, @wasm4.rgb(0xffc20e))//黄色
  @wasm4.set_palette(3, @wasm4.rgb(0x706f70))//灰色
  @wasm4.set_palette(1, @wasm4.rgb(0x000000))//黑色
  }

  }



//use all ui
fn all_M(x:Int) -> Unit{
if x==0{
  open_UI(moon.y_moon)
  if 40+moon.y_moon==0{
 all_meun.next_am=1
 all_meun.main_meun=1}
}
if x==1{map.map_0=0
  start()
  main_ui()
}
if x==2{map.map_0=2
  start()
  main_ui_1()
  monster.state=false
}
if x==3{
  died_ui()
}
if x==4{
  coster_room()
}
if x==5{
  shop()
}
if x==6{
  fall_0()
}
if x==7{
  final_room()
}
if x==8{
  win()
}
}






pub fn update() -> Unit {

//press any key begin
if @wasm4.get_gamepad(index=1).button_1||@wasm4.get_gamepad(index=1).button_2||@wasm4.get_gamepad(index=1).button_down||@wasm4.get_gamepad(index=1).button_left||@wasm4.get_gamepad(index=1).button_right||@wasm4.get_gamepad(index=1).button_up{
moon.moon_check=1
}

//moon move
if moon.y_moon>-40&&moon.moon_check==1{
  let mut xx=0
  moon.moon_timer+=1
  xx+=1
  if xx==30{
    map.map_0=1

  }  
  if xx==39{
    map.map_0=0

  }
  if moon.moon_timer==2{
  moon.y_moon-=1
  moon.moon_timer=0}
  }
  
 //check now ui 
all_M(all_meun.next_am)
if all_meun.main_meun==1{

  //action trun left&right
  if one.a_x == 1 &&human_active.state==true{
    if human_active.charater==0{
  @wasm4.set_draw_colors(2, index=1)
  @wasm4.set_draw_colors(0, index=2)
  @wasm4.set_draw_colors(4, index=3)
  @wasm4.set_draw_colors(3, index=4)
    @wasm4.blit(
      human_sprite,
      human_active.human_x,
      human_active.human_y,
      16,
      16,
      new_biltlag,
    )}
      else if human_active.charater==1{
  @wasm4.set_draw_colors(2, index=1)
  @wasm4.set_draw_colors(3, index=2)
  @wasm4.set_draw_colors(0, index=3)
  @wasm4.set_draw_colors(4, index=4)
    @wasm4.blit(
      sword_sprite,
      human_active.human_x,
      human_active.human_y,
      16,
      16,
      new_biltlag1,
    )}
  } else if one.a_x ==0&&human_active.state==true {
    if human_active.charater==0{
  @wasm4.set_draw_colors(2, index=1)
  @wasm4.set_draw_colors(0, index=2)
  @wasm4.set_draw_colors(4, index=3)
  @wasm4.set_draw_colors(3, index=4)
    @wasm4.blit(
      human_sprite,
      human_active.human_x,
      human_active.human_y,
      16,
      16,
      new_biltlag1,
    )}
      else if human_active.charater==1{
  @wasm4.set_draw_colors(2, index=1)
  @wasm4.set_draw_colors(3, index=2)
  @wasm4.set_draw_colors(0, index=3)
  @wasm4.set_draw_colors(4, index=4)
    @wasm4.blit(
      sword_sprite,
      human_active.human_x,
      human_active.human_y,
      16,
      16,
      new_biltlag,
    )}
  }
 
// check gun shot
  if @wasm4.get_gamepad(index=1).button_right && human_active.human_x + 0 < 144 &&human_active.state==true{
    
    one.a_x = 0
    if gun_shot.gunshot_x<human_active.human_x&&one.a_x==0{
      gun_shot.gunshot_x=human_active.human_x+16
    }
    human_active.human_x += 1
    human_active.human_check_x += 1

    map.map_move_x -= 1
    if all_meun.next_am==7{
    boss.move_xb+=1}
  } else if @wasm4.get_gamepad(index=1).button_down &&human_active.human_y + 0 < 98&&human_active.state==true {
    human_active.human_y += 1
    human_active.human_check_y += 1
    map.map_move_y -= 1
    if all_meun.next_am==7{
    boss.move_yb+=1}
  } else if @wasm4.get_gamepad(index=1).button_left && human_active.human_x > 18 &&human_active.state==true{
    one.a_x = 1
      if gun_shot.gunshot_x>human_active.human_x&&one.a_x==1{
      gun_shot.gunshot_x=human_active.human_x+16
    }
    human_active.human_x -= 1
    human_active.human_check_x -= 1
        if all_meun.next_am==7{
    boss.move_xb-=1}

    map.map_move_x += 1
  } else if @wasm4.get_gamepad(index=1).button_up && human_active.human_y >= 24 &&human_active.state==true&&(human_active.human_y>=46||human_active.human_y<=56){
    human_active.human_y -= 1
    human_active.human_check_y -= 1
    map.map_move_y += 1
        if all_meun.next_am==7{
    boss.move_yb-=1}
  }


    gun_shot.gunshot_y=human_active.human_y
  if @wasm4.get_gamepad(index=1).button_2 && one.a_x == 0 &&human_active.state==true{
if human_active.charater==0{
    @wasm4.set_draw_colors(4)
    @wasm4.oval(gun_shot.gunshot_x, human_active.human_y + 4, 2, 2)}
  if human_active.charater==1{
  @wasm4.set_draw_colors(3)
  @wasm4.rect(gun_shot.gunshot_x, human_active.human_y + 3, 1, 6)
  @wasm4.rect(gun_shot.gunshot_x-1, human_active.human_y + 1, 1, 2)
  @wasm4.rect(gun_shot.gunshot_x-1, human_active.human_y + 9, 1, 2)}
    gun_shot.gunshot_x += 2
    gun_shot.gun_timer += 1
    if gun_shot.gunshot_x > 160 {
      gun_shot.gunshot_x = human_active.human_x + 16
      gun_shot.gun_timer = 0
    }
  }
  //check attack and charater
    if @wasm4.get_gamepad(index=1).button_2 && one.a_x == 1 &&human_active.state==true{
    @wasm4.set_draw_colors(4)
    @wasm4.oval(gun_shot.gunshot_x, human_active.human_y +5, 2, 2)
    if human_active.charater==1{
    @wasm4.set_draw_colors(3)
    @wasm4.rect(gun_shot.gunshot_x, human_active.human_y + 3, 1, 6)
    @wasm4.rect(gun_shot.gunshot_x-1, human_active.human_y + 1, 1, 2)
    @wasm4.rect(gun_shot.gunshot_x-1, human_active.human_y + 9, 1, 2)}
    gun_shot.gunshot_x -= 2
    gun_shot.gun_timer += 1
    if gun_shot.gunshot_x < 17 {
      gun_shot.gunshot_x = human_active.human_x
      gun_shot.gun_timer = 0
      }}
  

//map change
if human_active.human_x>140&&all_meun.next_am==1{
  all_meun.next_am=2
 all_M(all_meun.next_am)
 human_active.human_x=36

}
if human_active.human_x==19&&all_meun.next_am==2{
  all_meun.next_am=1
 all_M(all_meun.next_am)
 human_active.human_x=140
  monster.monster_quantity=0

}
if human_active.human_y==98&&@wasm4.get_gamepad(index=1).button_down&&all_meun.next_am==4&&human_active.human_x>=76&&human_active.human_x<=100{
  all_meun.next_am=1
 all_M(all_meun.next_am)
 human_active.human_x=92
 human_active.human_y=48
human_active.human_check_x=92
human_active.human_check_y=48
 monster.monster_quantity=0

}
if monster.monster_blood >=0 &&all_meun.next_am==1{
  monster.state=true
}
//monster follow and monster be attacked
if monster.state == true  && all_meun.next_am==1{
  let check_turn_x : Int = human_active.human_check_x - monster.mon_x
  let check_turn_y : Int = human_active.human_check_y - monster.mon_y
  draw_monster()

if @wasm4.get_gamepad(index=1).button_2&&(monster.mon_x<=gun_shot.gunshot_x)&&(gun_shot.gunshot_x<=(monster.mon_x+15))&&(gun_shot.gunshot_y>=monster.mon_y &&gun_shot.gunshot_y<=monster.mon_y+16){
monster.monster_blood-=human_active.atk_gun
gun_shot.gunshot_x=human_active.human_x
if monster.monster_blood<=0{
monster.state = false}
          
    }
    if check_turn_x < 0 && human_active.human_check_x != monster.mon_x {
      monster.movetimer+=1
      if monster.movetimer==3{
      
      monster.mon_x -= 1
      monster.movetimer=0
      }
    }
    if check_turn_x >= 0 && human_active.human_check_x != monster.mon_x {
      monster.movetimer+=1
      if monster.movetimer==3{
  
      monster.mon_x += 1
      monster.movetimer=0}
    }
    if check_turn_y <= 0 && human_active.human_check_y != monster.mon_y {
      monster.movetimer+=1
      if monster.movetimer==3{
    
      monster.mon_y -= 1
      monster.movetimer=0
    }
    }
    if check_turn_y > -1 && human_active.human_check_y != monster.mon_y {
      monster.movetimer+=1
      if monster.movetimer==3{
  
      monster.mon_y += 1
      monster.movetimer=0}
    }

    
    gun_shot.gunshot_y += 0
}

}
// check huyman be attacked
monster.monster_timer+=1
if monster.monster_timer==20{
monster.monster_timer=0
for i=0;i<16;i=i+1{
 if (monster.mon_x<=(human_active.human_x+i)&& (human_active.human_x+i)<=(monster.mon_x+15)) && (monster.mon_y<=(human_active.human_y+i)&& (human_active.human_y+i)<=(monster.mon_y+15))&&monster.state==true{
human_active.blood-=1

 }}}

//check human died
if human_active.blood<=0{
  human_active.state=false
  all_meun.next_am=3
}
//display text
if human_active.human_x>60{
if map.map_test<=text_0.length(){
  map.map_text_timer+=1
  if map.map_text_timer==60&&map.map_test<text_0.length(){
    map.map_test+=1
map.map_text_timer=0
  }
  if map.map_test==text_0.length(){

  map.text_state=false
  }
}
text_display()}


map.map_move_y+=1
if map.map_move_y==15{
map.map_move_y=0}


//limit monster quantity
if monster.state==false&&monster.monster_quantity!=10{
  human_active.lv+=1
  human_active.gold+=10
  monster.mon_x=140
  monster.mon_y=40
  monster.monster_blood=30
  monster.state=true
  monster.monster_quantity+=1
  gun_shot.gunshot_x=human_active.human_x
  gun_shot.gunshot_y=human_active.human_y
}
//into coster room
if human_active.human_x>85&&human_active.human_x<96&&human_active.human_y>=30&&human_active.human_y<=51&&all_meun.next_am==1{
  @wasm4.text("press x into",19,114)
  let mut x1=0
  if @wasm4.get_gamepad(index=1).button_1&&monster.state==false{
    x1+=1
    if x1!=20{
    @wasm4.rect(50,60,x1,4)}
    all_meun.next_am=4
    human_active.human_x=80
    human_active.human_y=100


  }

}

//level up add atk
human_active.atk_gun=human_active.atk_gun+human_active.lv/5
if @wasm4.get_gamepad(index=1).button_1&&human_active.charater==0{

human_active.timer+=1

if human_active.timer==60{
human_active.charater=1
human_active.timer=0
}

}
//change charater
if @wasm4.get_gamepad(index=1).button_1&&human_active.charater==1{

human_active.timer+=1

if human_active.timer==60{
human_active.charater=0
human_active.timer=0
}

}

//into shop
if human_active.human_x<=130&&human_active.human_x>=107&&human_active.human_y>=24&&human_active.human_y<=32&&all_meun.next_am==4{

  @wasm4.text("press x into shop",19,114)
  if @wasm4.get_gamepad(index=1).button_1{
    shop_0.timer+=1
    if shop_0.timer==50{
    all_meun.next_am=5
    shop_0.timer=0 
    human_active.state=false
    human_active.timer=0

     }
    }

  
}

if all_meun.next_am==5&&@wasm4.get_gamepad(index=1).button_1{
  shop_0.timer+=1
  if shop_0.timer==50{
    human_active.state=true
    all_meun.next_am=4
    human_active.timer=0
    shop_0.timer=0


  }
}

//monster2 lose hp
if all_meun.next_am==2&&gun_shot.gunshot_y>monster_2.m_y1&&gun_shot.gunshot_y<monster_2.m_y2&&@wasm4.get_gamepad(index=1).button_2{
  monster_2.timer2+=1
if monster_2.timer2==10{
  monster_2.hp1-=human_active.atk_gun
    monster_2.timer2=0
}


}
if all_meun.next_am==2&&gun_shot.gunshot_y>monster_2.m_y2&&gun_shot.gunshot_y<monster_2.m_y3&&@wasm4.get_gamepad(index=1).button_2{
  monster_2.timer2+=1
if monster_2.timer2==10{
  monster_2.hp2-=human_active.atk_gun
  monster_2.timer2=0
}
}
if all_meun.next_am==2&&gun_shot.gunshot_y>monster_2.m_y3&&gun_shot.gunshot_y<monster_2.m_y3+32&&@wasm4.get_gamepad(index=1).button_2{
  monster_2.timer2+=1
if monster_2.timer2==10{
  monster_2.hp3-=human_active.atk_gun
  monster_2.timer2=0
}
}
if all_meun.next_am==2&&monster_2.state==true&&@wasm4.get_gamepad(index=1).button_left&&human_active.human_x==55{
  human_active.human_x+=10
  map.map_move_x-=10
  monster_2.timer2=0
}

if monster_2.hp1<=0&&monster_2.hp2<=0&&monster_2.hp3<=0{
  monster_2.state=false
}

if all_meun.next_am==2{
monster2_attack()}

if monster_2.hp1<=0&&monster_2.hp2<=0&&monster_2.hp3<=0&&monster_2.up==false{
  human_active.lv+=5
  human_active.gold+=1000
  monster_2.up=true

}
if monster_2.state==false&&all_meun.next_am==2&&human_active.human_x>52&&human_active.human_x<79&&human_active.human_y>52&&human_active.human_y<79{

@wasm4.text("press x into",19,114)
if @wasm4.get_gamepad(index=1).button_1{
  all_meun.next_am=6
all_M(all_meun.next_am)
}
}
if all_meun.next_am==7{
  all_M(all_meun.next_am)
  human_active.state=true
}

if all_meun.next_am==1||all_meun.next_am==2||all_meun.next_am==7{
music_0.timer+=1
if music_0.timer==15{
music_use1(music_0.music_list1)
music_0.timer=0}}

if all_meun.next_am==4||all_meun.next_am==5{
music_0.timer+=1
if music_0.timer==15{
music_use2(music_0.music_list1)
music_0.timer=0}}
//lose san
if all_meun.next_am==1&&human_active.san>0&&monster.state==true{
  human_active.san_timer+=1
  if human_active.san_timer==120{
    
    human_active.san-=10
    human_active.san_timer=0
  }}
if all_meun.next_am==2&&human_active.san>0&&monster_2.state==true{
  human_active.san_timer+=1
  if human_active.san_timer==120{
    human_active.san-=10
    human_active.san_timer=0
  }}
if all_meun.next_am==4&&human_active.san<=100{
  human_active.san_timer+=1
  if human_active.san_timer==120{
    human_active.san+=1
    human_active.san_timer=0
  }}
if all_meun.next_am==7&&human_active.san>0&&boss.state==true{
  human_active.san_timer+=1
  if human_active.san_timer==120{
    human_active.san-=2
    human_active.san_timer=0

  }}
if all_meun.next_am==5{
  @wasm4.text("press x leaft",19,129)
}

}




