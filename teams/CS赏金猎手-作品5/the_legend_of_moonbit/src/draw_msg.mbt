pub fn draw_msg(self : GameStat) -> Unit {
  if self.lv == 3 {
    if self.player_x == 90 && self.bn < 20 {
      self.show_args_bar = false
      @wasm4.text("What's that!?", 10, 5)
      self.lock_player = true
      if not(self.lock_player) {
        self.lock_player = true
      }
    }
    if self.player_x == 91 && self.bn < 20 {
      self.show_args_bar = false
      @wasm4.text("Star is coming!", 10, 5)
      if not(self.lock_player) {
        self.lock_player = true
      }
      self.lock_player = true
    } else if self.player_x == 92 && self.bn < 20 {
      self.show_args_bar = false
      if not(self.lock_player) {
        self.lock_player = true
      }
      let mut px = 10
      let mut py = 10
      for n = 0; n < 140; n = n + 1 {
        px += 1
        py += 1
        @wasm4.oval(px, py, 20, 20)
      }
      @wasm4.text("Run!", 10, 5)
      self.memory = 1
      self.hp = 50

      // self.game_state = GS2 
    } else if self.player_x == 93 && self.bn < 20 {
      self.show_args_bar = false
      self.lock_player = true
      @wasm4.rect(0, 0, 160, 160)
    } else if self.player_x == 94 && self.bn < 2 {
      self.player_rotate = true
      self.lv = self.lv + 1
      self.game_state = GS2
    }
  } else if self.lv == 4 {
    self.show_args_bar = false
    if self.player_x == 94 && self.bn < 20 {
      @wasm4.text("Ahh, It hurts! Who?", 10, 5)
      @wasm4.text("Who am I?", 10, 15)
      self.player_rotate = false
      self.lock_player = true
      if not(self.lock_player) {
        self.lock_player = true
      }
    } else if self.player_x == 95 && self.bn < 20 {
      @wasm4.text("Where am I?", 10, 5)
      self.lock_player = true
      if not(self.lock_player) {
        self.lock_player = true
      }
    } else if self.player_x == 96 && self.bn < 20 {

    }
  }
}
