
struct Game1 {
  mut timer : Int  //设置音乐播放的延迟
  mut j : Int  //设置角色行走动画播放顺序
  mut index : Int
  mut dialogue : Int //开局对话渲染
  mut stop_dialogue : Int 
  mut chan_rack : Int
  mut tip : Int //拿到扳手时播放提示的控制参数
  mut stop_tip : Int
  mut delay_ui_left : Int //让开局UI播放慢一点
  mut delay_ui_right : Int
  mut play_ui : Int //控制UI一次性播放
  mut rock_ui : Int
  mut cat_meow : Int //是否渲染猫叫
  mut if_meow : Int
  mut tool : Int
  mut stop_tool_tip : Int
  mut tool_chan : Int
  mut dairy_book : Int
  mut if_dairy : Int
  mut gameover : Int
}

//主要定义了一些切换场景的固定参数
let game : Game1 = {  
  gameover : 0,
  tool_chan : 0,
  stop_tool_tip : 0, 
  if_dairy : 0,
  dairy_book : 0,
  tool : 0, 
  if_meow : 0,
  cat_meow : 0, 
  index : 0, 
  j : 0, 
  timer : 0, 
  dialogue : 1, 
  stop_dialogue : 0, 
  chan_rack : 0, 
  tip : 0, 
  stop_tip : 0, 
  delay_ui_left : 0, 
  delay_ui_right : 0, 
  play_ui : 0, 
  rock_ui : 0
}



struct change_scene{
  mut yesorno_mainscene : Int
  mut render_Hua : Int
}
let change : change_scene = {yesorno_mainscene : 0 ,render_Hua : 0}


struct Role_pos{
  mut r_x : Int //主角的客厅位置xy
  mut r_y : Int
  mut r_xl : Int //主角的房间位置xy
  mut r_yl : Int
  mut ui_x : Int //开局ui的x
  mut ui_x1 : Int
}
let pos : Role_pos = {
  r_x : 110,
  r_y : 90,
  r_xl : 42,
  r_yl : 135,
  ui_x : 0,
  ui_x1 : 80
}

pub fn start() -> Unit {
}

pub fn update() -> Unit {
  switch_scenes()
}

