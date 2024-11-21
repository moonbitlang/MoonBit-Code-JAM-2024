pub fn start() -> Unit {
	@wasm4.set_palette(1,@wasm4.rgb(1377129))
	@wasm4.set_palette(4,@wasm4.rgb(11221214))
	@wasm4.set_palette(3,@wasm4.rgb(16754473))
	@wasm4.set_palette(2,@wasm4.rgb(5224703))
	//初始化调色板，之后调色板禁止更改！！
}

pub fn update() -> Unit {
	// @wasm4.trace("312312")
	@time_cnt.update_time();
	// @antity.player_Plane_1_frame.print()
	@interface.interface()
	// @antity.player_Plane.print()
}
