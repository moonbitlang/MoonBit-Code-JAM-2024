pub fn start() -> Unit {  
  @wasm4.set_palette(1, @wasm4.rgb(0xFFF45C))
  @wasm4.set_palette(2, @wasm4.rgb(0xF6B44F))
  @wasm4.set_palette(3, @wasm4.rgb(0xEC6841))
  @wasm4.set_palette(4, @wasm4.rgb(0x3d2e14))
  @wasm4.set_draw_colors(1,index=1)
  @wasm4.set_draw_colors(2,index=2)
  @wasm4.set_draw_colors(3,index=3)
  @wasm4.set_draw_colors(4,index=4)
  
  
}
pub fn update() -> Unit {
  game.click()
  game.srp()
  game.draw()
  game.music()
}





//set界面逻辑
//developer界面逻辑
//填五关数值
pub fn click(self:Game) -> Unit{
  let mut zc=0
  if @wasm4.get_gamepad(index=1).button_left == true {
    zc=1
  }
  else if @wasm4.get_gamepad(index=1).button_down == true {
    zc=2
  }
  else if @wasm4.get_gamepad(index=1).button_right == true {
    zc=3
  }
  else if @wasm4.get_gamepad(index=1).button_up == true {
    zc=4
  }
  else  if @wasm4.get_gamepad(index=1).button_1 == true {
    zc=5
  }
  else if @wasm4.get_gamepad(index=1).button_2 == true {//z
    zc=6
  }
  else{//没有键按下
    if self.click_awa!=0{//按下并松开
    
      self.click=self.click_awa
      self.click_awa=0
    }
    else{
      self.click=0
    }
    return
  }
  //有键按下
  if self.click_awa!=zc{//刚刚按下
    self.click_awa=zc
    music_button()
  } 

}

let random_a:Int=392
let random_c:Int=29261
pub fn random()->Int{
  game.seed=(random_a*game.seed+random_c)%(game.click_count+111111)
  if game.click_count>111111{
    game.click_count=random()
  }
  return game.seed
  }

pub fn random_range(start:Int,over:Int)->Int{
  return start+random()%(over-start+1)
  }

pub fn random_not(t:Int,time:Int) -> Int{
  let  a : Int = random_range(1,3)
  if time>3{
    return t%3+1
  }
  if  t == a {
    random_not(t,time+1)
  }
  else{
    return a
  }
}