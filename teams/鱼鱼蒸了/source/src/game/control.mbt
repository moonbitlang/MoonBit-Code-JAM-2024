enum Button {
  Left
  Right
  Up
  Down
  X
  Z
  None
} derive(Eq)

struct Control {
  mut button : Button
  mut pressed : Bool
  mut la_button : Button
}

type LevelControl () -> Unit

let keyboard : Control = Control::{
  button: None,
  pressed: false,
  la_button: None,
}

fn Control::button() -> Unit {
  let pad = @wasm.get_gamepad()
  keyboard.button = if pad.button_right {
    Right
  } else if pad.button_left {
    Left
  } else if pad.button_up {
    Up
  } else if pad.button_down {
    Down
  } else if pad.button_1 {
    X
  } else if pad.button_2 {
    Z
  } else {
    None
  }
  keyboard.pressed = keyboard.button != keyboard.la_button
  keyboard.la_button = keyboard.button
}

fn control() -> Unit {
  button()
  if game.scene == Fight {
    if not(player.selfround) && keyboard.pressed {
      game.p_time = game.g_time
      fight_control()
    }
    if round.enemy.battle == Special {
      (bonus_levels[round.rng].control._)()
    }
  } else if game.scene == World {
    world_control()
  }
}

fn fight_control() -> Unit {
  match keyboard.button {
    Left => {
      game.konami += "l"
      if round.status == "player" {
        choice.option = @math.maximum(1, choice.option - 1)
      }
    }
    Right => {
      if round.status == "player" {
        choice.option = @math.minimum(3, choice.option + 1)
      }
      game.konami += "r"
    }
    Up => game.konami += "u"
    Down => game.konami += "d"
    X => {
      game.konami += "x"
      if game.konami == "uuddlrlrzx" {
        game.lscene = game.scene
        game.scene = Secret
        return
      }
      if choice.option > 0 {
        if round.status == "player" {
          player.selfround = true
        }
      }
    }
    Z => game.konami += "z"
    _ => ()
  }
}

fn world_control() -> Unit {
  match keyboard.button {
    Left =>
      if check_border_collision(player.map_pos.x - 1, player.map_pos.y) {
        player.map_pos.x = @math.maximum(0, player.map_pos.x - 1)
        world.wld.absolute.x -= 1
      }
    Right =>
      if check_border_collision(player.map_pos.x + 1, player.map_pos.y) {
        player.map_pos.x = @math.minimum(1090, player.map_pos.x + 1)
        world.wld.absolute.x += 1
      }
    Up =>
      if check_border_collision(player.map_pos.x, player.map_pos.y - 1) {
        player.map_pos.y = @math.maximum(0, player.map_pos.y - 1)
        world.wld.absolute.y -= 1
      }
    Down =>
      if check_border_collision(player.map_pos.x, player.map_pos.y + 1) {
        player.map_pos.y = @math.minimum(190, player.map_pos.y + 1)
        world.wld.absolute.y += 1
      }
    _ => ()
  }
  if game.scene == World {
    if world.wld.absolute.x < 0 || player.map_pos.x < 80 {
      world.wld.absolute.x = 0
    } else if world.wld.absolute.x > 940 || player.map_pos.x > 1020 {
      world.wld.absolute.x = 940
    }
    if world.wld.absolute.y < 0 || player.map_pos.y < 80 {
      world.wld.absolute.y = 0
    } else if world.wld.absolute.y > 40 || player.map_pos.y > 120 {
      world.wld.absolute.y = 40
    }
  }
}

let b0_control : LevelControl = fn() -> Unit {
  match keyboard.button {
    Left => player.bonus_pos.x = @math.maximum(0, player.bonus_pos.x - 1)
    Right => player.bonus_pos.x = @math.minimum(150, player.bonus_pos.x + 1)
    Up => player.bonus_pos.y = @math.maximum(80, player.bonus_pos.y - 1)
    Down => player.bonus_pos.y = @math.minimum(150, player.bonus_pos.y + 1)
    _ => ()
  }
}

let b1_control : LevelControl = fn() -> Unit {
  if keyboard.pressed {
    match keyboard.button {
      Left => {
        b1_shield.pos.x = 70
        b1_shield.pos.y = 117
        b1_shield.hitbox.x = 3
        b1_shield.hitbox.y = 13
      }
      Right => {
        b1_shield.pos.x = 87
        b1_shield.pos.y = 117
        b1_shield.hitbox.x = 3
        b1_shield.hitbox.y = 13
      }
      Up => {
        b1_shield.pos.x = 72
        b1_shield.pos.y = 115
        b1_shield.hitbox.x = 13
        b1_shield.hitbox.y = 3
      }
      Down => {
        b1_shield.pos.x = 72
        b1_shield.pos.y = 130
        b1_shield.hitbox.x = 13
        b1_shield.hitbox.y = 3
      }
      _ => ()
    }
  }
}
