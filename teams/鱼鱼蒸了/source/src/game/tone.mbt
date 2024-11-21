fn sound() -> Unit {
  @wasm.tone(
    (500, 30),
    @wasm.ADSR::new(25, release=0, decay=0, attack=0),
    @wasm.ADSRVolume::new(24, peak=62),
    @wasm.ToneFlag::new(
      channel=@wasm.ToneChannel::Pulse1,
      mode=@wasm.ToneMode::Duty_1_8,
    ),
  )
}
