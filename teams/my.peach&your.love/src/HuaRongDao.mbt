//定义一个存储华容道数据的数组
let gamemap : FixedArray[FixedArray[Char]] = [
    ['8', '2', '4'],
    ['6', '7', '1'],
    ['3', ' ', '5']
]
//绘制华容道棋盘
fn render_board() -> Unit{ 
@wasm4.set_palette(1, @wasm4.rgb(0xd3d3d3)) // 浅灰
@wasm4.set_palette(2, @wasm4.rgb(0x000000)) // 黑
@wasm4.set_palette(3, @wasm4.rgb(0xffffff)) // 白  
@wasm4.set_palette(4, @wasm4.rgb(0x696969)) // 暗灰
//棋盘
  @wasm4.set_draw_colors(4)
  @wasm4.rect(20,20,40,40)
  @wasm4.rect(60,20,40,40)
  @wasm4.rect(100,20,40,40)
  @wasm4.rect(20,60,40,40)
  @wasm4.rect(60,60,40,40)
  @wasm4.rect(100,60,40,40)
  @wasm4.rect(20,100,40,40)
  @wasm4.rect(60,100,40,40)
  @wasm4.rect(100,100,40,40)
  @wasm4.set_draw_colors(2)
  @wasm4.line(20,20,139,20)
  @wasm4.line(20,21,139,21)
  @wasm4.line(20,139,139,139)
  @wasm4.line(20,138,139,138)
  @wasm4.line(20,20,20,139)
  @wasm4.line(139,20,139,139)
  @wasm4.line(138,20,138,139)
  @wasm4.line(21,20,21,139)
  @wasm4.line(60,20,60,139)
  @wasm4.line(100,20,100,139)
  @wasm4.line(21,61,139,61)
  @wasm4.line(21,101,139,101)

//棋盘上的字母
  @wasm4.set_draw_colors(3)
  @wasm4.text(gamemap[0][1].to_string(),77,37)
  @wasm4.text(gamemap[1][0].to_string(),37,77)
  @wasm4.text(gamemap[1][2].to_string(),117,77)
  @wasm4.text(gamemap[2][1].to_string(),77,117)
  @wasm4.text(gamemap[0][0].to_string(),37,37)
  @wasm4.text(gamemap[0][2].to_string(),117,37)
  @wasm4.text(gamemap[1][1].to_string(),77,77)
  @wasm4.text(gamemap[2][0].to_string(),37,117)
  @wasm4.text(gamemap[2][2].to_string(),117,117)
}

//交换旗子的逻辑
struct Delay{
mut frames:Int
mut frames1:Int
mut frames2:Int
mut frames3:Int
mut frames_role:Int //角色的延迟效果
mut frames_role1:Int
}
//增加延迟，让计算机多判断几次，否则执行太快了
pub let  delay: Delay = {frames:0,frames1:0,frames2:0,frames3:0,frames_role:0,frames_role1:0}

fn exchange_digi () -> Unit{
    //如果下键被按下，遍历寻找数组里面哪个字符串数值为' '，找到了则和上面的元素交换位置
    if @wasm4.get_gamepad(index = 1).button_down{  
        delay.frames+=1
        if delay.frames>=8{
        for i in [0,1]{
            for j in [0,1,2]{
                //let value = gamemap[i][j+1]
                if gamemap[i+1][j] == ' '{
                    let mid = gamemap[i][j]
                    gamemap[i][j] = gamemap[i+1][j]
                    gamemap[i+1][j] = mid 
                    delay.frames=0
                    break
                }
            }
        }
        }
        render_board()//交换完再渲染一次画板
    }
    if @wasm4.get_gamepad(index = 1).button_up{
        delay.frames1+=1
        if delay.frames1>=8{
        for  i in [1,2]{
            for j in [0,1,2]{
                //let value = gamemap[i][j-1]
                if gamemap[i-1][j] == ' '{
                    let mid = gamemap[i][j]
                    gamemap[i][j] = gamemap[i-1][j]   
                    gamemap[i-1][j] = mid
                    delay.frames1 = 0              
                }     
            }
            //往上往左两个旗子都会一起上去，再增加一个判断，让他跳出循环不再进行遍历和交换
            if delay.frames1 == 0{
                break
            }           
        }
        }
        render_board()
    }
    if @wasm4.get_gamepad(index = 1).button_left{
        delay.frames2+=1
        if delay.frames2>=12{
        for i in [0,1,2]{
            for j in [1,2]{
                //let value = gamemap[i-1][j]
                if gamemap[i][j-1] == ' '{
                    let mid = gamemap[i][j]
                    gamemap[i][j] = gamemap[i][j-1]
                    gamemap[i][j-1] = mid
                    delay.frames2 = 0
                }
            }
            if delay.frames2 == 0{
                break
            }           
        }
        }
        render_board()
    }
    if @wasm4.get_gamepad(index = 1).button_right{
        delay.frames3+=1
        if delay.frames3>12{
        for i in [0,1,2]{
            for j in [0,1]{
                //let value = gamemap[i+1][j]
                if gamemap[i][j+1] == ' '{
                    let mid = gamemap[i][j]
                    gamemap[i][j] = gamemap[i][j+1]
                    gamemap[i][j+1] = mid
                    delay.frames3 = 0
                } 
            }
        }
        }
        render_board()
    }
    if gamemap[0][0] == '1' && gamemap[0][1] =='2' && gamemap[0][2] == '3' && gamemap[1][0] == '4' && gamemap[1][1] == '5' && gamemap[1][2] == '6' && gamemap[2][0] == '7' && gamemap[2][1] == '8'{
        change.render_Hua += 1
    }
    //如果退出华容道，重置华容道棋盘
    if @wasm4.get_gamepad(index = 1).button_1{ 
        change.yesorno_mainscene = 0 //渲染主场景参数
        gamemap[0][0] = '8' 
        gamemap[0][1] = '2'
        gamemap[0][2] = '4'
        gamemap[1][0] = '6' 
        gamemap[1][1] = '7' 
        gamemap[1][2] = '1'
        gamemap[2][0] = '3'
        gamemap[2][1] = '5'
        gamemap[2][2] = ' '
    }
}
