let commonEventChance : UInt = 30

let rareEventChance : UInt = 10

let superRareEventChance : UInt = 1

pub let commonEvent = ["Sun", "Moon"]

pub let rareEvent = ["Hurricane"]

pub let superRareEvent = ["Win"]

let commonEventAmount : UInt = commonEvent.length().reinterpret_as_uint()

let rareEventAmount : UInt = rareEvent.length().reinterpret_as_uint()

let superRareEventAmount : UInt = superRareEvent.length().reinterpret_as_uint()

pub struct Event {
  mut sunAmount : UInt
  mut moonAmount : UInt
}

let event : Event = { sunAmount: 0, moonAmount: 0 }

pub fn runEvents() -> Unit {
  
  if game.time % 300 == 0 {
    game.coin += event.sunAmount.reinterpret_as_int()
    game.coin -= event.moonAmount.reinterpret_as_int()
  }
}
fn getEvent() -> String {
  let rand = (game.time + randomer.uint()) % 100
  if rand < commonEventChance {
    getCommonEvent()
  } else if rand < commonEventChance + rareEventChance {
    getRareEvent()
  } else if rand < commonEventChance + rareEventChance + superRareEventChance {
    getSuperRareEvent()
  } else {
    "None"
  }
}
fn getCommonEvent() -> String {
  let rand = ((game.time + randomer.uint()) % commonEventAmount).reinterpret_as_int()
  commonEvent[rand]
}

fn getRareEvent() -> String {
  let rand = ((game.time + randomer.uint()) % rareEventAmount).reinterpret_as_int()
  rareEvent[rand]
}

fn getSuperRareEvent() -> String {
  let rand = ((game.time + randomer.uint()) % superRareEventAmount).reinterpret_as_int()
  superRareEvent[rand]
}

pub fn identifyEvent(eventName : String) -> String {
  match eventName {
    "None" => @wasm4.trace("None")
    "Sun" => runSunEvent()
    "Moon" => runMoonEvent()
    _ => @wasm4.trace("Unknown event")
  }
  eventName
}


fn runSunEvent() -> Unit {
  event.sunAmount += 1
  @wasm4.trace("Sun")
}

fn runMoonEvent() -> Unit {
  event.moonAmount += 1
  @wasm4.trace("Moon")
}
