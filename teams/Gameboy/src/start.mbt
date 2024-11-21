struct Point {
  mut x : Int
  mut y : Int
}
// let none:Point={x:0,y:0}
let p_pos : Point = { x: 16, y: 0}
let e_pos : Point = { x: 106, y: 0}
let player1 : Player = {ai:player_a,if_defend:false,p:true,key:1,state:0,pos:{ x:0,y:125 },hp:50,f_state:{x:0,y:0},f_live:false,demage:{fight:10,skill:20},cd:scentist_cd,direction:false,playermodel:stive_model}
let player2 : Player = {ai:player_a,if_defend:false,p:false,key:2,state:0,pos:{ x:140,y:125},hp:50,f_state:{x:0,y:0},f_live:false,demage:{fight:10,skill:20},cd:scentist_cd,direction:true,playermodel:tanker_model}
let aiplayer : Player = {ai:player_a2,if_defend:false,p:false,key:2,state:0,pos:{ x:140,y:125},hp:50,f_state:{x:0,y:0},f_live:false,demage:{fight:10,skill:20},cd:scentist_cd,direction:true,playermodel:tanker_model}
let ent:Entities={scene:Menus}

pub fn update() -> Unit {
  ai_think()
  // strength(player.prob)
  match ent.scene{
    // Welcome => render_system(ent)
    Menus => render_system(ent) 
    Game1 => render_system(ent) 
    Game2 => render_system(ent)
    Choice => render_system(ent)
    Victory1 => render_system(ent)
    Victory2 => render_system(ent)
  }
  
}




