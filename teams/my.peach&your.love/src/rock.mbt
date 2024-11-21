//存储密码锁的值
let rock_dig : FixedArray[FixedArray[Int]] = [
    [1, 0, 7],
    [3, 2, 5],
    [5, 4, 3],
    [7, 6, 2],
    [9, 8, 1]
]

struct Delay_rock{
mut rock_frames:Int //玩家切换密码的延迟数
mut i:Int
mut mid:Int //交换数组元素位置的中间值
}
//增加延迟，让计算机多判断几次，否则执行太快了
pub let  delay_rock: Delay_rock = {rock_frames : 0 , i : 0 ,mid : 0}

fn render_rockscene() -> Unit{

 @wasm4.set_palette(1, @wasm4.rgb(0xd3d3d3)) // 浅灰
 @wasm4.set_palette(2, @wasm4.rgb(0x000000)) // 黑
 @wasm4.set_palette(3, @wasm4.rgb(0xffffff)) // 白  
 @wasm4.set_palette(4, @wasm4.rgb(0x696969)) // 暗灰     
 @wasm4.set_draw_colors(3,index=1)
 @wasm4.set_draw_colors(4,index=2)
 @wasm4.set_draw_colors(0,index=3)
 @wasm4.set_draw_colors(2,index=4)

 @wasm4.blit(rocks,5,5,100,60,rockflag) //渲染密码锁

 @wasm4.set_draw_colors(0,index=1)
 @wasm4.set_draw_colors(2,index=2)
 @wasm4.set_draw_colors(1,index=3)
 @wasm4.set_draw_colors(0,index=4)


 @wasm4.text(rock_dig[0][0].to_string(),33,46) //密码锁的数字
 @wasm4.text(rock_dig[0][1].to_string(),51,46)
 @wasm4.text(rock_dig[0][2].to_string(),68,46)


}

fn rock_change() -> Unit{
  if @wasm4.get_gamepad(index = 1).button_down{
    if delay_rock.rock_frames < 8{
      delay_rock.rock_frames += 1
    }
    if delay_rock.rock_frames == 8{
      delay_rock.mid = rock_dig[0][delay_rock.i]
      rock_dig[0][delay_rock.i] =  rock_dig[1][delay_rock.i]
      rock_dig[1][delay_rock.i] =  rock_dig[2][delay_rock.i]
      rock_dig[2][delay_rock.i] =  rock_dig[3][delay_rock.i]
      rock_dig[3][delay_rock.i] =  rock_dig[4][delay_rock.i]
      rock_dig[4][delay_rock.i] =  delay_rock.mid
      delay_rock.rock_frames = 0
    }
  }

  if @wasm4.get_gamepad(index = 1).button_left && delay_rock.i >= 1{
    if delay_rock.rock_frames < 8{
      delay_rock.rock_frames += 1
    }
    if delay_rock.rock_frames == 8{
      delay_rock.i -= 1
      delay_rock.rock_frames = 0
    }
  }
  if @wasm4.get_gamepad(index = 1).button_right && delay_rock.i < 2{
    if delay_rock.rock_frames < 8{
      delay_rock.rock_frames += 1
    }
    if delay_rock.rock_frames == 8 {
      delay_rock.i += 1
      delay_rock.rock_frames = 0
    }
  }
}