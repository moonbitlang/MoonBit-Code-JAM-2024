pub fn music_damage() -> Unit {
  @wasm4.tone_note_mode(
    (@wasm4.Note::new(55, bend=10), None),
    @wasm4.ADSR::new(15),
    @wasm4.ADSRVolume::new(50),
    @wasm4.ToneFlag::new(),
  )
}

pub fn music_attack() -> Unit {
  @wasm4.tone_note_mode(
    (@wasm4.Note::new(40, bend=5), None),
    @wasm4.ADSR::new(15),
    @wasm4.ADSRVolume::new(50),
    @wasm4.ToneFlag::new(),
  )
}
