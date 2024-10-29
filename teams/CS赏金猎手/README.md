# 九宫棋（Tic-Tac-Toe）

## 介绍
九宫棋（井字棋），也被称为Tic-Tac-Toe，是一个简单但富有挑战性的经典策略游戏。游戏的目标是在一个3×3的网格上，通过放置棋子来形成一条直线，无论是水平的、垂直的还是对角线，率先完成的玩家即为胜者。

## 玩家回合

1. 按`空格键`开始
2. 按`上下左右`选择棋格
3. 按`空格键`落子

- T：游戏总次数
- S：获胜次数

## 创作心得分享

[【2024年全球 MoonBit 编程创新赛-零基础早鸟教程-使用wasm4八小时开发井子棋小游戏 - CSDN App】](https://blog.csdn.net/a541972321/article/details/143244771?sharetype=blog&shareId=143244771&sharerefer=APP&sharesource=a541972321&sharefrom=link)

## 编译及运行

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
npx wasm4 run target/wasm/release/build/TicTacToe.wasm

```