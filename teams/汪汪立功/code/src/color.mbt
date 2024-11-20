enum Color {
  Black
  Brown
  LightBrown
  Grey
}

fn to_int(self : Color) -> UInt {
  match self {
    Black => 1
    Brown => 2
    LightBrown => 3
    Grey => 4
  }
}

fn set_draw_color(index : UInt, color_type : Color) -> Unit {
  @wasm4.set_draw_colors(index~, color_type.to_int())
}

fn set_main_color_with_transparent(color_type : Color) -> Unit {
  @wasm4.set_draw_colors(index=1, color_type.to_int())
  @wasm4.set_draw_colors(index=2, 0)
}

fn init_color() -> Unit {
  @wasm4.set_palette(1, @wasm4.rgb(0x040404)) // Black
  @wasm4.set_palette(2, @wasm4.rgb(0x7c7464)) // Brown
  @wasm4.set_palette(3, @wasm4.rgb(0xf4e4bc)) // LightBrown
  @wasm4.set_palette(4, @wasm4.rgb(0x34342c)) // Grey 
}
