import fs from 'node:fs'
import querystring from 'node:querystring'
import * as marked from 'marked'

fs.rmSync('dist', { recursive: true, force: true })
fs.mkdirSync('dist')

const games = fs
  .readdirSync('teams', { withFileTypes: true })
  .filter(d => d.isDirectory())
  .map(d => d.name)

const gameCards = games
  .map(d => {
    const coverPath = fs.existsSync(`teams/${d}/cover.png`)
      ? `${querystring.escape(d)}/cover.png`
      : 'default-cover.png'
    return /*html*/ `
<div class='game-card'>
  <a href='${querystring.escape(d)}/index.html'>
    <div class='game-card__cover'>
      <img src='${coverPath}'/>
    </div>
    <div class='game-card__footer'>
      <p href='${querystring.escape(d)}/index.html'>${d}</p>
    </div>
  </a>
</div>
`.trim()
  })
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

      body, main, h1, p {
        padding: 0;
        margin: 0
      }

      .main-wrapper {
        background-color: #18191a;
        color: rgb(245, 246, 247);
        min-height: 100vh;
      }

      main {
        margin: 0 6rem;
      }

      @media (width < 996px) {
        main {
          margin: 0 1rem;
        }
      }

      .intro-section {
        padding: 2rem 0;
        display: flex;
        flex-direction: column;
        gap: 2rem;
        align-items: center;
        color: rgb(245, 246, 247);
      }

      .intro-section a {
        color: rgb(245, 246, 247);
      }

      .intro-section h1 {
        font-size: 3rem;
      }

      .intro-section p {
        font-size: 1.25rem;
      }

      .buttons {
        display: flex;
        gap: 1rem;
      }

      .game-cards {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
        gap: 1rem;
      }

      .game-card {
        border-radius: 0.5rem;
        background-color: #242526;
      }

      .game-card a {
        color: rgb(245, 246, 247);
        transition: color 0.2s;
        text-decoration: none;
        display: flex;
        flex-direction: column;
      }

      .game-cards a:hover {
        color: #f44cd5
      }

      .game-card__cover {
        display: flex;
        align-items: center;
        justify-content: center;
        aspect-ratio: 1;
      }

      .game-card__cover img {
        display: block;
        width: 100%;
      }

      .game-card__footer {
        padding: 1rem;
      }

      .button {
        padding: 0.75rem 2rem;
        font-size: 1.25rem;
        border-radius: 0.5rem;
        background-color: rgb(158, 16, 132);
        font-weight: bold;
        text-decoration: none;
      }

      .button:hover {
        background-color: rgb(158, 16, 132, 0.9);
        cursor: pointer;
      }

    </style>
  </head>
  <body>
    <div class='main-wrapper'>
      <main>
        <section class='intro-section'>
          <h1>MoonBit Code JAM 2024</h1>
          <p>选手提交作品展示</p>
          <div class='buttons'>
            <a class='button' href='https://tianchi.aliyun.com/s/399e702c1b75629138f56fdb6f5e411a'>立即报名</a>
            <a class='button' href='https://github.com/moonbitlang/MoonBit-Code-JAM-2024'>提交作品</a>
          </div>
        </section>
        <div class='game-cards'>
        ${gameCards}
        </div>
      </main>
    </div>
  </body>
</html>
`

fs.writeFileSync('dist/index.html', index)

const wasm4Files = fs.readdirSync('node_modules/wasm4/assets/runtime/slim')

for (const game of games) {
  let readmeHtml = undefined
  if (fs.existsSync(`teams/${game}/README.md`)) {
    const readme = fs.readFileSync(`teams/${game}/README.md`, 'utf8')
    readmeHtml = marked.parse(readme, { gfm: true, async: false })
  }
  const gameIndex = /*html*/ `
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>${game}</title>
    <style>
      :root {
        font-family: system-ui, -apple-system, Segoe UI, Roboto, Ubuntu, Cantarell,
        Noto Sans, sans-serif, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial,
        sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol';
      }

      *,
      *::before,
      *::after {
        box-sizing: border-box;
      }

      body, main {
        padding: 0;
        margin: 0
      }

      .main-wrapper {
        background-color: #18191a;
        color: rgb(245, 246, 247);
        min-height: 100vh;
      }

      main {
        margin: 0 6rem;
        padding: 2rem 0;
      }

      @media (width < 996px) {
        main {
          margin: 0 1rem;
        }
      }

      .wasm4-game {
        display: block;
        margin: 0 auto;
        max-width: 400px;
        width: 100%;
        aspect-ratio: 1;
      }

      .readme {
        line-height: 1.5;
        word-wrap: break-word;
      }

    </style>
  </head>
  <body>
    <div class='main-wrapper'>
      <main>
        <iframe class="wasm4-game" src="game.html" frameborder="0"></iframe>
        ${
          readmeHtml
            ? /*html*/ `<article class='readme'>${readmeHtml}</article>`
            : ''
        }
      </main>
    </div>
  </body>
</html>
`
  fs.mkdirSync(`dist/${game}`)
  for (const file of wasm4Files) {
    fs.copyFileSync(
      `node_modules/wasm4/assets/runtime/slim/${file}`,
      `dist/${game}/${file === 'index.html' ? 'game.html' : file}`,
    )
  }
  for (const file of fs.readdirSync(`teams/${game}`)) {
    fs.copyFileSync(
      `teams/${game}/${file}`,
      `dist/${game}/${file === 'game.wasm' ? 'cart.wasm' : file}`,
    )
  }
  fs.writeFileSync(`dist/${game}/index.html`, gameIndex)
}

fs.copyFileSync('assets/default-cover.png', 'dist/default-cover.png')
