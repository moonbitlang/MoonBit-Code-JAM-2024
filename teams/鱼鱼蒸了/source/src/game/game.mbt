struct Game {
  mut scene : Scene
  mut lscene : Scene
  mut bscene : BounsScene
  mut g_time : Int
  mut r_time : Int
  mut p_time : Int
  mut a_time : Int
  mut konami : String
  mut flag : Bool
  mut rng : Int
}

struct Big {
  mut wld : World
}

fn Game::default() -> Game {
  {
    g_time: 0,
    r_time: 0,
    p_time: 0,
    a_time: 0,
    konami: "",
    scene: Welcome,
    lscene: Welcome,
    bscene: None,
    flag: true,
    rng: 0,
  }
}

fn Game::reset(self : Game) -> Unit {
  self.p_time = 0
  self.g_time = 0
  self.r_time = 0
  self.scene = Welcome
  self.lscene = Welcome
  self.konami = ""
  self.rng = 0
}

let game : Game = Game::default()

let world : Big = Big::{ wld: World::new() }

pub fn start() -> Unit {
  player.max_hp = 14
  @wasm.set_palette(1, @wasm.rgb(0xfbf7f3))
  @wasm.set_palette(4, @wasm.rgb(0x222034))
  game.reset()
}

pub fn update() -> Unit {
  game.g_time += 1
  control()
  checkStatus()
}

fn checkStatus() -> Unit {
  match game.scene {
    Defeat => {
      @wasm.text("Game Over", 50, 50)
      @wasm.text("Press R to restart", 10, 70)
      return
    }
    Victory => {
      two_color(2, 0)
      @wasm.text("You Win", 50, 50)
      @wasm.text("Press X to Map", 30, 80)
      if keyboard.button == X && keyboard.pressed {
        for j = 0; j < 210; j = j + 14 {
          world.wld.borderlist.push(
            Tree::{
              map_pos: Coordinate::{ x: player.map_pos.x - 15, y: j },
              draw: @lib.draw_tree,
              lvl: 1,
            },
          )
        }
        game.lscene = World
        game.scene = Bonus
        game.bscene = LevelUp
      }
      return
    }
    Fight => {
      battle(round.enemy)
      if game.g_time - game.p_time > 20 {
        game.konami = ""
      }
    }
    Welcome => {
      welcome()
      return
    }
    Bonus => check_Bouns()
    World => {
      generate()
      return
    }
    FightAnime => {
      fight_anime()
      return
    }
    Secret => {
      men()
      return
    }
    Finish => {
      two_color(2, 0)
      @wasm.rect(0, 0, 160, 160)
      two_color(1, 0)
      @wasm.text("You Beat The BOSS", 10, 50)
      @wasm.text("Thanks for playing", 10, 80)
      @wasm.text("Game made by\n FrenchPicnic", 20, 100)
      @wasm.text("Press R to restart", 10, 130)
    }
  }
}
