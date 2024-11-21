// 音效

// 跳跃音效
pub fn playJumpSound() -> Unit {
    @wasm4.tone(
      (400, 500),
      @wasm4.ADSR::new(5),
      @wasm4.ADSRVolume::new(100),
      @wasm4.ToneFlag::new(),
    )
}

// 通关音效
pub fn passSound() -> Unit {
    @wasm4.tone(
      (500, 500),
      @wasm4.ADSR::new(30),
      @wasm4.ADSRVolume::new(100),
      @wasm4.ToneFlag::new(),
    )
}

// 死亡音效
pub fn deathSound() -> Unit {
    @wasm4.tone(
      (430, 90),
      @wasm4.ADSR::new(45),
      @wasm4.ADSRVolume::new(100),
      @wasm4.ToneFlag::new(),
    )
}


