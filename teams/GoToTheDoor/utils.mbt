// 此文件用于存放一些公共函数

pub fn min(a : Double, b : Double) -> Double{
  if a < b {
    a
  } else {
    b
  }
}

pub fn max(a : Double, b : Double) -> Double {
  if a < b {
    b
  } else {
    a
  }
}

// 可变引用类型,由于不能创建全局的可变量（即在全局中不能用let mut创建变量,因此实现一个可变引用类型代替
struct Ref[T] {
  mut value : T
}