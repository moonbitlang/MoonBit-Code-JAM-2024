import fs from 'node:fs'

fs.rmSync('dist', { recursive: true, force: true })
fs.mkdirSync('dist')

const games = fs
  .readdirSync('teams', { withFileTypes: true })
  .filter(d => d.isDirectory())
  .map(d => d.name)

const gameCards = games
  .map(d =>
    /*html*/ `
<div>
  <a href='${d}/index.html'>${d}</a>
</div>
`.trim(),
  )
  .join('\n')

const index = /*html*/ `
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>MoonBit Code JAM 2024</title>
    <style>
      :root {
        font-family: system-ui,-apple-system,Segoe UI,Roboto,Ubuntu,Cantarell,Noto Sans,sans-serif,BlinkMacSystemFont,"Segoe UI",Helvetica,Arial,sans-serif,"Apple Color Emoji","Segoe UI Emoji","Segoe UI Symbol";
      }
      *, *::before, *::after {
        box-sizing: border-box;
      }
      h1 {
        text-align: center;
      }
    </style>
  </head>
  <body>
    <h1>MoonBit Code JAM 2024</h1>
    <div>
    ${gameCards}
    </div>
  </body>
</html>
`

fs.writeFileSync('dist/index.html', index)

const wasm4Files = fs.readdirSync('templates/wasm4')

for (const game of games) {
  const gameIndex = /*html*/ `
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>${game}</title>
  </head>
  <body>
    <iframe src="./game.html" frameborder="0" width="600" height="600"></iframe>
  </body>
</html>
`
  fs.mkdirSync(`.dist/${game}`)
  for (const file of wasm4Files) {
    fs.copyFileSync(`templates/wasm4/${file}`, `dist/${game}/${file}`)
  }
  fs.copyFileSync(`${game}/game.wasm`, `dist/${game}/cart.wasm`)
  fs.writeFileSync(`dist/${game}/index.html`, gameIndex)
}
