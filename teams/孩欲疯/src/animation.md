

//@wasm4.blit(smiley, 10, 10, 8, 8, BLIT_1BPP);
*这个Animation结构体代表了一个动画对象，它管理了一个Atlas（纹理集）的播放。Atlas可能是一个包含多个图像（帧）的集合，通常用于动画、精灵图等场景。

构造函数和析构函数：使用了默认构造和析构函数。

reset：重置动画到初始状态，即计时器归零，帧索引归零。

set_atlas：设置动画使用的纹理集，并重置动画状态。

set_loop：设置动画是否循环播放。

set_interval：设置动画帧之间的时间间隔（以毫秒为单位）。

get_idx_frame：获取当前帧的索引。

get_frame：获取当前帧的图像。

check_finished：检查动画是否结束（仅当不循环时有效）。

set_callback：设置动画结束时的回调函数（仅当不循环时有效）。

on_update：更新动画状态。根据给定的时间差（delta），更新计时器，并可能增加帧索引。如果帧索引超出范围，则根据是否循环来重置或停止。如果动画结束且设置了回调函数，则调用该回调函数。

on_draw：在指定位置绘制当前帧的图像。

这个结构体允许你在游戏中实现动画的播放和控制，通过管理帧的索引和时间间隔来控制动画的播放速度，并通过回调函数来处理动画结束的情况。*
struct Animation{

void reset(){
timer = 0;
idx_frame = 0;
}
void set_atlas(Atlas* new_atlas){
reset();
atlas = new_atlas;
}
void set_loop(bool flag)
is_loop = flag;

void set_interval(int ms)
interval = ms;

int get_idx_frame()
return idx_frame;

IMAGE* get_frame( )
return atlas->get_image(idx_frame);

bool check_finished( )
if (is_1oop) return false;
return (idx_frame == atlas->get_size() - 1);

void set_callback(std::function<void()> callback)
this->callback = callback;

void on_update(int delta)
timer += delta;
if (timer >= interval)
timer =0; idx_frame++;
if (idx_frame >= atlas->get_size( ))
idx_frame = is_loop ? 0 : atlas->get_size() - 1; if (!is_1oop && callback)
callback();

void on_draw(int x, int y) const
putimage_alpha(x, y, atlas->get_image(idx_frame));

private:
int timer = 0;	//计时器	
int interval = 0;	// 帧间隔	
int idx_frame =0;	// 帧索引	
bool is_loop = true;	//是否循环	
Atlas* atlas = nullptr;
std::function<void()> callback;

#endif // !_ANIMATION_H_
}