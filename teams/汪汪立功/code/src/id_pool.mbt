struct ID_Pool {
  mut count : UInt
}

fn ID_Pool::new() -> ID_Pool {
  { count: 0 }
}

fn get_id(self : ID_Pool) -> UInt {
  self.count += 1
  self.count
}

let id_pool : ID_Pool = ID_Pool::new()
