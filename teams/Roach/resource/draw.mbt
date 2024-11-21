struct Color {
  mut palette : UInt
}

pub fn Color::new() -> Color {
  { palette: 2 }
}

let randomer : @random.Rand = @random.Rand::new()

fn draw(self : Game) -> Unit {
  //drawBkg(self)
  drawBlock(self)
  drawBall(self)
  drawCoin(self)
  drawUI()
  drawProgressBar(self)
}

//fn drawBkg(self : Game) -> Unit {
//  @wasm4.set_draw_colors(index=1, 2)
//  @wasm4.set_draw_colors(index=2, 1)
//  @wasm4.set_draw_colors(index=3, 4)
//  @wasm4.set_draw_colors(index=4, 3)
//  @wasm4.blit(
//    hex,
//    0,
//    0,
//    160,
//    160,
//    { one_bit_per_pixel: true, flip_x: false, flip_y: false, rotate: false },
//  )
//}

fn drawBlock(self : Game) -> Unit {
  for i in [0, 1, 2] {
    self.block[i].x = 20 + 45 * i
  }
  for i in [0, 1, 2] {
    @wasm4.set_draw_colors(self.block[i].color.palette)
    @wasm4.rect(
      self.block[i].x,
      self.block[i].y,
      self.block[i].width,
      self.block[i].height,
    )
    if game.counterFlag == false {
      drawSprite(self, i)
    }
  }
}

fn drawSprite(self : Game, blockindex : Int) -> Unit {
  @wasm4.set_draw_colors(1)
  match self.block[blockindex].event_block {
    "None" => return
    "Sun" => {
      self.block[blockindex].sprite_block = {
        x: self.block[blockindex].x + 3,
        y: 43,
        sprite: sun_sprite,
      }
      @wasm4.blit(
        self.block[blockindex].sprite_block.sprite,
        self.block[blockindex].sprite_block.x,
        self.block[blockindex].sprite_block.y,
        SunWidth,
        SunHeight,
        { one_bit_per_pixel: true, flip_x: false, flip_y: false, rotate: false },
      )
    }
    "Moon" => {
      self.block[blockindex].sprite_block = {
        x: self.block[blockindex].x + 3,
        y: 43,
        sprite: moon_sprite,
      }
      @wasm4.blit(
        self.block[blockindex].sprite_block.sprite,
        self.block[blockindex].sprite_block.x,
        self.block[blockindex].sprite_block.y,
        MoonWidth,
        MoonHeight,
        { one_bit_per_pixel: true, flip_x: false, flip_y: false, rotate: false },
      )
    }
    _ => return
  }
}

fn drawBall(self : Game) -> Unit {
  if game.gameOverFlag == false {
    @wasm4.set_draw_colors(3)
    @wasm4.rect(31, 108, 100, 5)
    @wasm4.set_draw_colors(2)
    @wasm4.oval(self.ball.x, self.ball.y, self.ball.width, self.ball.height)
  }
}

fn drawProgressBar(self : Game) -> Unit {
  @wasm4.set_draw_colors(2)
  @wasm4.rect(self.pbar.x, self.pbar.y, self.pbar.width, self.pbar.height)
}

fn drawCoin(self : Game) -> Unit {
  @wasm4.set_draw_colors(2)
  @wasm4.text(":\{self.coin}", 74, 150)
  coin_sprite.blit(
    64,
    150,
    8,
    8,
    { one_bit_per_pixel: false, flip_x: false, flip_y: false, rotate: false },
  )
}

fn drawUI() -> Unit {
  @wasm4.text("G a c h a", 44, 6)
  @wasm4.text(
    "Generator:\{(event.sunAmount-event.moonAmount).reinterpret_as_int()}",
    32,
    127,
  )
}

pub fn changeColor(self : Block) -> Unit {
  if self.color.palette < 4 {
    self.color.palette += 1
  } else {
    self.color.palette = 1
  }
}

pub fn changeColor_random(self : Block) -> Unit {
  self.color.palette = randomer.uint(limit=3) + 2
}
