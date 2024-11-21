struct T{mut t1:Int
 t2:Int }
// struct N{i:Int}
// let n:N={i:10}
fn cure()->Unit{@wasm4.tone_note_mode((@wasm4.Note::new(100, bend=0), None), @wasm4.ADSR::new(release=6,5),@wasm4.ADSRVolume::new(100),@wasm4.ToneFlag::new(channel=Triangle))}
fn angry()->Unit{@wasm4.tone_note_mode((@wasm4.Note::new(58, bend=0), None), @wasm4.ADSR::new(release=6,7),@wasm4.ADSRVolume::new(100),@wasm4.ToneFlag::new(channel=Noise))}
fn rush_m()->Unit{@wasm4.tone_note_mode((@wasm4.Note::new(24, bend=0), None), @wasm4.ADSR::new(release=6,1),@wasm4.ADSRVolume::new(100),@wasm4.ToneFlag::new(channel=Pulse1))}

fn fight_m()->Unit{@wasm4.tone_note_mode((@wasm4.Note::new(60, bend=0), None), @wasm4.ADSR::new(release=6,7),@wasm4.ADSRVolume::new(100),@wasm4.ToneFlag::new(channel=Noise))}
fn fight_s()->Unit{@wasm4.tone_note_mode((@wasm4.Note::new(51, bend=0), None), @wasm4.ADSR::new(release=6,7),@wasm4.ADSRVolume::new(100),@wasm4.ToneFlag::new(channel=Noise))}
fn choiced()->Unit{@wasm4.tone_note_mode((@wasm4.Note::new(60, bend=0), None), @wasm4.ADSR::new(release=6,10),@wasm4.ADSRVolume::new(100),@wasm4.ToneFlag::new(channel=Triangle))}
fn choice1()->Unit{@wasm4.tone_note_mode((@wasm4.Note::new(72, bend=0), None), @wasm4.ADSR::new(release=6,5),@wasm4.ADSRVolume::new(100),@wasm4.ToneFlag::new(channel=Triangle))}
fn choice2()->Unit{@wasm4.tone_note_mode((@wasm4.Note::new(78, bend=0), None), @wasm4.ADSR::new(release=6,5),@wasm4.ADSRVolume::new(100),@wasm4.ToneFlag::new(channel=Triangle))}

fn noise(i:UInt)->Unit{if n1.t1==0{@wasm4.tone_note_mode((@wasm4.Note::new(60, bend=0), None), @wasm4.ADSR::new(release=6,4),@wasm4.ADSRVolume::new(i),@wasm4.ToneFlag::new(channel=Noise))
n1.t1+=1}
  else if n1.t1==14{@wasm4.tone_note_mode((@wasm4.Note::new(96, bend=0), None), @wasm4.ADSR::new(release=6,4),@wasm4.ADSRVolume::new(i),@wasm4.ToneFlag::new(channel=Noise))
n1.t1+=1}
  else if n1.t1==n1.t2{n1.t1=0}
  else{n1.t1+=1}}
fn pulse(j:UInt)->Unit{if p1.t1==0{@wasm4.tone_note_mode((@wasm4.Note::new(72, bend=88), None), @wasm4.ADSR::new(decay=5,7),@wasm4.ADSRVolume::new(j),@wasm4.ToneFlag::new(mode=Duty_1_4,channel=Pulse1))
p1.t1+=1}
  else if p1.t1==14{@wasm4.tone_note_mode((@wasm4.Note::new(72, bend=88), None), @wasm4.ADSR::new(decay=5,7),@wasm4.ADSRVolume::new(j),@wasm4.ToneFlag::new(mode=Duty_1_4,channel=Pulse1))
p1.t1+=1}
  else if p1.t1==27{@wasm4.tone_note_mode((@wasm4.Note::new(80, bend=88), None), @wasm4.ADSR::new(decay=5,7),@wasm4.ADSRVolume::new(j),@wasm4.ToneFlag::new(mode=Duty_1_4,channel=Pulse1))
p1.t1+=1}
  else if p1.t1==41{@wasm4.tone_note_mode((@wasm4.Note::new(79, bend=88), None), @wasm4.ADSR::new(decay=5,7),@wasm4.ADSRVolume::new(j),@wasm4.ToneFlag::new(mode=Duty_1_4,channel=Pulse1))
p1.t1+=1}
  else if p1.t1==54{@wasm4.tone_note_mode((@wasm4.Note::new(72, bend=88), None), @wasm4.ADSR::new(decay=5,7),@wasm4.ADSRVolume::new(j),@wasm4.ToneFlag::new(mode=Duty_1_4,channel=Pulse1))
p1.t1+=1}
  else if p1.t1==80{@wasm4.tone_note_mode((@wasm4.Note::new(72, bend=88), None), @wasm4.ADSR::new(decay=5,7),@wasm4.ADSRVolume::new(j),@wasm4.ToneFlag::new(mode=Duty_1_4,channel=Pulse1))
p1.t1+=1}
  else if p1.t1==75{@wasm4.tone_note_mode((@wasm4.Note::new(70, bend=88), None), @wasm4.ADSR::new(decay=5,14),@wasm4.ADSRVolume::new(j),@wasm4.ToneFlag::new(mode=Duty_1_4,channel=Pulse1))
p1.t1+=1}
  else if p1.t1==94{@wasm4.tone_note_mode((@wasm4.Note::new(79, bend=88), None), @wasm4.ADSR::new(decay=5,14),@wasm4.ADSRVolume::new(j),@wasm4.ToneFlag::new(mode=Duty_1_4,channel=Pulse1))
p1.t1+=1}
  else if p1.t1==108{@wasm4.tone_note_mode((@wasm4.Note::new(72, bend=88), None), @wasm4.ADSR::new(decay=5,14),@wasm4.ADSRVolume::new(j),@wasm4.ToneFlag::new(mode=Duty_1_4,channel=Pulse1))
p1.t1+=1}
  else if p1.t1==135{@wasm4.tone_note_mode((@wasm4.Note::new(80, bend=88), None), @wasm4.ADSR::new(decay=5,14),@wasm4.ADSRVolume::new(j),@wasm4.ToneFlag::new(mode=Duty_1_4,channel=Pulse1))
p1.t1+=1}
  else if p1.t1==149{@wasm4.tone_note_mode((@wasm4.Note::new(79, bend=88), None), @wasm4.ADSR::new(decay=5,14),@wasm4.ADSRVolume::new(j),@wasm4.ToneFlag::new(mode=Duty_1_4,channel=Pulse1))
p1.t1+=1}
  else if p1.t1==162{@wasm4.tone_note_mode((@wasm4.Note::new(72, bend=88), None), @wasm4.ADSR::new(decay=5,14),@wasm4.ADSRVolume::new(j),@wasm4.ToneFlag::new(mode=Duty_1_4,channel=Pulse1))
p1.t1+=1}
  else if p1.t1==182{@wasm4.tone_note_mode((@wasm4.Note::new(70, bend=88), None), @wasm4.ADSR::new(decay=5,20),@wasm4.ADSRVolume::new(j),@wasm4.ToneFlag::new(mode=Duty_1_4,channel=Pulse1))
p1.t1+=1}
  else if p1.t1==203{@wasm4.tone_note_mode((@wasm4.Note::new(79, bend=88), None), @wasm4.ADSR::new(decay=5,14),@wasm4.ADSRVolume::new(j),@wasm4.ToneFlag::new(mode=Duty_1_4,channel=Pulse1))
p1.t1+=1}
  else if p1.t1==216{p1.t1=0}
  else {p1.t1+=1}}
fn pulse1(j:UInt)->Unit{if p1.t1==0{@wasm4.tone_note_mode((@wasm4.Note::new(82, bend=0), None), @wasm4.ADSR::new(decay=5,41),@wasm4.ADSRVolume::new(j),@wasm4.ToneFlag::new(mode=Duty_1_4,channel=Pulse1))
p1.t1+=1}
  else if p1.t1==55{@wasm4.tone_note_mode((@wasm4.Note::new(80, bend=0), None), @wasm4.ADSR::new(decay=5,14),@wasm4.ADSRVolume::new(j),@wasm4.ToneFlag::new(mode=Duty_1_4,channel=Pulse1))
p1.t1+=1}
  else if p1.t1==82{@wasm4.tone_note_mode((@wasm4.Note::new(75, bend=0), None), @wasm4.ADSR::new(decay=5,41),@wasm4.ADSRVolume::new(j),@wasm4.ToneFlag::new(mode=Duty_1_4,channel=Pulse1))
p1.t1+=1}
  else if p1.t1==137{@wasm4.tone_note_mode((@wasm4.Note::new(73, bend=0), None), @wasm4.ADSR::new(decay=5,68),@wasm4.ADSRVolume::new(j),@wasm4.ToneFlag::new(mode=Duty_1_4,channel=Pulse1))
p1.t1+=1}
  else if p1.t1==219{@wasm4.tone_note_mode((@wasm4.Note::new(82, bend=0), None), @wasm4.ADSR::new(decay=5,41),@wasm4.ADSRVolume::new(j),@wasm4.ToneFlag::new(mode=Duty_1_4,channel=Pulse1))
p1.t1+=1}
  else if p1.t1==274{@wasm4.tone_note_mode((@wasm4.Note::new(80, bend=0), None), @wasm4.ADSR::new(decay=5,14),@wasm4.ADSRVolume::new(j),@wasm4.ToneFlag::new(mode=Duty_1_4,channel=Pulse1))
p1.t1+=1}
  else if p1.t1==301{@wasm4.tone_note_mode((@wasm4.Note::new(75, bend=0), None), @wasm4.ADSR::new(decay=5,42),@wasm4.ADSRVolume::new(j),@wasm4.ToneFlag::new(mode=Duty_1_4,channel=Pulse1))
p1.t1+=1}
  else if p1.t1==357{@wasm4.tone_note_mode((@wasm4.Note::new(78, bend=0), None), @wasm4.ADSR::new(decay=5,68),@wasm4.ADSRVolume::new(j),@wasm4.ToneFlag::new(mode=Duty_1_4,channel=Pulse1))
p1.t1+=1}
  else if p1.t1==432{p1.t1=0}
  else {p1.t1+=1}}
fn triangle(i:UInt)->Unit{
  if t1.t1==0{@wasm4.tone_note_mode((@wasm4.Note::new(36, bend=0), None),@wasm4.ADSR::new(release=1,14),@wasm4.ADSRVolume::new(50),@wasm4.ToneFlag::new(channel=Triangle))
t1.t1+=1}
  else if t1.t1==27{t1.t1=0}
  else{t1.t1+=1}}
// let a:Bytes=demo.w4on2
let t1:T={t1:0,t2:27}
let n1:T={t1:0,t2:27}
let p1:T={t1:0,t2:216}
let en:T={t1:0,t2:216}
fn bgm(i:UInt,j:UInt)->Unit{  
  triangle(i)
  noise(i)
  pulse(j)}
  
fn bgm1(i:UInt,j:UInt)->Unit{  
  pulse1(j)}
fn bgm2(i:UInt,j:UInt)->Unit{
  noise(i)
  pulse(j)}
fn end()->Unit{
en.t1=0
if p1.t1==0{@wasm4.tone_note_mode((@wasm4.Note::new(48, bend=0), None), @wasm4.ADSR::new(decay=5,41),@wasm4.ADSRVolume::new(50),@wasm4.ToneFlag::new(mode=Duty_1_4,channel=Pulse2))
en.t1+=1}
  else if p1.t1==55{@wasm4.tone_note_mode((@wasm4.Note::new(42, bend=0), None), @wasm4.ADSR::new(decay=5,41),@wasm4.ADSRVolume::new(50),@wasm4.ToneFlag::new(mode=Duty_1_4,channel=Pulse2))
en.t1+=1}
  else if p1.t1==110{@wasm4.tone_note_mode((@wasm4.Note::new(45, bend=0), None), @wasm4.ADSR::new(decay=5,41),@wasm4.ADSRVolume::new(50),@wasm4.ToneFlag::new(mode=Duty_1_4,channel=Pulse2))
en.t1+=1}
  else if p1.t1==165{@wasm4.tone_note_mode((@wasm4.Note::new(38, bend=0), None), @wasm4.ADSR::new(decay=5,41),@wasm4.ADSRVolume::new(50),@wasm4.ToneFlag::new(mode=Duty_1_4,channel=Pulse2))
en.t1+=1}}
