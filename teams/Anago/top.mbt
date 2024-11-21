pub struct Game {
  mut score : Int
  mut timeLeft : Int
  mut requiredButton : Int
  mut buttonMatched : Bool
  mut preGamePad : @wasm4.GamePad
}

let g : Game = Game::{
  score: 0,
  timeLeft: 600, // 每局10秒钟
  requiredButton: random_button(),
  buttonMatched: false,
  preGamePad: @wasm4.GamePad::default(),
}

let random : @random.Rand = @random.new()

// 生成随机按键组合（1-4代表不同按键）
fn random_button() -> Int {
  return 1 + random.int(limit=4) // 1代表上，2代表下，3代表左，4代表右
}

pub fn start() -> Unit {
  @wasm4.set_palette(1, @wasm4.rgb(0xfbf7f3))
  @wasm4.set_palette(2, @wasm4.rgb(0xe5b083))
  @wasm4.set_palette(3, @wasm4.rgb(0x426e5d))
  @wasm4.set_palette(4, @wasm4.rgb(0x20283d))
}

pub fn update() -> Unit {
  if g.timeLeft > 0 {
    let gamePad = @wasm4.get_gamepad()

    // 检测按键匹配
    if (g.requiredButton == 1 && gamePad.button_up) ||
      (g.requiredButton == 2 && gamePad.button_down) ||
      (g.requiredButton == 3 && gamePad.button_left) ||
      (g.requiredButton == 4 && gamePad.button_right) {
      if not(g.buttonMatched) {
        g.buttonMatched = true
        g.score += 1
        g.requiredButton = random_button() // 新的按键要求
        g.timeLeft += 60 // 增加1秒时间

        // 正确按下音效
        @wasm4.tone(
          (800, 1000),
          @wasm4.ADSR::new(15, release=5, attack=5),
          @wasm4.ADSRVolume::new(30, peak=60),
          @wasm4.ToneFlag::new(),
        )
      }
    } else {
      g.buttonMatched = false
    }

    // 动画和显示分数
    @wasm4.text("Quick Reaction Game", 10, 10)
    @wasm4.text("Score: " + g.score.to_string(), 10, 30)
    @wasm4.text("Time Left: " + (g.timeLeft / 60).to_string(), 10, 50)
    display_button_hint(g.requiredButton)

    // 倒计时
    g.timeLeft -= 1
  } else {
    // 游戏结束
    @wasm4.text("Game Over! Score: " + g.score.to_string(), 0, 60)
    @wasm4.text("Press X to Restart", 0, 80)
    let gamePad = @wasm4.get_gamepad()
    if gamePad.button_1 && not(g.preGamePad.button_1) {
      g.timeLeft = 600
      g.score = 0
      g.requiredButton = random_button()
    }
  }
  g.preGamePad = @wasm4.get_gamepad()
}

// 显示当前要求的按键提示
fn display_button_hint(button : Int) -> Unit {
  let hintText = match button {
    1 => "Press Up"
    2 => "Press Down"
    3 => "Press Left"
    4 => "Press Right"
    _ => ""
  }
  @wasm4.text(hintText, 10, 70)
}
