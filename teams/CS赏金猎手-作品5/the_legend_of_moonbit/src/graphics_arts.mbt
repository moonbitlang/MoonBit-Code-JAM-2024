fn min(arr : Array[UInt]) -> UInt {
  let mut min_value = arr[0]
  for value in arr {
    if value < min_value {
      min_value = value
    }
  }
  min_value
}

fn max(arr : Array[UInt]) -> UInt {
  let mut max_value = arr[0]
  for value in arr {
    if value > max_value {
      max_value = value
    }
  }
  max_value
}

fn x_coordinate(d : Double, lr : Double, br : Double, theta : Double) -> Double {
  (br - lr) * @math.cos(theta) + d * @math.cos((br - lr) / lr * theta)
}

fn y_coordinate(d : Double, lr : Double, br : Double, theta : Double) -> Double {
  (br - lr) * @math.sin(theta) + d * @math.sin((br - lr) / lr * theta)
}

fn linspace(start : Double, stop : Double, num : Double) -> Array[Double] {
  let step : Double = (stop - start) / (num - 1)
  let value = []
  for x = 0.0; x < num; x = x + 1 {
    value.push(start + step * x)
  } else {
    return value
  }
}

pub fn hypotrochoid_line(
  offset_x : Int,
  offset_y : Int,
  d : Double,
  lr : Double,
  br : Double,
  revs : Double,
  niter : Double,
  color : UInt
) -> Unit {
  let local_xy : Array[(UInt, UInt)] = Array::new()
  let revs = revs
  let d = d
  let lr = lr
  let br = br
  let niter = niter
  let thetas = linspace(0.0, revs * 2.0 * @math.pi, niter)
  for theta in thetas {
    let x = (@math.round(x_coordinate(d, lr, br, theta)).to_int() + offset_x).reinterpret_as_uint()
    let y = (@math.round(y_coordinate(d, lr, br, theta)).to_int() + offset_y).reinterpret_as_uint()
    @wasm4.set_frame_buffer(y * 160 + x, color)
  }
}

fn array_to_bytes(
  arr : Array[Array[UInt]],
  width : UInt,
  height : UInt
) -> Bytes {
  let result = Bytes::new(height.reinterpret_as_int())
  for i = 0; i < height.reinterpret_as_int(); i = i + 1 {
    let mut byte : UInt = 0
    for j = 0; j < width.reinterpret_as_int(); j = j + 1 {
      if arr[i][j] != 0 {
        byte = byte | (1 << j).reinterpret_as_uint()
      }
    }
    result[i] = byte.to_byte()
  }
  result
}

pub fn calulate_bounding_rect_min(local_xy : Array[(UInt, UInt)]) -> Bytes {
  let xs = local_xy.map(fn(p) { p.0 })
  let ys = local_xy.map(fn(p) { p.1 })
  let min_x = min(xs)
  let max_x = max(xs)
  let min_y = min(ys)
  let max_y = max(ys)
  let width = max_x - min_x + 1
  let height = max_y - min_y + 1
  let my_rect : Array[Array[UInt]] = Array::new()
  let row : Array[UInt] = Array::new()
  for x = width; x > 0; x = x - 1 {
    row.push(0)
  }
  for y = height; y > 0; y = y - 1 {
    my_rect.push(row)
  }
  for intr in local_xy {
    let yy = (intr.1 - min_y).reinterpret_as_int()
    let xx = (intr.0 - min_x).reinterpret_as_int()
    my_rect[yy][xx] = 1
  }
  array_to_bytes(my_rect, width, height)
}
