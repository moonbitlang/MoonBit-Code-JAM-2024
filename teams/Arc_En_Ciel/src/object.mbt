struct Word{
  mut timer7:Int
  mut timer4:Int
  mut timer2:Int
  mut timer1:Int
  

}
struct Monster {
  mut mon_x : Int
  mut mon_y : Int
  mut state : Bool
  mut movetimer : Int
  mut monster_blood : Int
  mut monster_timer : Int
  mut monster_quantity: Int
}
struct Select{
 mut select_x:Int
 mut select_y:Int
}
struct Fall{
 mut timer:Int
 mut y:Int
 mut x:Int
}

struct Music {
  mut stop:Int
  mut music_state:Bool
  mut music_list1:Int

  mut timer:Int

}
struct Boss{
  mut hp:Int
  mut shotx1:Int
  mut shotx2:Int
  mut shotx3:Int
  mut shoty1:Int
  mut shoty2:Int
  mut shoty3:Int
  mut state:Bool
  mut movetimer:Int
  mut timer:Int
  mut move_xb:Int
  mut move_yb:Int
  mut shot_timer:Int
}
struct Monster2{
 mut state:Bool
 mut hp1:Int
 mut hp2:Int
 mut hp3:Int
 mut m_y1:Int
 mut m_y2:Int
 mut m_y3:Int
 mut timer:Int
 mut timer2:Int
 mut shot:Int
 mut up:Bool

}


struct Star{
  mut star_state:Bool
  mut timer:Int
}

struct Shop{
  mut timer:Int
  mut hp:Int
  mut atk:Int
  mut heart:Int
  mut select_shop:Int
  mut select_timer:Int
}


struct Map {
  mut map_0 : Int
  mut map_move_x : Int
  mut map_move_y : Int
  mut map_text_timer : Int
  mut map_test :Int
  mut text_state: Bool
}

struct Pit{
  mut pit_state_0:Bool
  mut timer:Int
}

struct Gun_shot {
  mut gunshot_x : Int
  mut gunshot_y : Int
  mut gun_timer : Int
}

struct Human {
  mut human_x : Int
  mut human_y : Int
  mut blood : Int
  mut atk_gun : Int
  mut charater : Int
  mut state : Bool
  mut human_check_x : Int
  mut human_check_y : Int
  mut gold:Int
  mut lv:Int
  mut san:Int
  mut san_timer:Int
  mut timer:Int

}
let human_active : Human = {
  human_x: 40,
  human_y: 40,
  blood: 100,
  san:100,
  atk_gun: 1,
  charater: 0,
  state: true,
  human_check_x: 40,
  human_check_y: 40,
  gold:0,
  lv:1,
  timer:0,
  san_timer:0

}
struct Aone {
  mut a_x : Int
}
struct All_meun{
  mut next_am:Int
  mut main_meun:Int
}
let all_meun:All_meun={next_am:0,main_meun:0}

struct Moon_0{
  mut moon_timer:Int
  mut y_moon:Int
  mut moon_check:Int
}
let moon:Moon_0 ={y_moon:0,moon_timer:0,moon_check:0}
let monster_2:Monster2={up:false,shot:84,state:true,hp1:100000,hp2:100000,hp3:100000,m_y1:12,m_y2:44,m_y3:76,timer:0,timer2:0}
let shop_0:Shop={timer:0,hp:10,atk:10,heart:1,select_shop:0,select_timer:0}
let one : Aone = { a_x: 1 }
let pit:Pit={pit_state_0:true,timer:0}
let gun_shot : Gun_shot = { gunshot_x: 56, gunshot_y: 49, gun_timer: 0 }
let map : Map = { map_0: 0, map_move_x: 0, map_move_y: 0 ,map_text_timer:0 ,map_test:0,text_state:true}
let word:Word={timer7:0,timer4:0,timer2:0,timer1:0}
let fall1:Fall={timer:0,y:0,x:0}
let select_use:Select ={select_x:0,select_y:0}
let monster : Monster = { mon_x: 140, mon_y: 30, state: true, movetimer: 0,monster_blood:20 ,monster_timer:0,monster_quantity:0}
let star:Star={star_state:true,timer:0}
let music_0:Music ={timer:0,stop:0,music_list1:0,music_state:true}
let boss:Boss={shot_timer:0,move_yb:0,move_xb:0,timer:0,movetimer:0,state:true,hp:200,shotx1:80,shotx2:80,shotx3:80,shoty1:80,shoty2:80,shoty3:80}
