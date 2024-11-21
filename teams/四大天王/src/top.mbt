//初始化棋子
let white:Int =-1 
let black:Int =1
let blank:Int =0
let max_row:Int =16
let max_col:Int =16
let chessboard:FixedArray[FixedArray[Int]]=[
    [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],  
    [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0], 
    [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
  ]

struct GameStat{
 mut game_state:String
}

// }
let game:GameStat={game_state:"menu"}


pub fn update() -> Unit {
    // 如果在菜单界面，则显示游戏开始界面
    let gamepad=@wasm4.get_gamepad()
    if game.game_state == "menu" {
         @wasm4.set_draw_colors(4)
        @wasm4.rect(0,0,160,160)
        @wasm4.set_draw_colors(2);
         @wasm4.text("<<five-in-a-row>>", 15, 40); 
        @wasm4.text("Press left to Play", 10, 60); // 显示开始提示文字

        // 检测按钮
        if gamepad.button_left {
            game.game_state = "start"; // 切换到游戏状态
        }
        return; // 不进入后续逻辑
    }

     // 如果是游戏开始状态，初始化棋盘
    if game.game_state == "start" {
        game.game_state = "play";
    }

    // 游戏中的逻辑
    if game.game_state == "play" {
        // 画棋盘
      draw_chessboard(); 
        // 绘制棋盘和棋子
        draw_chessman(chessboard);

        // 检测棋盘状态
        person_computer_random();
        
        // 检查是否有玩家胜出
        let result = is_win(chessboard);
        if result == black {
            // @wasm4.trace("b win")
            @wasm4.set_draw_colors(4)
            @wasm4.rect(0,0,160,160)
            @wasm4.set_draw_colors(2)
            @wasm4.text("Black wins!", 10, 10);
            @wasm4.text("Press left to Play", 10, 40);
            if gamepad.button_left{
            game.game_state = "gameover"; // 结束后返回菜单
            }
        } else if result == white {
             @wasm4.set_draw_colors(4)
             @wasm4.rect(0,0,160,160)
               @wasm4.set_draw_colors(2)
               @wasm4.text("Press left to Play", 10, 40);
            @wasm4.text("White wins!", 10, 10);
            if gamepad.button_left{
            game.game_state = "gameover"; // 结束后返回菜单
            }
        }
        
         //判断棋盘是否填满
    if is_full(chessboard) == 1{
         @wasm4.set_draw_colors(4)
         @wasm4.rect(0,0,160,160)
        @wasm4.set_draw_colors(2);
          @wasm4.text("Game Over", 40, 40);
        @wasm4.text("Press right to Menu", 5, 60);
        if gamepad.button_left{
         // 重置棋盘并返回菜单
            reset_chessboard();
            game.game_state = "menu";
        }
    }
    }

     // 游戏结束界面，等待玩家按下“开始”按钮回到主菜单
    if game.game_state == "gameover" {
        @wasm4.set_draw_colors(4)
         @wasm4.rect(0,0,160,160)
        @wasm4.set_draw_colors(2);
        @wasm4.text("Game Over", 40, 40);
        @wasm4.text("Press right to Menu", 5, 60);

        if gamepad.button_right{
            // 重置棋盘并返回菜单
            reset_chessboard();
            game.game_state = "menu";
        }
    }
 }


pub fn start() -> Unit {
    @wasm4.trace("Game started!")
}

// 初始化棋盘的绘制
pub fn draw_chessboard() -> Unit {
    @wasm4.set_draw_colors(3); 
    @wasm4.rect(0,0,160,160)
    @wasm4.set_draw_colors(2)
@wasm4.line(5,0,5,160)
 @wasm4.line(15,0,15,160)
 @wasm4.line(25,0,25,160)
 @wasm4.line(35,0,35,160) 
 @wasm4.line(45,0,45,160)
 @wasm4.line(55,0,55,160)
 @wasm4.line(65,0,65,160)
 @wasm4.line(75,0,75,160)
 @wasm4.line(85,0,85,160)
 @wasm4.line(95,0,95,160)
 @wasm4.line(105,0,105,160)
 @wasm4.line(115,0,115,160)
 @wasm4.line(125,0,125,160)
 @wasm4.line(135,0,135,160)
 @wasm4.line(145,0,145,160)
  @wasm4.line(155,0,155,160)

 @wasm4.line(0,5,160,5)
 @wasm4.line(0,15,160,15)
 @wasm4.line(0,25,160,25)
 @wasm4.line(0,35,160,35) 
 @wasm4.line(0,45,160,45)
 @wasm4.line(0,55,160,55)
 @wasm4.line(0,65,160,65)
 @wasm4.line(0,75,160,75)
 @wasm4.line(0,85,160,85)
 @wasm4.line(0,95,160,95)
 @wasm4.line(0,105,160,105)
 @wasm4.line(0,115,160,115)
 @wasm4.line(0,125,160,125)
  @wasm4.line(0,135,160,135)
 @wasm4.line(0,145,160,145)
 @wasm4.line(0,155,160,155)
}

// 重置棋盘
pub fn reset_chessboard() -> Unit {
    for i = 0; i < max_row; i = i + 1 {
        for j = 0; j < max_col; j = j + 1 {
            chessboard[i][j] = blank;
        }
    }
}

//初始化棋子
pub fn draw_chessman(chessboard:FixedArray[FixedArray[Int]])->Unit {
    for i=0;i<max_row;i=i+1{
        for j=0;j<max_col;j=j+1{
    if chessboard[i][j] == white{
        @wasm4.set_draw_colors(1);
        @wasm4.oval(i*10,j*10,10,10);
}
    if chessboard[i][j] == black{     
        @wasm4.set_draw_colors(4);
        @wasm4.oval(i*10,j*10,10,10)
  }
    if chessboard[i][j] ==blank{ }
    }}
}

//判断胜负
//返回当前棋子的值，若值为1，代表黑棋胜，若值为-1，代表白棋胜
pub fn is_win( chessboard:FixedArray[FixedArray[Int]])->Int {  
  for i = 0; i <max_row; i=i+1 {
        for j = 0; j < max_col; j=j+1 {
            if chessboard[i][j] ==blank{
                continue;
      }
            //  (-)横着连成五子
            if j < max_col - 4{
                if chessboard[i][j] == chessboard[i][j + 1] && 
            chessboard[i][j] ==  chessboard[i][j + 2]&& 
              chessboard[i][j] == chessboard[i][j + 3] && 
               chessboard[i][j] == chessboard[i][j + 4]{
                    return chessboard[i][j];}
      }
            //  (|)竖着连成五子
            if i < max_row - 4{
                if chessboard[i][j] == chessboard[i + 1][j] && 
              chessboard[i][j] == chessboard[i + 2][j]&& 
                chessboard[i][j] ==chessboard[i + 3][j] && 
                  chessboard[i][j] ==chessboard[i + 4][j]{
                    return chessboard[i][j];}
      }
            //  (\)左斜连成五子
            if i < max_row- 4 && j < max_col - 4{
                if chessboard[i][j] == chessboard[i + 1][j + 1] &&
             chessboard[i][j] == chessboard[i + 2][j + 2]&&
                        chessboard[i][j] == chessboard[i + 3][j + 3] &&
                  chessboard[i][j] == chessboard[i + 4][j + 4]{
                    return chessboard[i][j];}
      }
            //  (/)右斜连成五子 
            if i < max_row- 4 && j > 4{                 
                if chessboard[i][j] == chessboard[i + 1][j - 1] &&
             chessboard[i][j] ==chessboard[i + 2][j - 2]&& 
              chessboard[i][j] == chessboard[i + 3][j - 3] &&
                chessboard[i][j] == chessboard[i + 4][j - 4]{
                    return chessboard[i][j];}
      }
        }
    }
    return blank;
}


//判断棋盘是否已满
pub fn is_full(chessboard:FixedArray[FixedArray[Int]])-> Int{
    let mut ret= 1
    for i = 0; i < max_row; i=i+1 {
        for j = 0; j < max_col; j=j+1 {
            if chessboard[i][j] ==blank{
                ret = 0;
                break;
            }
        }
    }
    return ret;
}

//人机对战
//人机对战
pub fn person_computer_random()->Unit {
    let mouse=@wasm4.get_mouse()
    let gamepad=@wasm4.get_gamepad()
    let mut place=false
    for step=1; step <= 2;step=step+1 {
        if step % 2 == 1 &&place==false{
                if mouse.left{
                        if chessboard[mouse.x/10][mouse.y/10] ==white||chessboard[mouse.x/10][mouse.y/10] ==black{
                            continue;
                        }
                                    chessboard[mouse.x/10][mouse.y/10] = black;
                                    draw_chessman(chessboard);
                                     @wasm4.tone(
                                       (2000, 0),
                                       @wasm4.ADSR::new(5),
                                       @wasm4.ADSRVolume::new(100),
                                       @wasm4.ToneFlag::new(),
                                        )
                         place=true
                    }
            if is_win(chessboard) == black {
        if gamepad.button_left{
        for i = 0; i < max_row; i=i+1 {
            for j = 0; j < max_col; j=j+1 {
                chessboard[i][j]=0;
                }
                }
        }
                break;
            }
        }
          if step % 2 == 0&&place==true{
            let (i, j) = find_best_move(chessboard, black)
                if chessboard[i][j] ==blank{
                    chessboard[i][j] = white;
                    draw_chessman(chessboard);     
                    @wasm4.tone(
                     (2000, 0),
                    @wasm4.ADSR::new(5),
                     @wasm4.ADSRVolume::new(100),
                    @wasm4.ToneFlag::new(),
                    )     
                }
            if is_win(chessboard) == white {
        if gamepad.button_left{
        for i = 0; i < max_row; i=i+1 {
            for j = 0; j < max_col; j=j+1 {
                chessboard[i][j]=0;
                }
                }
        }
                break;
            }
        }
       
    }
    if is_full(chessboard) == 1{
        if gamepad.button_left{
        for i = 0; i < max_row; i=i+1 {
            for j = 0; j < max_col; j=j+1 {
                chessboard[i][j]=0;
                }
                }
        }
        @wasm4.text("is full", 10, 10);
    }
    }


// 启发式算法：选择最优的落子位置
pub fn find_best_move(chessboard: FixedArray[FixedArray[Int]], player: Int) -> (Int, Int) {
    let mut best_score = -9999999
    let mut best_move = (0, 0)

    // 遍历棋盘
    for i = 0; i < max_row; i=i+1 {
        for j = 0; j < max_col; j=j+1 {
            if chessboard[i][j] == blank {
                // 暂时模拟下一个落子
                chessboard[i][j] = player
                let score = evaluate_board(chessboard, player)
                // 恢复棋盘
                chessboard[i][j] = blank
                
                if score > best_score {
                    best_score = score
                    best_move = (i, j)
                }
            }
        }
    }

    best_move
}

// 评估当前棋盘状态的得分
pub fn evaluate_board(chessboard: FixedArray[FixedArray[Int]], player: Int) -> Int {
    let mut score = 0

    // 扫描棋盘所有方向，横竖斜方向评估
    for i = 0; i < max_row; i=i+1 {
        for j = 0; j < max_col; j=j+1 {
            if chessboard[i][j] == player {
                score += evaluate_line(chessboard, i, j, player)
            }
        }
    }
    
    score
}

// 评估某一方向上的得分
pub fn evaluate_line(chessboard: FixedArray[FixedArray[Int]], x: Int, y: Int, player: Int) -> Int {
    let mut score = 0
    let directions = [
        (1, 0),   // 横向
        (0, 1),   // 纵向
        (1, 1),   // 左斜
        (1, -1),  // 右斜
    ]

    for i=0;i<4;i=i+1 {
        let (dx,dy)=directions[i];
        let mut count = 0
        let mut block = false
        for step=0;step<5;step=step+1{
            let nx = x + dx * step
            let ny = y + dy * step

            // 如果超出棋盘范围或者遇到对方棋子，停止计数
            if nx < 0 || nx >= max_row || ny < 0 || ny >= max_col || chessboard[nx][ny] == -player {
                block = true
                break
            }

            if chessboard[nx][ny] == player {
                count += 1
            } else if chessboard[nx][ny] == blank {
                // 空位，暂时不增加分数
                break
            }
        }
        // 如果没有堵住的情况，算分
        if  block==false {
            score += count * 10
        }
    }
    score
}
