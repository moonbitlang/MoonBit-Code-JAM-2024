pub struct Player {
  mut ai:Ai
  mut if_defend:Bool
  p:Bool
  key:UInt
  mut state:Int//0:无状态，1：冲击状态，2：治疗状态，3：中毒状态，4待定
  mut pos : Point
  mut hp:Int
  mut f_state:Point
  mut f_live:Bool
  mut demage:Demage
  mut cd:Character_cd
  // mut mp :Int
  mut direction : Bool
  // mut fight_cd :Int
  // mut skill_cd :Int
  mut playermodel:PlayerModel
}
struct Demage {
  mut fight:Int
  skill:Int
}
pub struct PlayerModel{
  mut sprite:Sprite
  hp:Int
  speed:Int
  skill:Skills
  fight:Fights
  cd:Character_cd
  demage:Demage
  jump:Double
}
 
let tanker_model:PlayerModel={sprite:tanker_sprite,hp:48,speed:2,skill:Dash,fight:Bullet,cd:tanker_cd,demage:{fight:10,skill:20},jump:10}
let stive_model:PlayerModel={sprite:stive_sprite,hp:30,speed:1,skill:Fly,fight:Fist,cd:stive_cd,demage:{fight:5,skill:1},jump:41}
let scientist_model:PlayerModel={sprite:scientist_sprite,hp:25,speed:1,skill:Cure,fight:Bottle,cd:scentist_cd,demage:{fight:5,skill:3},jump:40}
let knight_model:PlayerModel={sprite:knight_sprite,hp:40,speed:1,skill:Angry,fight:Poke,cd:knight_cd,demage:{fight:8,skill:10},jump:30}
let tree_model:PlayerModel={sprite:tree_sprite,hp:40,speed:1,skill:Angry,fight:Fist,cd:ai_cd,demage:{fight:8,skill:10},jump:30}
let pig_model:PlayerModel={sprite:pig_sprite,hp:20,speed:1,skill:Angry,fight:Fist,cd:ai_cd,demage:{fight:1,skill:10},jump:10}
let mo_model:PlayerModel={sprite:mo_sprite,hp:40,speed:1,skill:Cure,fight:Poke,cd:ai_cd,demage:{fight:10,skill:10},jump:20}
let dra_model:PlayerModel={sprite:dragon_sprite,hp:100,speed:1,skill:Angry,fight:Poke,cd:ai_cd,demage:{fight:8,skill:10},jump:30}

enum Fights {
  Bullet
  Fist
  Poke
  Bottle
}