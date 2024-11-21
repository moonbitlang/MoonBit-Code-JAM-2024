// 物体类
struct Object{
  // 物体的左上角
  p:Point 
  // 物体的大小  
  size:Size
  // 物体速度
  v:Velocity   
  // attribute存储了object使用函数的索引
  attributes:Array[Int]   
}


// 根据attribute的数值，选择object函数
pub fn object_react(self:Object, map:Map, player:Player)->Unit{
  for i=0;i<self.attributes.length();i=i+1{
    match self.attributes[i]{
      1=>showThankWord(self)
      2=>showOval(self)
      3=>getDoor(self, map, player)
      4=>showSpike(self)
      5=>getSpike(self, map, player)
      6=>moveSpike(self, player)
      7=>showEasterEgg(self)
      8=>getInEasterEggLevel(self, map, player)
      9=>getOutEasterEggLevel(self, player)
      10=>showEag(self)
      11=>showSpring(self)
      12=>getSpring(self,player)
      13=>showPortals(self)
      14=>getPortals(self,player,140,110)
      15=>getPortals(self,player,50,140)
      16=>getPortals(self,player,70,40)
      17=>portalsTeleportation(self,player)
      18=>portalsMovedown(self,player)
      19=>drawTrophy(self)
      20=>map_move(self,player)
      _=>continue
    }
  }
}

pub fn getInEasterEggLevel(self:Object, map:Map, player:Player) -> Unit {
  if player.obj.p.x >= self.p.x && player.obj.p.y >= self.p.y && player.obj.p.y + player.obj.size.height <= self.p.y + self.size.height {
    map.is_pass = true
    hasEasterEgg.value = true
  }
}

pub fn getOutEasterEggLevel(self:Object, player:Player) -> Unit {
  if player.obj.p.x >= self.p.x && player.obj.p.y >= self.p.y && player.obj.p.y + player.obj.size.height <= self.p.y + self.size.height {
    hasEasterEgg.value = false
  }
}

pub fn showEasterEgg(self:Object) -> Unit {
  let x:Int=self.p.x.to_int()
  let y:Int=self.p.y.to_int()
  @wasm4.set_draw_colors(index = 1, 4)
  @wasm4.oval(x, y, self.size.width.to_int(), self.size.height.to_int())
}
pub fn getDoor(self:Object, map:Map, player:Player) -> Unit {
  if player.obj.p.x >= self.p.x && player.obj.p.y >= self.p.y && player.obj.p.y + player.obj.size.height <= self.p.y + self.size.height {
    map.is_pass = true
  }
}

pub fn showThankWord(self:Object) -> Unit { 
  let x:Int=self.p.x.to_int()
  let y:Int=self.p.y.to_int()
  @wasm4.text("Congratulations!!! \nYou've passed all \n Thanks for playing!", x, y)
}

pub fn showEag(self:Object) -> Unit {
  let x:Int=self.p.x.to_int()
  let y:Int=self.p.y.to_int()
  @wasm4.text("Contributors:", x, y)
  @wasm4.text("xuancai-xiu", x, y+15)
  @wasm4.text("artist123487654", x, y+30)
  @wasm4.text("nagisa", x, y+45)
  @wasm4.text("SKw6668888", x, y+60)
  @wasm4.text("K-ON!", x+55, y+77)
  @wasm4.text("More inform...", x+130, y)
  @wasm4.text("Bilibili videw: ", x+130, y+15)
  @wasm4.text("GoToTheDoor实况", x+130, y+30)
  @wasm4.text("CSDN article: ", x+130, y+45)
  @wasm4.text("......", x+130, y+60)

   // 设置箭头颜色，选择红色和黑色
    @wasm4.set_draw_colors(index=1, 3);  // 颜色：红色和黑色

    let x: Int = self.p.x.to_int()+100;
    let y: Int = self.p.y.to_int()+80;

    // 画箭头的箭身（长条矩形）
    @wasm4.rect(x, y, 20, 2);  // 箭身：宽20，高4

    // 画箭头的箭头部分（使用两条线段来模拟三角形）
    @wasm4.line(x + 20, y - 6, x + 30, y);  // 第一条线：箭头的上半部分
    @wasm4.line(x + 20, y + 6, x + 30, y);  // 第二条线：箭头的下半部分
    @wasm4.line(x + 19, y - 6, x + 29, y);  // 第一条线：箭头的上半部分
    @wasm4.line(x + 19, y + 6, x + 29, y);  // 第二条线：箭头的下半部分
}

pub fn showOval(self:Object) -> Unit {
  let x:Int=self.p.x.to_int()
  let y:Int=self.p.y.to_int()
  @wasm4.set_draw_colors(index = 1, 1)
  @wasm4.oval(x, y, self.size.width.to_int(), self.size.height.to_int())
}

pub fn showSpike(self:Object) -> Unit {
  let x:Int=self.p.x.to_int()
  let y:Int=self.p.y.to_int()
  let width:Int=self.size.width.to_int()
  let height:Int=self.size.height.to_int()
  @wasm4.set_draw_colors(index = 1, 2)
  for i=0;i<height;i=i+1 {
      @wasm4.line(x+i,y-i,x-i+width,y-i)
  }

}

pub fn getSpike(self:Object, map:Map, player:Player) -> Unit {
  let x:Int=self.p.x.to_int()
  let y:Int=self.p.y.to_int()
  let xx:Int=player.obj.p.x.to_int()
  let yy:Int=player.obj.p.y.to_int()
  let w:Int=player.obj.size.width.to_int()
  let h:Int=player.obj.size.height.to_int()
  let width:Int=self.size.width.to_int()
  if yy+h+xx+w-x-y>=0 && yy+h-xx+x+width-1-y>=0{
    map.is_pass = false
    player.is_dead = true
  }
}

pub fn moveSpike(self:Object, player:Player) -> Unit { 
  if player.obj.p.x >= self.p.x - 7  && self.p.x < 130{
    self.p.x += self.v.vx
  }
}

//弹簧的渲染函数
pub fn showSpring(self:Object)->Unit{
  let x:Int=self.p.x.to_int()
  let y:Int=self.p.y.to_int()
  let width:Int=self.size.width.to_int()
  let height:Int=self.size.height.to_int()
  @wasm4.set_draw_colors(index = 1, 2)
  @wasm4.line(x,y,x+width,y)
  @wasm4.line(x+width/2,y,x+width/2,y+height)
}

//检测是否碰到弹簧，弹簧碰到就起飞
pub fn getSpring(self:Object,player:Player)->Unit{
  let x:Int=self.p.x.to_int()
  let y:Int=self.p.y.to_int()
  let xx:Int=player.obj.p.x.to_int()
  let yy:Int=player.obj.p.y.to_int()
  let w:Int=player.obj.size.width.to_int()
  let h:Int=player.obj.size.height.to_int()
  let width:Int=self.size.width.to_int()
  let height:Int=self.size.height.to_int()
  if xx+w-x>=0 && xx-x-width<=0 &&  yy+h-y>=0 && yy-y-height <=0 {
    player.obj.v.vy=-player.jump_v*2
    playJumpSound()
  }
}

//传送门显示
pub fn showPortals(self:Object) -> Unit {
  let x:Int=self.p.x.to_int()
  let y:Int=self.p.y.to_int()
  @wasm4.set_draw_colors(index = 1, 4)
  @wasm4.oval(x, y, self.size.width.to_int(), self.size.height.to_int())
}

pub fn getPortals(self:Object,player:Player,to_x:Int,to_y:Int)->Unit{
  let x:Int=self.p.x.to_int()
  let y:Int=self.p.y.to_int()
  let xx:Int=player.obj.p.x.to_int()
  let yy:Int=player.obj.p.y.to_int()
  let w:Int=player.obj.size.width.to_int()
  let h:Int=player.obj.size.height.to_int()
  let width:Int=self.size.width.to_int()
  let height:Int=self.size.height.to_int()
   if xx+w-x>=0 && xx-x-width<=0 &&  yy+h-y>=0 &&yy-y-height <=0 {
    player.obj.p.x=to_x.to_double()
    player.obj.p.y=to_y.to_double()    //传送
  }
}

pub fn portalsTeleportation(self:Object,player:Player)->Unit {
  if player.obj.p.x > 45 && player.obj.p.x <50 {
     self.p.x=35
     self.p.y=140
  }
}

pub fn portalsMovedown(self:Object,player:Player)->Unit {
  if player.obj.p.x < 105 && player.obj.p.x >95 && self.p.y<=85 {
    self.p.y += self.v.vy
  }
}

pub fn drawTrophy(self:Object) -> Unit {
     @wasm4.set_draw_colors(index=1, 3);
    let x: Int = self.p.x.to_int();
    let y: Int = self.p.y.to_int();
    
     // 奖杯底座（加厚底座）
    @wasm4.rect(x - 6, y + 18, 12, 4);  // 底座宽12，高4
    
    // 奖杯支架（装饰支架）
    @wasm4.rect(x - 3, y + 14, 6, 4);  // 支架宽6，高4
    
    // 奖杯杯身（加厚设计）
    @wasm4.rect(x - 4, y + 4, 8, 10);  // 杯身宽8，高10
    
    // 奖杯杯口（加装饰的杯口）
    @wasm4.rect(x - 5, y + 2, 10, 3);  // 杯口宽10，高3
    
    // 奖杯把手左侧（更具装饰性）
    @wasm4.rect(x - 8, y + 6, 3, 6);  // 左把手宽3，高6
    @wasm4.rect(x - 9, y + 7, 5, 2);  // 左把手连接部分
    
    // 奖杯把手右侧（与左把手对称）
    @wasm4.rect(x + 5, y + 6, 3, 6);  // 右把手宽3，高6
    @wasm4.rect(x + 4, y + 7, 5, 2);  // 右把手连接部分
    
    // 奖杯杯身装饰线条（增加层次感）
    @wasm4.rect(x - 3, y + 6, 6, 2);  // 杯身装饰线，宽6，高2
    @wasm4.rect(x - 3, y + 12, 6, 2); // 中部装饰线，宽6，高2
    
    // 奖杯顶部的装饰细节（做一些细小的点缀）
    @wasm4.rect(x - 1, y + 1, 1, 1);  // 顶部装饰点
    @wasm4.rect(x + 3, y + 1, 1, 1);  // 顶部装饰点
}

pub fn map_move(self:Object,player:Player)->Unit {
  if @wasm4.get_gamepad(index=1).button_left {
    if player.obj.p.x >=0 {
      self.p.x+=player.obj.v.vx*1.2
    }
  }
  if @wasm4.get_gamepad(index=1).button_right {
    if player.obj.p.x <= 154 {
      self.p.x-=player.obj.v.vx*1.2
    }
  }
}