//关卡地图存储
struct Map{
  // wall存储
  wall_list:Array[Wall]
  // Object存储  
  obj_list:Array[Object]
  // 重力加速度  
  g:Double   
  // 是否通关
  mut is_pass:Bool
  // 记录时间  
  mut time:Int  
  // 关卡号
  level_num:Int 
  // 是否反向 
  inverse:Bool  
}


// 关卡map的运行函数，在updtate里运行这个函数
pub fn run(self:Map, player:Player) -> Unit {
  // 物体的运行
  for i = 0; i < self.obj_list.length(); i = i + 1 {
    self.obj_list[i].object_react(self, player)
  }
  // 刚体的运行
  for i = 0; i<self.wall_list.length(); i = i + 1 {
    self.wall_list[i].wall_react(self, player)
  }
  // 更新时间，这个时间是用来确定玩家状态的
  self.time = (self.time + 1) % 20  
}

// 初始化地图

pub fn map_init(level:Int) -> Map {
  let mut map:Map = {
      obj_list:[],
      wall_list:[],
      g:0.08,
      is_pass:false,
      time:0,
      level_num:level,
      inverse:false,
    }

  // 每个关卡的初始化
  if (level == 0) {
    let map0:Map = {
      obj_list:[],
      wall_list:[],
      g:0.08,
      is_pass:false,
      time:0,
      level_num:1,
      inverse:false,
    }
    //地板一号的初始化
    let wall1:Wall = {
      p:{x:0, y:140},
      size:{width:80, height:20},
      attributes:[1, 2, 3, 4]
    }
    //地板二号的初始化
    let wall2:Wall = {
      p:{x:80, y:140},
      size:{width:80, height:20},
      attributes:[1]
    }
    let wall3:Wall = {
      p:{x:80, y:80},
      size:{width:80, height:20},
      attributes:[1]
    }
    
    let door:Object = {
      p:{x:130, y:66},
      size:{width:10, height:20},
      v:{vx:0, vy:0},
      attributes:[2, 3],
    }
    //将初始化的wall，object加入map1,才能运行
    map0.wall_list.push(wall1)
    map0.wall_list.push(wall2)
    map0.wall_list.push(wall3)
    map0.obj_list.push(door)
    map = map0
  } else if (level == 1) {
    let map1:Map = {
      obj_list:[],
      wall_list:[],
      g:0.08,
      is_pass:false,
      time:0,
      level_num:2,
      inverse:false,
    }
     let wall1 = {
      p:{x:0, y:140},
      size:{width:80, height:20},
      attributes:[1, 2, 3, 4, 14]
     }
     let wall2 = {
      p:{x:80, y:140},
      size:{width:30, height:20},
      attributes:[1]
     }
     let wall3 = {
      p:{x:110, y:140},
      size:{width:40, height:20},
      attributes:[1, 13]
     }
     let door = {
      p:{x:135, y:126},
      size:{width:10, height:20},
      v:{vx:0, vy:0},
      attributes:[2, 3],
     }
     map1.wall_list.push(wall1)
     map1.wall_list.push(wall2)
     map1.wall_list.push(wall3)
     map1.obj_list.push(door)
     map = map1
  } else if (level == 2) {
    let map2:Map = {
      obj_list:[],
      wall_list:[],
      g:0.08,
      is_pass:false,
      time:0,
      level_num:3,
      inverse:false,
    }
    let wall1:Wall = {
      p:{x:0, y:120},
      size:{width:30, height:40},
      attributes:[1]
    }
    let wall2:Wall = {
      p:{x:45, y:120},
      size:{width:30, height:40},
      attributes:[1,10]
    }
    let wall3:Wall = {
      p:{x:90, y:120},
      size:{width:30, height:40},
      attributes:[1,11]
    }
    let wall4:Wall = {
      p:{x:120, y:60},
      size:{width:40, height:100},
      attributes:[1,12]
    }
    let wall5:Wall = {
      p:{x:45, y:120},
      size:{width:10, height:20},
      attributes:[1,9]
    }
    let door:Object = {
      p:{x:140, y:46},
      size:{width:10, height:20},
      v:{vx:0, vy:0},
      attributes:[2, 3],
    }
    map2.wall_list.push(wall1)
    map2.wall_list.push(wall2)
    map2.wall_list.push(wall3)
    map2.wall_list.push(wall4)
    map2.wall_list.push(wall5)
    map2.obj_list.push(door)
    map = map2
  } else if (level == 3) {
    let map3:Map = {
      obj_list:[],
      wall_list:[],
      g:0.08,
      is_pass:false,
      time:0,
      level_num:4,
      inverse:false,
    }
    let leftPlatform1:Wall = {
      p:{x:0, y:80},
      size:{width:10, height:10},
      attributes:[1]
    }
    let rightPlatform1:Wall = {
      p:{x:150, y:80},
      size:{width:30, height:10},
      attributes:[1]
    }
    let platform1:Wall = {
      p:{x:20, y:120},
      size:{width:20, height:10},
      attributes:[1, 15]
    }
    let platform2:Wall = {
      p:{x:50, y:60},
      size:{width:50, height:10},
      attributes:[1, 16]
    }
    let platform3:Wall = {
      p:{x:110, y:120},
      size:{width:30, height:10},
      attributes:[1, 17]
    }
    let door:Object = {
      p:{x:150, y:66},
      size:{width:10, height:20},
      v:{vx:0, vy:0},
      attributes:[2, 3],
    }
    let easterEgg:Object = {
      p:{x:50, y:140},
      size:{width:40, height:20},
      v:{vx:0, vy:0},
      attributes:[1, 7, 8]
    }
    map3.wall_list.push(leftPlatform1)
    map3.wall_list.push(rightPlatform1)
    map3.wall_list.push(platform1)
    map3.wall_list.push(platform2)
    map3.wall_list.push(platform3)
    map3.obj_list.push(door)
    map3.obj_list.push(easterEgg)
    map = map3
  } else if (level == 4) {
    let map4:Map = {
      obj_list:[],
      wall_list:[],
      g:0.08,
      is_pass:false,
      time:0,
      level_num:5,
      inverse:false,
    }
    let wall1:Wall = {
      p:{x:0, y:60},
      size:{width:20, height:100},
      attributes:[1]
    }
    let wall2:Wall = {
      p:{x:36, y:60},
      size:{width:10, height:6},
      attributes:[1,5]
    }
    let wall3:Wall = {
      p:{x:62, y:60},
      size:{width:10, height:6},
      attributes:[1,6]
    }
    let wall4:Wall = {
      p:{x:88, y:60},
      size:{width:10, height:6},
      attributes:[1]
    }
    let wall5:Wall = {
      p:{x:114, y:60},
      size:{width:10, height:6},
      attributes:[1,8]
    }
    let wall6:Wall = {
      p:{x:140, y:120},
      size:{width:20, height:100},
      attributes:[1]
    }
    let wall7:Wall = {
      p:{x:88, y:120},
      size:{width:10, height:6},
      attributes:[1,7]
    }
    let door:Object = {
      p:{x:150, y:106},
      size:{width:10, height:20},
      v:{vx:0, vy:0},
      attributes:[2, 3],
    }
    // 同理
    map4.wall_list.push(wall1)
    map4.wall_list.push(wall2)
    map4.wall_list.push(wall3)
    map4.wall_list.push(wall4)
    map4.wall_list.push(wall5)
    map4.wall_list.push(wall6)
    map4.wall_list.push(wall7)
    map4.obj_list.push(door)
    map = map4
  } else if (level == 5) {
    let map5:Map = {
      obj_list:[],
      wall_list:[],
      g:0.08,
      is_pass:false,
      time:0,
      level_num:6,
      inverse:true,
    }
    // let ceiling: Wall = {
    //   p:{x:0, y:0},
    //   size:{width:160, height:2},
    //   attributes:[1]
    // }
    let floor: Wall = {
      p:{x:0, y:140},
      size:{width:160, height:20},
      attributes:[1]
    }
    let wall_left:Wall = {
      p:{x:0, y: 0},
      size:{width:1, height:160},
      attributes:[1]
    }
    let wall_right:Wall = {
      p:{x:160, y: 0},
      size:{width:1, height:160},
      attributes:[1]
    }
    let door:Object = {
      p:{x:140, y:126},
      size:{width:10, height:20},
      v:{vx:0, vy:0},
      attributes:[2, 3],
    }
    let spike1:Object = {
      p:{x:50, y:139},
      size:{width:4, height:3},
      v:{vx:0, vy:0},
      attributes:[4,5]
    }
    let spike2:Object = {
      p:{x:110, y:139},
      size:{width:4, height:3},
      v:{vx:5, vy:0},
      attributes:[4,5,6]
    }
    let spike3:Object = {
      p:{x:10, y:139},
      size:{width:4, height:3},
      v:{vx:5, vy:0},
      attributes:[4,5]
    }
    // map4.wall_list.push(ceiling)
    map5.wall_list.push(floor)
    map5.wall_list.push(wall_left)
    map5.wall_list.push(wall_right)
    map5.obj_list.push(door)
    map5.obj_list.push(spike1)
    map5.obj_list.push(spike2)
    map5.obj_list.push(spike3)
    map = map5
  } else if (level == 6) {
    let map7:Map = {
      obj_list:[],
      wall_list:[],
      g:0.07,
      is_pass:false,
      time:0,
      level_num:8,
      inverse:false,
    }
    let wall1:Wall = {
      p:{x:0, y:120},
      size:{width:20, height:40},
      attributes:[1]
    }
    let wall2:Wall = {
      p:{x:60, y:60},
      size:{width:40, height:120},
      attributes:[1]
    }
    let wall3:Wall = {
      p:{x:100, y:120},
      size:{width:60, height:40},
      attributes:[1,18]
    }
    let spring1:Object = {
      p:{x:25, y:140},
      size:{width:4, height:4},
      v:{vx:0, vy:0},
      attributes:[11,12]
    }
    let spring2:Object = {
      p:{x:100, y:117},
      size:{width:4, height:4},
      v:{vx:0, vy:0},
      attributes:[11,12]
    }
    let portals1:Object = {
      p:{x:55, y:100},
      size:{width:6, height:8},
      v:{vx:0, vy:0},
      attributes:[13,14,17]
    }
    let portals2:Object = {
      p:{x:100, y:60},
      size:{width:6, height:8},
      v:{vx:0, vy:0},
      attributes:[13,15]
    }
    let portals3:Object = {
      p:{x:135, y:10},
      size:{width:6, height:8},
      v:{vx:0, vy:0.8},
      attributes:[13,16,18]
    }
    let door:Object = {
      p:{x:70, y:46},
      size:{width:10, height:20},
      v:{vx:0, vy:0},
      attributes:[2, 3, 9],
    }
    map7.wall_list.push(wall1)
    map7.wall_list.push(wall2)
    map7.wall_list.push(wall3)
    map7.obj_list.push(spring1)
    map7.obj_list.push(spring2)
    map7.obj_list.push(portals1)
    map7.obj_list.push(portals2)
    map7.obj_list.push(portals3)
    map7.obj_list.push(door)
    map = map7
  }else if (level == 7) {
    let map6:Map = {
      obj_list:[],
      wall_list:[],
      g:0.08,
      is_pass:false,
      time:0,
      level_num:7,
      inverse:false,
    }

    // 地板一号的初始化
    let wall1:Wall = {
      p:{x:0, y:140},
      size:{width:140, height:20},
      attributes:[1]
    }
    let wall2:Wall = {
      p:{x:100, y:120},
      size:{width:40, height:20},
      attributes:[1]
    }
    let spring1:Object = {
      p:{x:70, y:134},
      size:{width:6, height:6},
      v:{vx:0, vy:0},
      attributes:[11,12]
    }
    let spring2:Object = {
      p:{x:40, y:134},
      size:{width:6, height:6},
      v:{vx:0, vy:0},
      attributes:[11,12]
    }
    let trophy:Object = {
      p:{x:120, y:100},
      size:{width:0, height:0},
      v:{vx:0, vy:0},
      attributes:[19]
    }
    let thank_word:Object = {
      p:{x:0, y:40},
      size:{width:0, height:0},
      v:{vx:0, vy:0},
      attributes:[1]
    }
    // 同理
    map6.wall_list.push(wall1)
    map6.wall_list.push(wall2)
    map6.obj_list.push(spring1)
    map6.obj_list.push(spring2)
    map6.obj_list.push(trophy)
    map6.obj_list.push(thank_word)
    map = map6
  }else if (level == 8) {
    // 彩蛋关卡
    let mapEag:Map = {
      obj_list:[],
      wall_list:[],
      g:0.08,
      is_pass:false,
      time:0,
      level_num:0,
      inverse:false,
    }
    let wall1:Wall = {
      p:{x:0, y:140},
      size:{width:160, height:20},
      attributes:[1,20]
    }
    let eggWord:Object = {
      p:{x:5, y:15},
      size:{width:0, height:0},
      v:{vx:0, vy:0},
      attributes:[10,20]
    }
    let door:Object = {
      p:{x:260, y:126},
      size:{width:10, height:20},
      v:{vx:0, vy:0},
      attributes:[2, 3, 9,20],
    }
    mapEag.wall_list.push(wall1)
    mapEag.obj_list.push(eggWord)
    mapEag.obj_list.push(door)
    map = mapEag
  }
  return map
}