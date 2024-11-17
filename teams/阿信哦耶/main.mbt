pub struct Game {
  mut seed : Int // 使用一个固定的初始种子值
  mut cards : Array[Int] // 存储卡片上的数字
  mut target : Int // 目标数字，固定为24
  mut userInput : String // 用户的输入记录
  mut numCount : Int // 当前表达式中的数字数量
  mut selectedCard : Int // 当前选中的卡片索引
  mut selectedOperator : Int // 当前选中的操作符索引
  mut prevGamePad : @wasm4.GamePad // 上一帧的按键状态
  mut button1Pressed : Bool // 追踪 Button1 的按下状态
}

let operators = ["+", "-", "*", "/"]

let font_x : Int = 5

let font_y : Int = 5

let g : Game = Game::{
  seed: 12345,
  cards: [0, 0, 0, 0],
  target: 24,
  userInput: "",
  numCount: 0,
  selectedCard: 0,
  selectedOperator: 0,
  prevGamePad: @wasm4.GamePad::default(),
  button1Pressed: false,
}

pub fn start() -> Unit {
  resetGame()
  @wasm4.text("24 Points Game", font_x, font_y)
}

// 随机数生成函数
fn random(max : Int) -> Int {
  g.seed = g.seed * 16807 % 2147483647
  return g.seed % max + 1
}

// 生成4张卡片上的随机数字
fn resetGame() -> Unit {
  for i = 0; i < 4; i = i + 1 {
    g.cards[i] = random(10)
  }
  g.userInput = ""
  g.numCount = 0
}

pub fn update() -> Unit {
  let gamePad = @wasm4.get_gamepad()
  if gamePad != g.prevGamePad {
    // 控制卡片选择
    if gamePad.button_left {
      g.selectedCard = (g.selectedCard - 1 + g.cards.length()) %
        g.cards.length()
    } else if gamePad.button_right {
      g.selectedCard = (g.selectedCard + 1) % g.cards.length()
    }

    // 控制操作符选择
    if gamePad.button_up {
      g.selectedOperator = (g.selectedOperator - 1 + operators.length()) %
        operators.length()
    } else if gamePad.button_down {
      g.selectedOperator = (g.selectedOperator + 1) % operators.length()
    }

    // 检查是否按下 Button1，并仅在未按下状态下进行选择操作
    if gamePad.button_1 && not(g.button1Pressed) {
      if g.numCount < 4 {
        g.userInput += g.cards[g.selectedCard].to_string()
        g.numCount += 1
        if g.numCount < 4 {
          g.userInput += " " + operators[g.selectedOperator] + " "
        }
      }
      g.button1Pressed = true
    }

    // 如果 Button1 未按下，将其状态重置为未按下
    if not(gamePad.button_1) {
      g.button1Pressed = false
    }

    // 检查是否完成表达式并显示结果
    if gamePad.button_2 {
      g.userInput = if checkResult() { "You win!" } else { "Try again!" }
    }
  }
  g.prevGamePad = gamePad
  drawGame()
}

fn drawGame() -> Unit {
  @wasm4.text("24 Points Game", font_x, font_y)
  @wasm4.text("Use arrows to select", font_x, font_y + 10)
  for i = 0; i < 4; i = i + 1 {
    let yPos = font_y + 20 + i * 10
    let cardText = if i == g.selectedCard {
      "> Card " + i.to_string() + ": " + g.cards[i].to_string()
    } else {
      "Card " + i.to_string() + ": " + g.cards[i].to_string()
    }
    @wasm4.text(cardText, font_x, yPos)
  }
  @wasm4.text("Operator: " + operators[g.selectedOperator], font_x, font_y + 60)
  @wasm4.text("Expr: ", font_x, font_y + 70)
  @wasm4.text(g.userInput, font_x, font_y + 80)
  @wasm4.text("Btn1=Select", font_x, font_y + 90)
  @wasm4.text("Btn2=Check", font_x, font_y + 100)
}

fn checkResult() -> Bool {
  let tokens = g.userInput.split(" ").to_array()
  if tokens.length() < 7 {
    return false
  }
  let mut result = string_to_int(tokens[0])
  for i = 1; i < tokens.length(); i = i + 2 {
    let operator = tokens[i]
    let nextValue = string_to_int(tokens[i + 1])
    if operator == "+" {
      result += nextValue
    }
    if operator == "-" {
      result -= nextValue
    }
    if operator == "*" {
      result *= nextValue
    }
    if operator == "/" {
      result /= nextValue
    }
  }
  if result == g.target {
    g.userInput = "You win!"
    resetGame() // 胜利后重新生成新的卡片数值
    return true
  } else {
    g.userInput = "Try again!"
    resetGame() // 失败后也重新生成新的卡片数值
    return false
  }
}

fn string_to_int(input : String) -> Int {
  match input {
    "1" => 1
    "2" => 2
    "3" => 3
    "4" => 4
    "5" => 5
    "6" => 6
    "7" => 7
    "8" => 8
    "9" => 9
    "10" => 10
    _ => -1
  } // 返回 None 表示输入不是 1 到 10 范围内的字符串
}
