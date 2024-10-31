struct Game {
  mut me : Character
  mut enemy : Character
  mut stage : Int
  mut stage0_case : Int
  mut stage1_case : Int
  mut stage2_case : Int
  mut level : Int
  mut hh:Int
  mut win_count:Int//玩家胜利局数
  mut fw:Int//记录敌人上把输赢
  
  mut click_awa : Int 

  mut stuck:Int
  mut tick:Int
  mut click_count:Int

  mut index:Int

  mut faceIndex:Int

  mut seed:Int

  mut click:Int


}

struct Character {
  mut hp : Int
  mut t : Int//选择(不重置)
  mut attack : Int
  mut critRate : Int
  mut critDamage : Int
  mut anger : Int
}

let game : Game = Game::new()

pub fn Game::new() -> Game {
  {
    me: Character::new(),
    enemy: Character::new(),
    stage: -1,
    stage0_case: 0,
    stage1_case: 0,
    stage2_case: 0,
    level: 0,
    hh:0,
    win_count:0,
    fw:0,
    stuck: 0,
    click_awa: 0,
    tick:0,
    click_count:0,
    index:0,
    faceIndex:1,
    seed:1234,
    click:0,//0未按下 1左 2下 3右 4上 5z 6x

  }
}

pub fn Character::new() -> Character {
  {
    hp: 100,
    t: 0,
    attack: 10,
    critRate: 10,
    critDamage: 2,
    anger: 0,
  }
}

//刷新敌人数值
pub fn refresh_Enemy(self : Game) -> Unit {
  self.enemy = {
      hp: 100,
      t: random_range(1,3),
      attack: 10,
      critRate: 10,
      critDamage: 2,
      anger: 0,
    }
  self.enemy.hp=100+self.level*20
}


//dam = (at+anger)*cD
//需要初始化influ

// 获取我的出招 **建议放top（为什么把函数放data里面）
//**在top获取输入，然后触发game的left down right函数
