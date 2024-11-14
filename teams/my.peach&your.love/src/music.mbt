
let e5:UInt=660
let g4:UInt=392
let d5:UInt=588
let c5:UInt=524
let e4:UInt=330
let f4:UInt=349
let a4:UInt=440
let b4:UInt=493
let f5:UInt=698
let c4:UInt=262
let e6:UInt=1318
let c6:UInt=1046
let a5:UInt=880
let d6:UInt=1175
let b5:UInt=988
let g5:UInt=784
let d4:UInt=294

let melody : Array[UInt] = [
  0,0,0,a4,b4,c5,d5,e5,
  f5,0,0,g4,a4,b4,0,c5,d5,
  e5,0,0,f4,g4,0,a4,b4,c5,
  //d4,0,0,a5,b5,0,0,e4,
  e4,0,0,a4,b4,0,c5,e5,d5,
  f5,0,0,g4,a4,0,b4,c5,d5,
  e5,0,0,f4,g4,0,a4,b4,c5,
  //d4,0,0,a5,b5,0,0,a4,
  0,0,0,g4,a4,b4,c5,d5,
  e5,0,0,f4,g4,a4,0,b4,c5,
  d5,0,0,e4,f4,0,g4,a4,b4,
  d4,0,0,g4,a4,0,b4,c5,d5,
  e5,0,0,f4,g4,a4,0,b4,c5,
  d5,0,0,e4,f4,0,g4,a4,b4,
  g4,0,0,d5,b5,0,g5,b5,d5,
]
pub fn music(self : Game1) -> Unit {
 music_back(self.index) 
}

fn music_back(index : Int) -> Unit {
 if melody[index] != 0 {
 @wasm4.tone(
 (melody[index], 0),
 @wasm4.ADSR::new(40, release=80, decay=0, attack=0),
 @wasm4.ADSRVolume::new(30, peak=50),
 @wasm4.ToneFlag::new(channel=Triangle, mode=Duty_1_4, pan=Center),
)
 }
 game.index += 1
 if game.index >= 115 {
 game.index = 0
 }
 
}

