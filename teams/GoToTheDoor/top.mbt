//创建一个可变类型，表示关卡索引
let map:Ref[Map] = {value:map_init(0)}  //初始化第一关
let maptop:Ref[Int] = {value:0}

//最大关卡数-1
let max_top:Int = 8

//玩家初始化
let player:Ref[Player] = {value:player_init(0)}

let showDeathTimer:Ref[Int] = {value:0}

let temp:Ref[Int] = {value:0}

let deathCount:Ref[Int] = {value:0}

let hasEasterEgg:Ref[Bool] = {value:false}

pub fn start() -> Unit {
}

pub fn update() -> Unit {
  if player.value.is_dead == false{
    if (map.value.level_num != 7) {
      @wasm4.text("Level \{map.value.level_num}", 54, 0)  //打印关卡
    }
    player.value.player_react(map.value)
    map.value.run(player.value)
  } else {
    //玩家死亡逻辑 // 大家可以写鼓励或者嘲讽的话
    if (deathCount.value == 0) {
      @wasm4.text("You failed!", 40, 20)
      @wasm4.text("fail \{deathCount.value + 1} times", 34, 36)
      @wasm4.text("Rise, warrior!", 34, 52)
      @wasm4.text("Your determination", 10, 68)
      @wasm4.text("will lead you", 34, 84)
      @wasm4.text("to victory", 38, 100)
    } else if (deathCount.value == 1) {
      @wasm4.text("You failed!", 40, 20)
      @wasm4.text("fail \{deathCount.value + 1} times", 34, 36)
      @wasm4.text("Don't give up!", 30, 52)
      @wasm4.text("Every failure brings", 0, 68)
      @wasm4.text("you", 60, 84)
      @wasm4.text("closer to success", 12, 100)
    } else if (deathCount.value == 2) {
      @wasm4.text("You failed!", 40, 20)
      @wasm4.text("fail \{deathCount.value + 1} times", 34, 36)
      @wasm4.text("Every attempt", 32, 52)
      @wasm4.text("is a step forward", 14, 68)
      @wasm4.text("Keep going!", 40, 84)
    } else if (deathCount.value == 3) {
      @wasm4.text("You failed!", 40, 20)
      @wasm4.text("fail \{deathCount.value + 1} times", 34, 36)
      @wasm4.text("You're stronger", 20, 52)
      @wasm4.text("than", 58, 68)
      @wasm4.text("this obstacle", 32, 84)
      @wasm4.text("Keep fighting!", 28, 100)
    } else {
      @wasm4.text("You failed!", 40, 20)
      @wasm4.text("fail \{deathCount.value + 1} times", 34, 36)
      @wasm4.text("What can I say?", 20, 72)
    }
    // 禁止玩家输入
    player.value.is_dead = true
    // 播放死亡动画
    showDeathTimer.value += 1
    player.value.show4(map.value)

    // 播放死亡音效
    if (showDeathTimer.value == 1) {
      deathSound()
    }
    if (showDeathTimer.value > 120) {
      deathCount.value += 1
      map.value = map_init(maptop.value)
      player.value = player_init(maptop.value)
      showDeathTimer.value = 0
    }
  }
  
  if map.value.is_pass == true {
    deathCount.value = 0
    // 通关逻辑
    // 通关音效
    // 打印过关
    @wasm4.text("You passed!", 40, 20)  
    if (temp.value == 0) {
      passSound()
    }
    temp.value += 1
    // 如果还有下一关，则下一关
    // 彩蛋关卡
    if hasEasterEgg.value == true {
        map.value = map_init(8)
        player.value = player_init(8)
        temp.value = 0
    } else {
      if maptop.value < max_top && temp.value > 45 {
        maptop.value += 1
        map.value = map_init(maptop.value)
        player.value = player_init(maptop.value)
        temp.value = 0
     } 
    }
  }
}
