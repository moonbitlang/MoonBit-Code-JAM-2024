// pub trait Strike{
// 	is_strike(Self,Self)->Bool
// }

// pub trait Updata_pos{
// 	updata_pos(Self)->Unit
// }

// pub trait Get_new_pos{
// 	get_new_pos(Self)->Unit
// }
// pub trait Setmusic{
// 		setup_tone_params() -> Array[ToneParams]
// }

pub let scores:Ref[Int]=Ref::new(0);

pub fn get_index(x:UInt,y:UInt)->UInt{
	y*160+x
}

//造成伤害#######################################################################################################################################

//造成伤害#######################################################################################################################################

//展示函数#############################################

pub fn show(self:Frame_effects,x:Int,y:Int)->Unit{
    let mut index=0
    let mut posx=x
    let mut posy=y
    for i=0U;i<self.ylen;i=i+1{
        for e=0U;e<self.xlen;e=e+1{
            if((self.back_ground[index]==1||posx>=160||posx<0||posy<0||posy>low_y).not()){
                @wasm4.set_frame_buffer(get_index(posx.reinterpret_as_uint(),posy.reinterpret_as_uint()),self.sprite[index]+1)
            }
            index=index+1
            posx=posx+1
        }
        posx=x
        posy=posy+1
    }
}

pub fn showp(self:Frame_effects_,x:Int,y:Int,t:Int)->Unit{
    let mut index=0
    let mut posx=x
    let mut posy=y
    for i=0U;i<self.ylen;i=i+1{
        for e=0U;e<self.xlen;e=e+1{
            if((self.back_ground[t][index]==1||posx>=160||posx<0||posy<0||posy>low_y).not()){
                @wasm4.set_frame_buffer(get_index(posx.reinterpret_as_uint(),posy.reinterpret_as_uint()),self.sprite[t][index]+1)
            }
            index=index+1
            posx=posx+1
        }
        posx=x
        posy=posy+1
    }
}


pub fn print(self:Aircraft)->Unit{
    get_fram_entity(self.type_).show(self.pos.x.to_int(),self.pos.y.to_int())
}

pub fn print(self:Bullet)->Unit{
    get_fram_entity(self.type_).show(self.pos.x.to_int(),self.pos.y.to_int())
}

// pub fn print(self:Laser)->Unit{
//     // get_fram_entity(self.type_).show(self.pos.x.to_int(),self.pos.y.to_int())
// }

pub fn print(self:Cartridge)->Unit{
    get_fram_entity(self.type_).show(self.pos.x.to_int(),self.pos.y.to_int())
}

//展示函数#############################################

//构造函数#############################################
pub fn Location::new(~x:Double=0,~y:Double=0,type_:UInt)->Location{
    {x,y,type_}
}

pub fn Bullet_exit_point::new(x:Int,y:Int,type_:Int,last_shoot:Int,shoot_speed:Int,~limit:Int=-1)->Bullet_exit_point{
    {x,y,type_,last_shoot,shoot_speed,limit}
}
//构造函数#############################################

//更新位置#############################################
// let eps:Double=0.000000001
pub fn Aircraft::update_pos(self:Aircraft)->Unit{
    let x=self.pos.x
    let y=self.pos.y
    self.pos.x=self.pos.x+self.speed*@math.cos(self.dir/180*@math.PI)
    self.pos.y=self.pos.y+self.speed*@math.sin(self.dir/180*@math.PI)
    if self.type_==3{
        if(self.is_out_partly()){
            self.pos.x=x
            self.pos.y=y
        }
    }
}

pub fn Bullet::update_pos(self:Bullet)->Unit{
    self.pos.x=self.pos.x+self.speed*@math.cos(self.dir/180*@math.PI)
    self.pos.y=self.pos.y+self.speed*@math.sin(self.dir/180*@math.PI)
}

pub fn Cartridge::update_pos(self:Cartridge)->Unit{
    self.pos.x=self.pos.x+self.speed*@math.cos(self.dir/180*@math.PI)
    self.pos.y=self.pos.y+self.speed*@math.sin(self.dir/180*@math.PI)
}
//更新位置#############################################

//检测是否出界#########################################
pub fn Aircraft::is_out_partly(self:Aircraft)->Bool{
    let xl=self.pos.x.to_int()+get_fram_entity(self.type_).xlen.reinterpret_as_int()-1
    let yl=self.pos.y.to_int()+get_fram_entity(self.type_).ylen.reinterpret_as_int()-1
    let x=self.pos.x
    let y=self.pos.y
    if(((x<160&&xl>=160)||(y>low_y.to_double()&&yl>=low_y)||(x<0&&xl>=0)||(y<0&&yl>=0))||self.is_out_all()) {true}
    else {false}
}

pub fn Aircraft::is_out_all(self:Aircraft)->Bool{
    let xl=self.pos.x.to_int()+get_fram_entity(self.type_).xlen.reinterpret_as_int()-1
    let yl=self.pos.y.to_int()+get_fram_entity(self.type_).ylen.reinterpret_as_int()-1
    let x=self.pos.x.to_int()
    let y=self.pos.y.to_int()
    if((x>=160||xl<0)||(y<0||yl>=low_y)) {true}
    else {false}
}


pub fn Bullet::is_out_all(self:Bullet)->Bool{
    let xl=self.pos.x.to_int()+get_fram_entity(self.type_).xlen.reinterpret_as_int()-1
    let yl=self.pos.y.to_int()+get_fram_entity(self.type_).ylen.reinterpret_as_int()-1
    let x=self.pos.x.to_int()
    let y=self.pos.y.to_int()
    if((x>=160||xl<0)||(y<0||yl>=low_y)) {true}
    else {false}
}

pub fn Cartridge::is_out_all(self:Cartridge)->Bool{
    let xl=self.pos.x.to_int()+get_fram_entity(self.type_).xlen.reinterpret_as_int()-1
    let yl=self.pos.y.to_int()+get_fram_entity(self.type_).ylen.reinterpret_as_int()-1
    let x=self.pos.x.to_int()
    let y=self.pos.y.to_int()
    if((x>=160||xl<0)||(y<0||yl>=low_y)) {true}
    else {false}
}

pub fn Cartridge::is_out_partly(self:Cartridge)->Bool{
    let xl=self.pos.x.to_int()+get_fram_entity(self.type_).xlen.reinterpret_as_int()-1
    let yl=self.pos.y.to_int()+get_fram_entity(self.type_).ylen.reinterpret_as_int()-1
    let x=self.pos.x
    let y=self.pos.y
    if(((x<160&&xl>=160)||(y>low_y.to_double()&&yl>=low_y)||(x<0&&xl>=0)||(y<0&&yl>=0))||self.is_out_all()) {true}
    else {false}
}

//检测是否出界#########################################

//判断死亡########################################################################################

pub fn die(self:Aircraft)->Bool{
    self.hp<0.0000001
}

//判断死亡########################################################################################

//检测撞击#################################################################################

pub fn get_ratio_en()->Double{
    return (1.0+scores.val.to_double()*0.0008)
}

pub fn get_ratio_my()->Double{
    return (1.0+scores.val.to_double()*0.0004)
}

pub fn crash(self:Bullet,obj:Aircraft)->Bool{
    let mut xs:Int=0
    let mut ys:Int=0
    let mut xo:Int=0
    let mut yo:Int=0
    let mut ans=false
    let selff=get_fram_entity(self.type_)
    let objj=get_fram_entity(obj.type_)
    for i=selff.sprite.length()-1;i>=0&&ans.not();i=i-1{
        xs=i%selff.xlen.reinterpret_as_int()+self.pos.x.to_int()
        ys=i/selff.xlen.reinterpret_as_int()+self.pos.y.to_int()
        for j=objj.sprite.length()-1;j>=0&&ans.not();j=j-1{
            xo=j%objj.xlen.reinterpret_as_int()+obj.pos.x.to_int()
            yo=j%objj.ylen.reinterpret_as_int()+obj.pos.y.to_int()
            if(xs==xo&&yo==ys) {ans=true}
        }
    }
    if(ans){
        if(self.type_==1||self.type_==11){
            obj.hp=obj.hp-self.harm*get_ratio_en();
        }
        else if(self.type_==2||self.type_==9){obj.hp=obj.hp-self.harm*get_ratio_my()}
    }
    ans
}

pub fn crash(self:Aircraft,obj:Aircraft)->Bool{
    let mut xs:Int=0
    let mut ys:Int=0
    let mut xo:Int=0
    let mut yo:Int=0
    let mut ans=false
    let selff=get_fram_entity(self.type_)
    let objj=get_fram_entity(obj.type_)
    for i=selff.sprite.length()-1;i>=0&&ans.not();i=i-1{
        xs=i%selff.xlen.reinterpret_as_int()+self.pos.x.to_int()
        ys=i/selff.xlen.reinterpret_as_int()+self.pos.y.to_int()
        for j=objj.sprite.length()-1;j>=0&&ans.not();j=j-1{
            xo=j%objj.xlen.reinterpret_as_int()+obj.pos.x.to_int()
            yo=j%objj.ylen.reinterpret_as_int()+obj.pos.y.to_int()
            if(xs==xo&&yo==ys) {ans=true}
        }
    }
    if(ans){
        obj.hp=0
    }
    ans
}

pub fn crash(self:Cartridge,obj:Aircraft)->Bool{
    let mut xs:Int=0
    let mut ys:Int=0
    let mut xo:Int=0
    let mut yo:Int=0
    let mut ans=false
    let selff=get_fram_entity(self.type_)
    let objj=get_fram_entity(obj.type_)
    for i=selff.sprite.length()-1;i>=0&&ans.not();i=i-1{
        xs=i%selff.xlen.reinterpret_as_int()+self.pos.x.to_int()
        ys=i/selff.xlen.reinterpret_as_int()+self.pos.y.to_int()
        for j=objj.sprite.length()-1;j>=0&&ans.not();j=j-1{
            xo=j%objj.xlen.reinterpret_as_int()+obj.pos.x.to_int()
            yo=j%objj.ylen.reinterpret_as_int()+obj.pos.y.to_int()
            if(xs==xo&&yo==ys) {ans=true}
        }
    }
    if(ans){
        self.take_effect(obj)
    }
    ans
}

//检测撞击#################################################################################


//弹药箱生效函数######################################################################################

fn take_effect(self:Cartridge,obj:Aircraft)->Unit{
    if(self.type_==8){
        obj.hp=obj.hp+self.effect
    }
    else if(self.type_==7||self.type_==6){
        obj.bullet_exit_point.clear();
        let len=default_bullet(self.type_).length()
        for i=len-1;i>=0;i=i-1{
            obj.bullet_exit_point.push(default_bullet(self.type_)[i])
        }
    }
}

//弹药箱生效函数######################################################################################

//function of music 


//play_tone的用法如下:
//let toneExample = {
//    frequency: (261, 523),//frequency可以自己定义,其他有需求再定义
//    adsr: adsrSTD,
//    volume: volumeSTD,
//    channel: channelSTD
//};//这里的adsrSTD,volumeSTD,channelSTD是在antity_memory.mbt中定义的标准量
//play_tone(toneExample)
