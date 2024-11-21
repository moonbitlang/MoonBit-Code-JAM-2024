# Spaceack/hypotrochoid_emulator

## 内旋轮线模拟器（Hypotrochoid Emulator）

## 介绍
内旋轮线模拟器，一款`探索`与`发现`的`图形艺术`游戏，通过调整参数，探索参数与图案特点的关联性。

## 玩法

- 按`空格键`开始
- `X`键 切换轮线颜色
- `Z`键 显示/隐藏参数菜单
- `左/右`键选择参数
- `上/下`键调调整参数数值
- `F8` 截取图像

## 参数说明

- d: 小圆上固定点到小圆圆心的距离
- lr: 小圆的半径
- br: 大圆的半径
- ti: 旋转次数

```bash
# install moonbit
curl -fsSL https://cli.moonbitlang.cn/install/unix.sh | bash
# install wasm4
npm install -D wasm4
# 
moon update && moon add moonbitlang/wasm4
# build
moon build --target wasm 
# run
npx wasm4 run target/wasm/release/build/hypotrochoid_emulator.wasm

```
