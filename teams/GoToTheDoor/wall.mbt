// 刚体类

struct Wall{
  p:Point
  size:Size
  // attribute存储了wall的函数调用的索引
  attributes:Array[Int]   
}


// 根据attribute的数值，选择wall函数，假如某个wall类型物体的attribute=[1,2],那么该wall会依次执行f1,f2函数
pub fn wall_react(self:Wall, map:Map, player:Player) -> Unit{
  for i=0;i<self.attributes.length();i=i+1{
    match self.attributes[i]{
      1=>wallRender(self)
      2=>level1MoveLeftFast(self, player)
      3=>level1MoveUpSlow(self, player)
      4=>leve1MoveLeftSlow(self)
      5=>level5MoveDownFast_UpSlow(self,player)
      6=>level5MoveDownSlow_UpSlow(self,player)
      7=>level5MoveRightFast1(self,player)
      8=>level5MoveRightFast(self,player)
      9=>level3Wall5(self,player)
      10=>level3Wall2(self,player)
      11=>level3Wall3(self,player)
      12=>level3Wall4(self,player)
      13=>level2MoveRightFast1(self, player)
      14=>level2MoveUpThenRightFast2(self)
      15=>level4MoveUpAndDown1(self)
      16=>level4MoveUpAndDown2(self)
      17=>level4MoveUpAndDown3(self)
      18=>level7Wall3(self,player)
      19=>levelFinal(self,player)
      _=>continue
    }
  }
}

//渲染函数
pub fn wallRender(self:Wall) -> Unit {
  @wasm4.set_draw_colors(index=1, 2)
  let x:Int = self.p.x.to_int()
  let y:Int = self.p.y.to_int()
  let sizeX:Int = self.size.width.to_int()
  let sizeY:Int = self.size.height.to_int()
  @wasm4.rect(x, y, sizeX, sizeY)
}

//墙下降函数
fn level1MoveLeftFast(self:Wall, player:Player) -> Unit {
  if player.obj.p.x <= 80 && self.p.y == 140 {
    self.moveleft_to(-15, 2)
  }
}

fn level1MoveUpSlow(self:Wall, player:Player) -> Unit {
  if self.p.x <= -15 && self.p.y >= 80 && player.obj.p.x <= 65{
    self.moveup_to(80, 0.2)
  }
}

fn leve1MoveLeftSlow(self:Wall) -> Unit {
  if self.p.x <= 65 && self.p.y == 80 {
    self.moveleft_to(-60, 0.5)
  }
}

fn level2MoveRightFast1(self:Wall, player:Player) -> Unit {
  if player.obj.p.x >= 106 {
    self.moveright_to(134, 2)
  }
}

fn level2MoveUpThenRightFast2(self:Wall) -> Unit {
  if (self.p.x <= -60 && self.p.y == 80) {
    self.p.y = 79
  }
  if self.p.y == 79 { 
    self.moveright_to(75, 0.3)
  }
}

fn level4MoveUpAndDown1(self:Wall) -> Unit {
  if self.p.y <= 120 && self.p.x == 20{
    self.movedown_to(120, 0.5)
  }
  if self.p.y >= 60 && self.p.x == 30{
    self.moveup_to(60, 0.5)
  }
  if self.p.y == 60 && self.p.x == 30 {
    self.p.x = 20  
  }
  if self.p.y == 120 && self.p.x == 20 {
    self.p.x = 30
  }
}
fn level4MoveUpAndDown2(self:Wall) -> Unit {
  if self.p.y <= 120 && self.p.x == 50 {
    self.movedown_to(120, 0.5)
  }
  if self.p.y >= 60 && self.p.x == 60 {
    self.moveup_to(60, 0.5)
  }
  if self.p.y == 60 && self.p.x == 60 {
    self.p.x = 50
  }
  if self.p.y == 120 && self.p.x == 50 {
    self.p.x = 60
  }
}
fn level4MoveUpAndDown3(self:Wall) -> Unit {
  if self.p.y <= 120 && self.p.x == 110 {
    self.movedown_to(120, 0.5)
  }
  if self.p.y >= 60 && self.p.x == 120 {
    self.moveup_to(60, 0.5)
  }
  if self.p.y == 60 && self.p.x == 120 {
    self.p.x = 110
  }
  if self.p.y == 120 && self.p.x == 110 {
    self.p.x = 120
  }
}
fn level5MoveDownFast_UpSlow(self:Wall, player:Player) -> Unit {
  if (player.obj.p.x <= 24 && player.obj.p.x >= 21 || self.p.x == 35) && self.p.x != 37 {
    self.movedown_to(170,5)
    self.p.x=35
  }
  if self.p.y == 170 {
    self.p.x = 37
  }
  if self.p.y > 60 && self.p.x == 37 {
    self.moveup_to(60, 0.5)
  }
}

fn level5MoveDownSlow_UpSlow(self:Wall, player:Player) -> Unit {
  if player.obj.p.x <= 72 && player.obj.p.x >= 62 && self.p.x != 63 {
    self.movedown_to(130, 0.6)
  }
  if self.p.y >= 128 {
    self.p.x = 63
  }
  if self.p.x == 63 {
    self.moveup_to(60, 0.15)
  }
}

fn level5MoveRightFast1(self:Wall, player:Player) -> Unit {
  if (player.obj.p.x >= 69 && player.obj.p.y >= 105 || self.p.y == 121) && self.p.y != 119 && (player.obj.p.x > 124 || player.obj.p.x <= 114) {
    self.moveright_to(114, 5)
    self.p.y = 121
  }
  if self.p.x >= 113 {
    self.p.y = 119
  }
}

fn level5MoveRightFast(self:Wall, player:Player) -> Unit {
  if player.obj.p.x >= 100 || self.p.y == 59 {
    self.moveright_to(160, 5)
    self.p.y = 59
  }
}

fn level3Wall5(self:Wall, player:Player) -> Unit {
  if (player.obj.p.x >= 26 || self.p.x == 44) && self.p.x != 43 {
    self.moveup_to(100, 5)
    self.p.x = 44
  }
  if self.p.y <= 100 {
    self.p.x = 43
  }
  if self.p.x == 43 {
    self.movedown_to(120, 0.2)
  }
}

fn level3Wall2(self:Wall, player:Player) -> Unit{
  if player.obj.p.x >= 72 || self.p.x == 44 {
    self.movedown_to(160, 0.5)
    self.p.x = 44
  }
}

fn level3Wall3(self:Wall, player:Player) -> Unit{
  if player.obj.p.x >= 90 {
    self.moveup_to(60, 0.5)
  }
}

fn level3Wall4(self:Wall, player:Player) -> Unit{
  if player.obj.p.x >= 120 {
    self.moveright_to(135, 5)
  }
}

fn level7Wall3(self:Wall, player:Player)->Unit {
  if player.obj.p.x >= 95  {
    self.movedown_to(250, 0.13)
  }
}
fn levelFinal(self:Wall,player:Player)->Unit {
  if player.obj.p.x > 80 {
    self.moveup_to(120,0.15)
  }
}

//通用移动函数
fn moveup_to(self:Wall, y:Double, v:Double) -> Unit {
  if self.p.y <= y {
    return
  }
  self.p.y -= v
}
fn movedown_to(self:Wall, y:Double, v:Double) -> Unit {
  if self.p.y >= y {
    return
  }
  self.p.y += v
}
fn moveleft_to(self:Wall, x:Double, v:Double) -> Unit {
  if self.p.x <= x {
    return
  }
  self.p.x -= v
}
fn moveright_to(self:Wall, x:Double, v:Double) -> Unit {
  if self.p.x >= x {
    return
  }
  self.p.x += v
}



