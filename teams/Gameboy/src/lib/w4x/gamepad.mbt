pub struct GamePad {
  button_1 : Bool
  button_2 : Bool
  button_left : Bool
  button_right : Bool
  button_up : Bool
  button_down : Bool
}

pub fn get_gamepad(~index : UInt = 1) -> GamePad {
  @wasm4.get_gamepad(~index) |> from
}

pub fn GamePad::from(pad : @wasm4.GamePad) -> GamePad {
  {
    button_1: pad.button_1,
    button_2: pad.button_2,
    button_left: pad.button_left,
    button_right: pad.button_right,
    button_up: pad.button_up,
    button_down: pad.button_down,
  }
}

pub struct PressedPad {
  index : UInt
  mut previous : GamePad
}

pub fn PressedPad::new(~index : UInt = 1) -> PressedPad {
  {
    index,
    previous: get_gamepad(~index),
  }
}

pub fn PressedPad::get_pressed_buttons(self : PressedPad) -> GamePad {
  let pad = get_gamepad(index=self.index)
  let pressed = {
    button_1: pad.button_1 && not(self.previous.button_1),
    button_2: pad.button_2 && not(self.previous.button_2),
    button_left: pad.button_left && not(self.previous.button_left),
    button_right: pad.button_right && not(self.previous.button_right),
    button_up: pad.button_up && not(self.previous.button_up),
    button_down: pad.button_down && not(self.previous.button_down),
  }
  self.previous = pad
  pressed
}
