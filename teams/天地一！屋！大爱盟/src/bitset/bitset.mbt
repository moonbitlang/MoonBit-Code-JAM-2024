let up_bit:Int=32;
pub struct Bitset{
  priv mut bits:FixedArray[UInt]
  priv mut top:Int//表示存了多少个pre_size
  per_size:Int
}

pub fn Bitset::length(self:Bitset)->Int{
  self.top
}

pub fn Bitset::new(per_size:Int,string:String)->Bitset{
  let ans:Bitset={bits:[],top:0,per_size}
  let mut block=-1
  let mut move=up_bit
  ans.top=string.length()/per_size
  ans.bits=FixedArray::make(ans.top,0)
  for i in string{
    if(move>=up_bit){
      block=block+1;
      move=0;
    }
    ans.bits[block]=ans.bits[block]|((i.to_int()-'0'.to_int()).reinterpret_as_uint()<<move)
    move=move+1
  }
  ans
}

pub fn op_get(self:Bitset,index:Int)->UInt{
  let indexx=index*self.per_size
  let mut block=indexx/up_bit
  let mut move=indexx-block*up_bit
  let mut ans:UInt=0;
  for i=0;i<self.per_size;i=i+1{
    if(move>=up_bit){
      block=block+1;
      move=0;
    }
    ans=ans|(((self.bits[block]>>move)&1)<<i)
    move=move+1;
  }
  ans
}

// pub fn push(self:Bitset,input:UInt)->Unit{
//   // println("Push \{input}")
//   let indexx=self.top*self.per_size
//   let mut block=indexx/up_bit
//   let mut move=indexx-block*up_bit
//   // println("\{indexx} \{block} \{move}")
//   if(move==0) {self.bits.push(0)}
//   for i=0;i<self.per_size;i=i+1{
//     if(move>=up_bit){
//       block=block+1;
//       self.bits.push(0)
//       move=0;
//     }
//     self.bits[block]=(self.bits[block]|(((input>>i)&1)<<move))
//     // println(self.bits[block]|(((input>>i)&1)<<move))
//     move=move+1
//   }
//   self.top=self.top+1;
// }

// pub fn op_set(self:Bitset,index:Int,input:UInt)->Unit{
//   let indexx=index*self.per_size
//   let mut block=indexx/up_bit
//   let mut move=indexx-block*up_bit
//   for i=0;i<self.per_size;i=i+1{
//     if(move>=up_bit){
//       block=block+1;
//       move=0;
//     }
//     if ((self.bits[block]>>move)&1)==1 {self.bits[block]=self.bits[block]&(-1).reinterpret_as_uint()^(1U<<move)}
//     self.bits[block]=self.bits[block]|(((input>>i)&1)<<move)
//     move=move+1
//   }
// }
