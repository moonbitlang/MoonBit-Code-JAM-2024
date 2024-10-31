pub fn srp(self : Game) -> Unit {
  if self.click==6{
    self.stage=-1
    self.click=0
  }
  if self.stuck == 0 {
    if self.stage == -1 {
      self.switch_fromf1()
    } else if self.stage == 0 {
      self.switch_from0()
    } else if self.stage == 1 {
      self.switch_from1()
    } else if self.stage == 2 {
      self.switch_from2()
    }
  } else {
    self.stuck -= 1
  }
}

pub fn initialize(self : Game) -> Unit {
  self.win_count=0
  self.fw = 0
  self.me.t=random_range(1,3)
  self.me = Character::new()
  self.refresh_Enemy()
}

//结束stage0后case是否归0: 是
pub fn switch_fromf1(self : Game) -> Unit {
  if self.click!=0 {
      self.stage = 0 
      self.stage0_case=0
      }
}
pub fn switch_from0(self : Game) -> Unit {
  if self.stage0_case == 0 {
    self.switch_from00() //跳转逻辑
  } else if self.stage0_case == 1 {
    //self.logic_set() //
    //self.switch_to00() //
    //self.logic_exit()
  } else if self.stage0_case == 2 { //***开始游戏***
    self.hh=0
    self.stage=1
    self.stage2_case=0
    self.stage1_case=0
  } else if self.stage0_case == 3 {
    self.logic_exit()
  }
}

//结束stage1后case是否归0：是
pub fn switch_from1(self : Game) -> Unit {
  if self.stage1_case == 0 {
    if (self.hh==0){self.prepare()}
    self.hh+=1
    turnReset()
    if self.level>=4{
      self.enemy.hp-=1+self.win_count
      set_damage(1+self.win_count,false)
    }
    self.get_enemyMove()
    self.switch_to11()
    //case1到case3为一个round
  } else if self.stage1_case == 1 {
    self.get_myMove()
    self.switch_to12() //播放完动画再进入下一个case
  } else if self.stage1_case == 2 {
    self.settlement()
    self.switch_to13()
    //case2无需操作直接进入case3
  } else if self.stage1_case == 3 {
    self.hp_detect()
    
  } else if self.stage1_case == 4 {//玩家gg
    self.switch_tof1()
    
  }
}

//结束stage2后case是否归0：是
pub fn switch_from2(self : Game) -> Unit {
  if self.stage2_case == 0 {
    
    self.enhance()
    self.stuck= 120
    
  } else if self.stage2_case == 1 {
    
    self.level +=1
    self.stage2_case = 2
    

  } else if self.stage2_case == 2 {
    self.hh=0
    self.getskill() //上局收获
    self.switch_to1()
  }
}


pub fn enhance(self : Game) -> Unit {
  //获取一种固定的增强 level+=1
  
  falling.set_fall(self.level+1,72,14,-0.54+0.27*(self.level).to_double(),-0.5)
  
  self.stage2_case = 1
}

pub fn getskill(self : Game) -> Unit { //增益需要调整
  if self.level == 1 {
    self.me.critRate += 10
  }
  if self.level == 2 {
    self.enemy.attack -= 2
  }
  if self.level == 5 {
    self.me.critDamage += 1
  }
}

pub fn logic_set(self : Game) -> Unit {
  if self.click==4 {

  } else if self.click==2 {

  }
}

pub fn logic_exit(self : Game) -> Unit {
  self.stage = -1
  self.stage0_case = 0
}

pub fn prepare(self : Game) -> Unit {
  self.initialize() //每局初始化
  stageReset(self.me.hp,self.enemy.hp)
}

pub fn get_myMove(self : Game) -> Unit {
  if self.click==1 {
    self.me.t=1//剪刀
  } else if self.click==2 {
    self.me.t=2//石头
  } else if self.click==3 {
    self.me.t=3//布
  } else if self.click==4{
    self.me.t=4//枪
  }
}


pub fn settlement(self : Game) -> Unit {
  self.round_outcome()
}

pub fn round_outcome(self : Game) -> Unit {
  let mut enWin:Int = 0
  if self.enemy.t==4{
    enWin=1
  }
  else if self.me.t==4{
    enWin=-1
  }
  else if self.enemy.t % 3 + 1 == self.me.t{
    enWin=-1
  }
  else if (self.enemy.t+1) % 3 + 1 == self.me.t{
    enWin=1
  }

  if enWin==0 {
    self.fw = 0 //平局
    self.enemy.hp -= 5
    self.me.hp -= 5
    set_damage(5,false)
  } else if enWin==-1 {
    self.fw = -1 //敌人失败
    self.enemy.hp -= self.me.dam_calculate()
    self.enemy.anger(1)
    self.me.anger(-1)
    if self.level>=5{
      self.me.anger(-1)
    }
    if self.level>=4{
      self.win_count+=1
    }
  } else if enWin==1{
    self.fw = 1 //敌人胜利
    self.me.hp -= self.enemy.dam_calculate()
    self.me.anger(1)
    self.enemy.anger(-1)
    if self.level>=3{
      self.me.anger(1)
    }
  }
  if self.enemy.hp<0{
      self.enemy.hp=0
    }
  if self.me.hp<0{
      self.me.hp=0
    }
}

pub fn hp_detect(self : Game) -> Unit {
  if self.enemy.hp == 0 { //***敌人死亡***
    winAndFail(-2)
    self.switch_to2()
  } else if self.me.hp == 0 { //***角色死亡***
    winAndFail(2)
    self.switch_to14()
  } else {
    //***继续游戏***
    self.stage1_case = 0
  }
}

//一种choose敌人出招的机制
pub fn get_enemyMove(self : Game) -> Unit {
  if self.me.t==4{
    self.enemy.t=4
  }
  else{
    if (self.level==0) {
      self.enemy.t=1
    }
    if (self.level==1) {
      self.enemy.t=self.hh%3+1
    }
    else if (self.level==2) {
      self.enemy.t = self.me.t%3+1
    }
    else if (self.level==3) {
      self.enemy.t = random_not(self.enemy.t,0)
    }
    else if (self.level==4) {
      if (self.fw!=-1){
        self.enemy.t=self.enemy.t
      }
      else{
      self.enemy.t = random_not(self.enemy.t,0)
      }
    }
    else if (self.level==5) {
      if (self.fw==-1){
        self.enemy.t = random_not(self.enemy.t,0)
      }
      else if (self.fw==0) {
        self.enemy.t = self.me.t%3+1
      }
      else if (self.fw==-1){
        self.enemy.t=self.enemy.t
      }
    }
  }
  self.me.t=0//本来应该检测按键是否按下作为切换回合前进条件的
}


//计算无加成回合伤害
pub fn anger(self : Character, num : Int) -> Unit { 
  if self.anger*num<0{
    self.anger=0
  }
  self.anger += num
  if self.anger <= -5 {
    self.anger = -5
  }
  if self.anger >= 5 {
    self.anger = 5
  }
}

pub fn dam_calculate(self : Character) -> Int {
  let mut damage : Int = self.attack
  let mut zc_crit = self.critRate//先减伤再枪的增伤再暴击
  let mut zc_crit_damage = self.critDamage
  let mut crited:Bool=false
  if self.anger > 0 {
    damage += self.anger*2
  }
  else {
    zc_crit-=20*self.anger
  }//angry

  if self.t==4{
    damage*=2
    zc_crit_damage+=1
  }//gun

  //boost

  if random()%100 < zc_crit { //c random()
    damage *= zc_crit_damage
    crited=true
  }//crit
  set_damage(damage,crited)
  return damage
}
