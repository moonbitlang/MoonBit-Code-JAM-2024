import fs from 'node:fs'
import querystring from 'node:querystring'
import markdownit from 'markdown-it'

const md = markdownit()

fs.rmSync('dist', { recursive: true, force: true })
fs.mkdirSync('dist')

type MetaInfo = {
  teamName: string
  title?: string
  control?: string
  readme?: string
  cover: boolean
}

function collectMetaInfo(teamName: string): MetaInfo {
  const metaInfo: MetaInfo = {
    teamName,
    cover: false,
  }

  const files = fs
    .readdirSync(`teams/${teamName}`, { withFileTypes: true })
    .filter(d => d.isFile())
    .map(d => d.name)

  for (const file of files) {
    const read = (file: string): string =>
      fs.readFileSync(`teams/${teamName}/${file}`, 'utf8')
    switch (file) {
      case 'cover.png': {
        metaInfo.cover = true
        continue
      }
      case 'README.md': {
        metaInfo.readme = read(file)
        continue
      }
      case 'title': {
        metaInfo.title = read(file)
        continue
      }
      case 'control': {
        metaInfo.control = read(file)
        continue
      }
    }
  }

  return metaInfo
}

const teamNames = fs
  .readdirSync('teams', { withFileTypes: true })
  .filter(d => d.isDirectory())
  .map(d => d.name)

const metaInfos = teamNames.map(collectMetaInfo)

function renderGameCard(metaInfo: MetaInfo): string {
  const coverPath = metaInfo.cover
    ? `${querystring.escape(metaInfo.teamName)}/cover.png`
    : 'default-cover.png'

  const teamPath = querystring.escape(metaInfo.teamName)

  const footer = metaInfo.title
    ? `<h2>${metaInfo.title}</h2><p>${metaInfo.teamName}</p>`
    : `<p>${metaInfo.teamName}</p>`

  return /*html*/ `
<div class='game-card'>
  <a href='${teamPath}/index.html'>
    <div class='game-card__cover'>
      <img src='${coverPath}'/>
    </div>
    <div class='game-card__footer'>
      ${footer}
    </div>
  </a>
</div>
`.trim()
}

function indexHtml(metaInfos: MetaInfo[]): string {
  const gameCards = metaInfos.map(renderGameCard).join('\n')

  return /*html*/ `
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

      body, main, h1, h2, p {
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

      @media (max-width: 996px) {
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

      @media (max-width: 996px) {
        .buttons {
          flex-direction: column;
        }
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
        border-radius: 0.5rem 0.5rem 0 0;
        display: block;
        width: 100%;
      }

      .game-card__footer {
        padding: 1rem;
      }

      .game-card__footer h2 {
        font-size: 1.5rem;
        margin-bottom: 0.5rem;
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
}

function gameIndexHtml(metaInfo: MetaInfo): string {
  const title = metaInfo.title ?? metaInfo.teamName
  const control = metaInfo.control ?? ''
  const readme = metaInfo.readme ? md.render(metaInfo.readme) : ''
  return /*html*/ `
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>${title}</title>
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

      @media (max-width: 996px) {
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

      .control {
        text-align: center;
        font-size: 1rem;
        color: rgb(245, 246, 247)
      }

    </style>
  </head>
  <body>
    <div class='main-wrapper'>
      <main>
        <iframe class="wasm4-game" src="game.html" frameborder="0"></iframe>
        <p class="control">${control}</p>
        <h1>${title}</h1>
        <article>
          ${readme}
        </article>
      </main>
    </div>
  </body>
</html>
`
}

function copyWasm4(dist: string) {
  const wasm4Files = fs.readdirSync('node_modules/wasm4/assets/runtime/slim')
  for (const file of wasm4Files) {
    fs.copyFileSync(
      `node_modules/wasm4/assets/runtime/slim/${file}`,
      `dist/${dist}/${file === 'index.html' ? 'game.html' : file}`,
    )
  }
}

fs.writeFileSync('dist/index.html', indexHtml(metaInfos))
fs.copyFileSync('assets/default-cover.png', 'dist/default-cover.png')
for (const metaInfo of metaInfos) {
  const gameIndex = gameIndexHtml(metaInfo)
  fs.mkdirSync(`dist/${metaInfo.teamName}`)
  copyWasm4(metaInfo.teamName)
  for (const file of fs.readdirSync(`teams/${metaInfo.teamName}`)) {
    fs.copyFileSync(
      `teams/${metaInfo.teamName}/${file}`,
      `dist/${metaInfo.teamName}/${file === 'game.wasm' ? 'cart.wasm' : file}`,
    )
  }
  fs.writeFileSync(`dist/${metaInfo.teamName}/index.html`, gameIndex)
}
