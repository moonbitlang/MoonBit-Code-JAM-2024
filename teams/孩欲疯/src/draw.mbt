let hp_pos : Array [Int] = [50,50,50]
pub fn draw(self : Game) -> Unit {
  self.tick+=1
  fill(0,0,160,160,4)
  if self.stage==-1 {//初始界面
    i_back_up.draw()
    i_back_down.draw()
    @wasm4.set_draw_colors(0,index=1)//半透明云朵
      cloud1.draw()
      cloud2.draw()
      move(cloud1,1,self.tick,2)
      move(cloud2,-1,self.tick,3)
    @wasm4.set_draw_colors(1,index=1)
    if i_back_down.y>80{
      coin1.x=-4
      coin1.y=10
      if self.tick%3==0{
        i_back_down.y-=1
        }
      if self.tick%8==0{
        if i_back_up.y>0{i_back_up.y-=1}
        }
      if self.tick%11==0{
        if cloud1.y>90{cloud1.y-=1}
        if cloud2.y>95{cloud2.y-=1}
      }
    }
    else{if self.tick%120<=60{
      fan.draw()
    }
    @wasm4.set_draw_colors(2,index=1)
    @wasm4.set_draw_colors(3,index=2)
    @wasm4.text("[click any button]", 9, 113)
    @wasm4.set_draw_colors(1,index=1)
    @wasm4.set_draw_colors(2,index=2)

    
    }
    
    
    if choose1.y<240{
      choose1.draw()
      choose2.draw()
      choose3.draw()
      choose1.drawout(1)
      choose2.drawout(1)
      choose3.drawout(1)
      if self.tick%2==0{
      choose1.y+=1
      choose2.y+=1
      choose3.y+=1
      }
       
    }
    }
    
  if self.stage==0{
    i_back_up.draw()
    i_back_down.draw()
    @wasm4.set_draw_colors(0,index=1)//半透明云朵
      cloud1.draw()
      cloud2.draw()
      move(cloud1,1,self.tick,2)
      move(cloud2,-1,self.tick,3)
    @wasm4.set_draw_colors(1,index=1)
    
    if i_back_down.y<160{
      if self.tick%3==0{
      i_back_down.y+=1
      }
      if self.tick%8==0{
        if i_back_up.y<32{i_back_up.y+=1}
      }
      if self.tick%11==0{
        if cloud1.y<110{cloud1.y+=1}
        if cloud2.y<115{cloud2.y+=1}
      }
    }
    else{
    @wasm4.set_draw_colors(0,index=4)//半透明硬币
    coin1.draw()
    if coin1.x>108 && coin1.x<156 && game.tick%3==0{
      coin1.y+=random_range(-3,3)
      if coin1.y<10{
        coin1.y+=2
      }
      else if coin1.y>40{
        coin1.y-=2
      }
    }
    move(coin1,1,self.tick,1)
    
    
    @wasm4.set_draw_colors(4,index=4)
    xline(1,116,5,1)
    xline(1,157,5,3)
    xline(52,116,5,1)
    xline(52,157,5,3)
    xline(103,116,5,1)
    xline(103,157,5,3)
    xline(154,116,5,1)
    xline(154,157,5,3)
    }
    choose1.draw()
    choose2.draw()
    choose3.draw()
    choose1.drawout(1)
    choose2.drawout(1)
    choose3.drawout(1)
    
    if choose1.y>117{
      if self.tick%2==0{
      choose1.y-=1
      choose2.y-=1
      choose3.y-=1
      }
    }
    }
  else if self.stage==1 || self.stage==2 {//战斗
    i_back2.draw()//敌人
    faces[game.faceIndex].draw()
    @wasm4.set_draw_colors(0,index=4)//半透明火
    for i=0;i<game.level;i=i+1{
      fires[i].draw()
    }
    @wasm4.set_draw_colors(4,index=4)//半透明火
    
    //我方属性
    if self.me.hp/2!=hp_pos[0] && self.tick%3==0 && hp_pos[0]>0{
      hp_pos[0]-=1
    }
    fill(8,81,hp_pos[0],2,1)
    fill(8,81,self.me.hp/2,2,3)
    for i = 0; i < 5; i = i + 1 {
      fill(10+5*i,73,2,2,2)
      if i<game.me.anger{
        fill(9+5*i,72,4,4,3)
      }
      else if -i>game.me.anger{
        outline(9+5*i,72,4,4,1,2)
      }
    }
    
    
    if self.enemy.hp<=100{//敌人属性
      if self.enemy.hp/2!=hp_pos[1] && self.tick%3==0 && hp_pos[1]>0{
        hp_pos[1]-=1
      }
      fill(8,4,hp_pos[1],2,1)
      fill(8,4,self.enemy.hp/2,2,3)
    }
    else{
      if (self.enemy.hp-100)/2!=hp_pos[2] && self.tick%3==0 && hp_pos[2]>0{
      hp_pos[2]-=1
      }
      fill(7,3,hp_pos[2]+2,4,1)
      fill(7,3,(self.enemy.hp-100)/2+2,4,2)
      fill(8,4,50,2,3)
    }
    
    for i = 0; i < 5; i = i + 1 {
      fill(10+5*i,12,2,2,2)
      if i<game.enemy.anger{
        fill(9+5*i,11,4,4,3)
      }
      else if -i>game.enemy.anger{
        outline(9+5*i,11,4,4,1,2)
      }
    }

    coins.draw()//金币
    mycoins.draw()
    
    outline(0,87,160,26,1,2)//中部
    fill(2,89,156,22,2)
    for i=0;i<game.level;i=i+1{
    boosts[i].draw()
    }
    boost1.drawout(-1)
    boost2.drawout(-1)
    boost3.drawout(-1)
    boost4.drawout(-1)
    boost5.drawout(-1)

    if choose1.y>160{//底部
      choose1.y=160
      choose2.y=160
      choose3.y=160
    }
    else if choose1.y>117{
      choose1.y-=1
      choose2.y-=1
      choose3.y-=1
      }
    else{
      choose1.draw()
      choose2.draw()
      choose3.draw()
    }
    xline(1,116,5,1)
    xline(1,157,5,3)
    choose1.drawout(1)
    xline(52,116,5,1)
    xline(52,157,5,3)
    choose2.drawout(1)
    xline(103,116,5,1)
    xline(103,157,5,3)
    choose3.drawout(1)
    xline(154,116,5,1)
    xline(154,157,5,3)
    if self.click_awa==1{
      outline(choose1.x+1,choose1.y+1,choose1.dx-2,choose1.dy-2,0,1)
    }
    if self.click_awa==2{
      outline(choose2.x+1,choose2.y+1,choose2.dx-2,choose1.dy-2,0,1)
    }
    if self.click_awa==3{
      outline(choose3.x+1,choose3.y+1,choose3.dx-2,choose1.dy-2,0,1)
    }

    falling.draw()//顶部动画and文字
    turnText.draw()//回合输赢
    if hhtext.x<55{//回合数
      hhtext.x+=(60-hhtext.x)/8+1
    }
    else if hhtext.x<65{
      if game.tick%2==0{
      hhtext.x+=1
      }
    }
    else if hhtext.x<160{
      hhtext.x-=(60-hhtext.x)/8-1
    }
    hhtext.draw()
    if game.stage2_case == 2 {//战败语言
      texts[game.level-1].draw()
    }
    damageText.draw()
    critText.draw()
    
  }
}

fn move(image:Image,way:Int,tick:Int,gap:Int) -> Unit{
  if tick%gap==0{
        image.x+=way
        if image.x>160+image.dx{
          image.x=-image.dx
        }
        else if image.x<-image.dx{
          image.x=160+image.dx
        }
      }
}


pub fn outline(x:Int,y:Int,dx:Int,dy:Int,light:Int,depth:Int) -> Unit{
  if light!=0{
    if light==1{
      @wasm4.set_draw_colors(1,index=1)
    }
    if light==-1{
      @wasm4.set_draw_colors(3,index=1)
    }
    @wasm4.hline(x+1,y,dx-1)
    @wasm4.vline(x+dx-1,y+1,dy-1)
    
    if light==1{
      @wasm4.set_draw_colors(3,index=1)
    }
    if light==-1{
      @wasm4.set_draw_colors(1,index=1)
    }
    @wasm4.hline(x+1,y+dy-1,dx-1)
    @wasm4.vline(x,y+1,dy-1)
    @wasm4.set_draw_colors(2,index=1)
    @wasm4.vline(x,y,1)
    @wasm4.vline(x+dx-1,y+dy-1,1)
  }
  else{
  @wasm4.set_draw_colors(2,index=1)
  @wasm4.hline(x,y,dx)
  @wasm4.vline(x,y,dy)
  @wasm4.hline(x,y+dx-1,dx)
  @wasm4.vline(x+dy-1,y,dy)

  }
  if depth>1{
    outline(x+1,y+1,dx-2,dy-2,light,depth-1)
  }
  @wasm4.set_draw_colors(1,index=1)
}

pub fn fill(x:Int,y:Int,dx:Int,dy:Int,color:UInt) -> Unit{
  if dx==0 || dy==0 {return}
  @wasm4.set_draw_colors(color,index=1)
  @wasm4.set_draw_colors(color,index=2)
  @wasm4.rect(x,y,dx,dy)
  @wasm4.set_draw_colors(1,index=1)
  @wasm4.set_draw_colors(2,index=2)
}

pub fn xline(x:Int,y:Int,length:Int,color:UInt) -> Unit{
  @wasm4.set_draw_colors(color,index=1)
    @wasm4.hline(x,y,length)
  @wasm4.set_draw_colors(1,index=1)
}

pub fn yline(x:Int,y:Int,length:Int,color:UInt) -> Unit{
  @wasm4.set_draw_colors(color,index=1)
    @wasm4.vline(x,y,length)
  @wasm4.set_draw_colors(1,index=1)
}



pub fn enemyChoosing(skill:Int) -> Unit{
  coins.wf=2
  if skill==1{
    summon_coin(1,false)
  }
  else if skill==2{
    summon_coin(2,false)

  }
  else if skill==3{
    summon_coin(3,false)

  }
  else if skill==4{
    summon_coin(5,false)
  }
}

pub fn myChoosing(skill:Int) -> Unit{
  mycoins.wf=2
  if skill==1{
    summon_coin(1,true)
  }
  else if skill==2{
    summon_coin(2,true)

  }
  else if skill==3{
    summon_coin(3,true)

  }
  else if skill==4{
    summon_coin(5,true)
  }
}

pub fn winAndFail(wf:Int)-> Unit{//-1敌人负 0平局 1敌人胜利 2玩家gg -2 敌人gg
  coins.wf=wf
  mycoins.wf=wf
  if wf==1{
    game.faceIndex=1
    turnText.text="you lose"
  }
  else if wf==0{
    game.faceIndex=2
    turnText.text="nothing"
  }
  else if wf==-1{
    game.faceIndex=3
    turnText.text="you win"
  }
  else if wf==2{
    game.faceIndex=1
    turnText.text="oh no~"
  }
  else if wf==-2{
    game.faceIndex=4
    turnText.text="you win!!!"
  }
}

pub fn turnReset()-> Unit{
  coins.wf=2
  mycoins.wf=2
  coins.num=0
  mycoins.num=0
  game.faceIndex=0
  turnText.text=""
  hhtext.x=-50
  hhtext.text="turn"+game.hh.to_string()
  
}

pub fn stageReset(me_hp:Int,enemy_hp:Int)-> Unit{
  hp_pos[0]=me_hp/2
  hp_pos[1]=50
  hp_pos[2]=(enemy_hp-100)/2
}

pub fn set_damage(damage:Int,crited:Bool) -> Unit{
  let mut zc:Int=0
  if mycoins.wf==2{
    zc=-1
  }
  else{
    zc=game.fw
  }
  damageText.set_fall2((-damage).to_string(),72,40,-1,0.5*zc.to_double(),0)
  if crited==true{
    critText.set_fall2("Crit!!",72,40,random_range(-3,3).to_double()/8,-1,0.02)
  }
}

fn summon_coin(num:Int,id:Bool) ->Unit{
  if id==false{
    coins.num=num
  }
  else{
    mycoins.num=num
  }
  let mut zc=num
  while zc>0{
    game.click_count+=zc*num*7
    zc-=1
    if id ==false{
    coins.x[zc]=random_range(70,70+24)
    coins.y[zc]=random_range(53,53+8)
    game.click_count+=coins.x[zc]
    }
    else{
    mycoins.x[zc]=random_range(70,70+24)
    mycoins.y[zc]=random_range(76,76+8)
    }
   
  }
}