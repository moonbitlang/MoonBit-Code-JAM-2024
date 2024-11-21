// let c4:UInt=262
// let c_4:UInt=277
// let d4:UInt=294
// let d_4:UInt=311
// let e4:UInt=330
// let f4:UInt=349
// let f_4:UInt=370
// let g4:UInt=392
// let g_4:UInt=415
// let a4:UInt=440
// let a_4:UInt=466
// let b4:UInt=493

let music1 : Array[UInt] = [293U, 329U,0, 349U, 392U,0, 440U, 587U, 523U,0, 440U, 392U, 523U, 523U,0, 493U, 293U,0, 329U, 349U, 392U, 440U,0, 587U, 659U, 587U, 440U,0,0, 392U, 369U, 587U,0,]
let music2 : Array[UInt] = [554U, 0,622U, 0,932U, 698U, 830U, 698U,0, 554U, 622U, 554U,0, 415U, 466U, 415U, 349U, 415U, 466U, 415U, 466U, 622U, 466U, 0,554U, 622U, 698U, 830U,0,698U,0, 830U]
//let music3 : Array[UInt] = [392U, 415U, 466U, 622U, 830U, 698U, 554U, 622U, 554U, 698U, 783U, 698U, 622U, 554U, 466U, 0U,523U,0U, 466U,0U, 415U,0U, 311U, 349U,0U]
// let music4 : Array[UInt] = [174U, 174U, 196U, 233U, 233U, 233U, 196U, 164U, 196U, 174U, 174U, 98U, 110U, 0U, 110U, 110U, 174U, 185U, 110U, 174U, 196U, 233U, 246U, 233U, 196U, 164U, 196U, 174U, 174U, 98U, 110U, 0]
fn music_use1(list : Int) -> Unit {
music_0.stop=music_0.stop
    if music1[list] != 0 {
      @wasm4.tone((music1[list], 0),@wasm4.ADSR::new(10, release=0, decay=0, attack=0),@wasm4.ADSRVolume::new(100, peak=100),@wasm4.ToneFlag::new(channel=Pulse1, mode=Duty_1_4, pan=Center),
      )
    }
     music_0.music_list1 += 1
    if  music_0.music_list1 >= 31 {
       music_0.music_list1 = 0
    }
  }
fn music_use2(list : Int) -> Unit {
    if music2[list] != 0 {
      @wasm4.tone((music2[list], 0),@wasm4.ADSR::new(0, release=20, decay=0, attack=0),@wasm4.ADSRVolume::new(100, peak=100),@wasm4.ToneFlag::new(channel=Pulse2, mode=Duty_1_8, pan=Center),)
      }
       music_0.music_list1 += 1
    if  music_0.music_list1 >= 31 {
       music_0.music_list1 = 0
    }
  }
// fn music_use3(list : Int) -> Unit {
//     if music3[list] != 0 {
//       @wasm4.tone((music3[list], 0),@wasm4.ADSR::new(0, release=20, decay=0, attack=0),@wasm4.ADSRVolume::new(100, peak=100),@wasm4.ToneFlag::new(channel=Pulse2, mode=Duty_1_8, pan=Center),)
//       }
//        music_0.music_list3 += 1
//     if  music_0.music_list3 >= 25 {
//        music_0.music_list3 = 0
//     }
//   }
// fn music_use4(list : Int) -> Unit {
//     if music4[list] != 0 {
//       @wasm4.tone((music4[list], 0),@wasm4.ADSR::new(0, release=20, decay=0, attack=0),@wasm4.ADSRVolume::new(100, peak=100),@wasm4.ToneFlag::new(channel=Pulse2, mode=Duty_1_8, pan=Center),)
//       }
//        music_0.music_list4 += 1
//     if  music_0.music_list4 >= 31 {
//        music_0.music_list4 = 0
//     }
//   }



