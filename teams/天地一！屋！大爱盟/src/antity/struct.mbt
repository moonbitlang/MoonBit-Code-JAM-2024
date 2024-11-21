pub struct Location{
  mut x:Double
  mut y:Double
  // mut newx:Double
  // mut newy:Double
  type_:UInt
//用于记录实体的位置
}

// struct Sprite_parameter{
// 	 x:UInt
// 	 y:UInt
// 	//相对于基准像素的偏移量
// 	color:UInt
// }

// pub struct Frame{
// 	mut x:Int
// 	mut y:Int
// 	//代表左上角的基准像素
// 	sprite:Array[Sprite_parameter]
// 	//这个代表一帧！！
// }

pub struct Frame_time_config{
	mut begin:Int
	mut end:Int
}

pub struct Frame_effects{
	xlen:UInt
	ylen:UInt
	sprite:@bitset.Bitset
	back_ground:@bitset.Bitset
}

pub struct Frame_effects_{
	mut begin:UInt
	xlen:UInt
	ylen:UInt
	sprite:Array[@bitset.Bitset]
	back_ground:Array[@bitset.Bitset]
}

// pub struct Frame_effects_{
// 	mut begin_time:UInt64
// 	mut end_time:UInt64
// 	mut x:UInt
// 	mut y:UInt
// 	sprite:Array[Frame]
// 	time_management:Array[Frame_time_config]
// 	//time_management与sprite的长度一致，time_management用于控制sprite的每一帧显示时间
// }

pub struct ToneParams {
    frequency: (UInt, UInt)
    adsr: @wasm4.ADSR
    volume: @wasm4.ADSRVolume
    channel: @wasm4.ToneFlag
}

pub struct Sound_effects{
	//具体实现待研究QWQ
	effects:Array[ToneParams]
}
pub struct ToneForPub {
	tone:ToneParams
	startfps:UInt
}
// pub struct Effects{
// 	frame:Frame_effects_
// 	sound:Array[ToneParams]
// }

pub struct Bullet{
	type_:Int
	harm:Double
	pos:Location
	dir:Double
	speed:Double
	// frame:Frame_effects
}

// pub struct Laser{
// 	type_:UInt
// 	pos:Location
// 	//表示激光最顶点的位置
// 	dir:UInt
// 	//激光方向
// 	harm:UInt
// 	// warming:Frame_effects
	
// }
//激光应当还有一个方向改变函数！！！

pub struct Bullet_exit_point{
	x:Int
	y:Int
	type_:Int
	mut last_shoot:Int
	shoot_speed:Int
	mut limit:Int
}

pub struct Aircraft{
  type_:Int
  pos:Location
  mut speed:Double
  mut dir:Double
  // frame:Frame_effects
  mut hp:Double
  bullet_exit_point:Array[Bullet_exit_point]
}
//方向先不管，是个角度，0度方向与x轴正方向平行，顺时针转
//weapon 1是单发 2是双发
//speed 是每帧速度
pub struct Cartridge{
  type_:Int
  pos:Location
  mut speed:Double
  dir:Double
	effect:Double
  // frame:Frame_effects
}

// type_ 分配规则
// 普通子弹_敌人 1
// 普通子弹_自己 9
// 高爆子弹_自己 2
// 高爆子弹_敌人 11
// 自机 3
// 敌机小型机 4
// 敌机中型机_普通子弹版 5
// 敌机中型机_高爆子弹版 12
// 高爆子弹包 6
// 双倍子弹包 7
// 血量恢复包 8
// 激光子弹包 10