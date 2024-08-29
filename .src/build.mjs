import fs from 'node:fs'

fs.rmSync('.dist', { recursive: true, force: true })
fs.mkdirSync('.dist')

const games = fs
  .readdirSync('.', { withFileTypes: true })
  .filter(d => d.isDirectory() && !d.name.startsWith('.'))
  .map(d => d.name)

const lis = games.map(d => `<li><a href='/${d}'>${d}</a></li>`)

const index = /*html*/ `
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>MoonBit Code JAM 2024</title>
  </head>
  <body>
    <ul>
    ${lis}
    </ul>
  </body>
</html>
`

fs.writeFileSync('.dist/index.html', index)

const wasm4Files = fs.readdirSync('.templates/wasm4')

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
    fs.copyFileSync(`.templates/wasm4/${file}`, `.dist/${game}/${file}`)
  }
  fs.writeFileSync(`.dist/${game}/index.html`, gameIndex)
}
