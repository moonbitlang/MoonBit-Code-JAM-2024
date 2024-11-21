// 玩家类
struct Player {
  obj:Object
  // 跳跃大小
  jump_v:Double 
  // 是否死亡
  mut is_dead:Bool
  // 玩家状态  
  mut state:Int  
  // 跳跃冷却
  mut jumpTimer:Int
}


//玩家运行函数，玩家控制，渲染都集中在这里
pub fn player_init(level:Int) -> Player {
  let mut xx = 0.0
  let mut yy = 0.0
  if level == 0 {
    xx = 145 
    yy = 110
  } else if level == 1 {
    xx = 100 
    yy = 100
  } else if level == 3 {
    xx = 0 
    yy = 60
  } else if level == 2 || level == 6 || level == 7 || level == 9 {
    xx = 10
    yy = 100
  } else if level == 4 {
    xx = 10 
    yy = 45
  } else if level == 5 {
    xx = 25 
    yy = 100
  } else if level == 8 {
    xx = 10
    yy = 100
  }

  let player:Player = {
    obj:{
      p:{x:xx, y:yy},
      size:{width:6, height:12},
      v:{vx:0.5, vy:0},
      attributes:[]
    },
    jump_v:1.35,
    is_dead:false,
    state:-1,
    jumpTimer:0,
  }
  return player
}
pub fn player_react(self:Player, map:Map) -> Unit {
  let time = map.time
  // 检测按键输入控制玩家
  self.control(map)
  // 跳跃冷却，不能跳跃完立马跳跃
  if self.jumpTimer > 0 {
    self.jumpTimer -= 1
  }
  // 玩家状态机，每个状态代表玩家的某个动作状态，用以确定渲染小人画面
  if self.state == -1 {
    self.show1(map)
  } else if self.state == 0 {
    self.show3(map)
  } else if self.state == 1 {
    self.show2(map)
  } else if self.state == 2 && time < 5 {
    self.show1(map)
  } else if self.state == 2 && time < 10 {
    self.show31(map)
  } else if self.state == 2 && time < 15 {
    self.show3(map)
  } else if self.state == 2 {
    self.show31(map)
  } else if self.state == 3 && time < 5 {
    self.show1(map)
  } else if self.state == 3 && time < 10 {
    self.show21(map)
  } else if self.state == 3 && time < 15 {
    self.show2(map)
  } else if self.state == 3 {
    self.show21(map)
  }
}


// 碰撞检测，返回Bool供control函数控制移动

pub fn groundDetect(self:Player,map:Map)->Bool {  
  // 地面检测
  for ground in map.wall_list {
    if self.obj.p.y + self.obj.size.height + 0.05 >= ground.p.y && self.obj.p.x + self.obj.size.width - 0.05 >= ground.p.x && self.obj.p.x + 0.05 <= ground.p.x + ground.size.width && self.obj.p.y < ground.p.y {
      // 调整玩家位置到地面上方 (不会陷入地面)
      self.obj.p.y = ground.p.y - self.obj.size.height;
      return true
    }
  }
  return false
}

pub fn wallDetect(self:Player,map:Map, facingdir:Int)->Bool {
  // 墙检测
  for wall in map.wall_list {
    if facingdir == 0 {
      if self.obj.p.x <= wall.p.x + wall.size.width && self.obj.p.x >= wall.p.x && (wall.p.y <= self.obj.p.y && wall.p.y + wall.size.height >= self.obj.p.y || wall.p.y >= self.obj.p.y && wall.p.y + 1 < self.obj.p.y + self.obj.size.height) {
        return true
      }
    } else if facingdir == 1 {
      if self.obj.p.x + self.obj.size.width >= wall.p.x && self.obj.p.x <= wall.p.x && (wall.p.y <= self.obj.p.y && wall.p.y + wall.size.height >= self.obj.p.y || wall.p.y >= self.obj.p.y && wall.p.y + 1 < self.obj.p.y + self.obj.size.height) { 
        return true
      }
    }
  }
  return false
}

// 玩家控制函数
pub fn control(self:Player, map:Map)->Unit {
  // 下降到一定界限，玩家死亡
  if self.obj.p.y >= 148 {
    self.is_dead = true
  }   
  // 静止站立状态
  if self.obj.v.vy == 0 {
    self.state = -1
  }   
  
  // x右移?(左)
  if @wasm4.get_gamepad(index=1).button_right && self.obj.p.x + self.obj.size.width <= 160 && not(wallDetect(self, map, 0)) && map.inverse == true {
    self.obj.p.x -= self.obj.v.vx
    if self.obj.v.vy == 0 {
      self.state = 2
    } else {
      self.state = 0
    }
  } 
  
  // x左移?(右)
  else if @wasm4.get_gamepad(index=1).button_left && self.obj.p.x >= 0 && not(wallDetect(self, map, 1)) && map.inverse == true {
    self.obj.p.x += self.obj.v.vx
    if self.obj.v.vy == 0 {
      self.state = 3
    } else {
      self.state = 1
    }
  } 

  // x右移
  else if @wasm4.get_gamepad(index=1).button_right && self.obj.p.x + self.obj.size.width <= 160 && not(wallDetect(self, map, 1))   {
    self.obj.p.x += self.obj.v.vx
    if self.obj.v.vy == 0 {
      self.state = 3
    } else {
      self.state = 1
    }
  } 
  
  // x左移
  else if @wasm4.get_gamepad(index=1).button_left && self.obj.p.x >= 0 && not(wallDetect(self, map, 0))   {
    self.obj.p.x -= self.obj.v.vx
    if self.obj.v.vy == 0 {
      self.state = 2
    } else {
      self.state = 0
    }
  }

  // y轴跳跃(有加速度)

  // 有地板才能跳跃
  if @wasm4.get_gamepad(index=1).button_up && groundDetect(self, map) && self.jumpTimer == 0 {
    self.obj.v.vy = -self.jump_v
    self.obj.p.y += self.obj.v.vy
    playJumpSound()
    self.jumpTimer = 40
    if self.state == 2 {
      self.state = 0
    } else {
      self.state = 1
    }
  } 
  
  if not(groundDetect(self, map)) {
    self.obj.v.vy += map.g
  } else {
    self.obj.v.vy = 0
  }

  self.obj.p.y += self.obj.v.vy
}

//死亡函数
pub fn die(self:Player)->Unit{
  self.is_dead = true
}
// player渲染函数

// 玩家显示形象

// 待机形象
pub fn show1(self: Player, map: Map) -> Unit {
    map.time+=0
    @wasm4.set_draw_colors(index=1, 3);
    let x: Int = self.obj.p.x.to_int();
    let y: Int = self.obj.p.y.to_int();
    // 右脚部
    @wasm4.rect(x, y + 9, 2, 4);  
    // 左脚部
    @wasm4.rect(x + 4, y + 9, 2, 4);  
    // 身体
    @wasm4.rect(x, y + 3, 6, 6);  
    // 头部
    @wasm4.rect(x + 1, y, 4, 3);
}

// 向右形象
pub fn show2(self: Player, map: Map) -> Unit {
    map.time+=0  
    @wasm4.set_draw_colors(index=1, 3);
    let x: Int = self.obj.p.x.to_int();
    let y: Int = self.obj.p.y.to_int();
    // 右脚部
    @wasm4.rect(x + 6, y + 7, 2, 4); 
    // 左脚部
    @wasm4.rect(x - 2, y + 9, 4, 2); 
    // 身体
    @wasm4.rect(x, y + 4, 6, 6);  
    // 手臂
    @wasm4.rect(x - 1, y + 4, 1, 4); 
    // 头部
    @wasm4.rect(x + 1, y + 1, 4, 4);  
}

pub fn show21(self: Player, map: Map) -> Unit {
    map.time+=0
    @wasm4.set_draw_colors(index=1, 3);
    let x: Int = self.obj.p.x.to_int();
    let y: Int = self.obj.p.y.to_int();
    // 右脚部
    @wasm4.rect(x + 5, y + 9, 2, 4); 
    // 左脚部
    @wasm4.rect(x - 1, y + 10, 3, 2); 
    // 身体
    @wasm4.rect(x, y + 4, 6, 6);  
    // 手臂
    @wasm4.rect(x -1, y + 4, 1, 4); 
    // 头部
    @wasm4.rect(x + 1, y + 1, 4, 4);  
}

// 向左形象
pub fn show3(self: Player, map: Map) -> Unit {
    map.time+=0
    @wasm4.set_draw_colors(index=1, 3);
    let x: Int = self.obj.p.x.to_int();
    let y: Int = self.obj.p.y.to_int();
    // 右脚部
    @wasm4.rect(x + 4, y + 9, 4, 2);  
    // 左脚部
    @wasm4.rect(x - 2, y + 7, 2, 4); 
    // 身体
    @wasm4.rect(x, y +  4, 6, 6);  
    // 手臂
    @wasm4.rect(x + 6, y + 4, 1, 4);  
    // 头部
    @wasm4.rect(x + 1, y + 1, 4, 4);  
}

pub fn show31(self: Player, map: Map) -> Unit {
    map.time += 0
    @wasm4.set_draw_colors(index=1, 3);
    let x: Int = self.obj.p.x.to_int();
    let y: Int = self.obj.p.y.to_int();
    // 右脚部
    @wasm4.rect(x + 3, y + 10, 3, 2);  
    // 左脚部
    @wasm4.rect(x - 1, y + 9, 2, 4); 
    // 身体
    @wasm4.rect(x, y + 4, 6, 6);  
    // 手臂
    @wasm4.rect(x + 6, y + 4, 1, 4);  
    // 头部
    @wasm4.rect(x + 1, y + 1, 4, 4);  
}

// 死亡形象
pub fn show4(self: Player, map: Map) -> Unit {
    map.time+=0
    @wasm4.set_draw_colors(index=1, 3);
    let x: Int = self.obj.p.x.to_int();
    let y: Int = self.obj.p.y.to_int();
    // 右脚部
    @wasm4.rect(x, y + 9, 2, 4); 
    // 左脚部
    @wasm4.rect(x + 4, y + 9, 2, 4); 
    // 身体
    @wasm4.rect(x + 2, y + 4, 2, 7);  
    // 手臂
    @wasm4.rect(x - 1, y + 4, 8, 2); 
    // 头部
    @wasm4.rect(x + 1, y + 2, 4, 4);  
}
