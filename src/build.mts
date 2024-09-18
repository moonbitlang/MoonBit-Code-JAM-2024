import fs from 'node:fs'
import cp from 'node:child_process'
import querystring from 'node:querystring'
import markdownit from 'markdown-it'
import * as octokit from 'octokit'

const ghClient = new octokit.Octokit({
  auth: process.env.GITHUB_TOKEN,
})

const md = markdownit()

const mockData = JSON.parse(fs.readFileSync('data.json', 'utf8'))

const starSvg = `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512" width="1em" height="1em" stroke="currentColor" fill="currentColor" ><!--! Font Awesome Free 6.6.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free (Icons: CC BY 4.0, Fonts: SIL OFL 1.1, Code: MIT License) Copyright 2024 Fonticons, Inc. --><path d="M287.9 0c9.2 0 17.6 5.2 21.6 13.5l68.6 141.3 153.2 22.6c9 1.3 16.5 7.6 19.3 16.3s.5 18.1-5.9 24.5L433.6 328.4l26.2 155.6c1.5 9-2.2 18.1-9.7 23.5s-17.3 6-25.3 1.7l-137-73.2L151 509.1c-8.1 4.3-17.9 3.7-25.3-1.7s-11.2-14.5-9.7-23.5l26.2-155.6L31.1 218.2c-6.5-6.4-8.7-15.9-5.9-24.5s10.3-14.9 19.3-16.3l153.2-22.6L266.3 13.5C270.4 5.2 278.7 0 287.9 0zm0 79L235.4 187.2c-3.5 7.1-10.2 12.1-18.1 13.3L99 217.9 184.9 303c5.5 5.5 8.1 13.3 6.8 21L171.4 443.7l105.2-56.2c7.1-3.8 15.6-3.8 22.6 0l105.2 56.2L384.2 324.1c-1.3-7.7 1.2-15.5 6.8-21l85.9-85.1L358.6 200.5c-7.8-1.2-14.6-6.1-18.1-13.3L287.9 79z"/></svg>`

fs.rmSync('dist', { recursive: true, force: true })
fs.mkdirSync('dist')

async function getPRInfo(prNumber: number) {
  const res = await ghClient.request(
    'GET /repos/{owner}/{repo}/pulls/{pull_number}',
    {
      owner: 'moonbitlang',
      repo: 'MoonBit-Code-JAM-2024',
      pull_number: prNumber,
      headers: {
        'X-GitHub-Api-Version': '2022-11-28',
      },
    },
  )

  return res.data
}

type MetaInfo = {
  teamName: string
  title?: string
  control?: string
  readme?: string
  cover: boolean
  prInfo: Awaited<ReturnType<typeof getPRInfo>>
}

function $(strings: TemplateStringsArray, ...args: string[]): string {
  const command = strings.reduce(
    (prev, current, i) => prev + args[i - 1] + current,
  )
  return cp.execSync(command).toString().trim()
}

function getPrNumber(teamName: string): number {
  const files = fs
    .readdirSync(`teams/${teamName}`, { withFileTypes: true })
    .filter(d => d.isFile())
    .map(d => d.name)

  const latestFile = files.sort((a, b) => {
    const aTime = fs.statSync(`teams/${teamName}/${a}`).ctimeMs
    const bTime = fs.statSync(`teams/${teamName}/${b}`).ctimeMs
    return bTime - aTime
  })[0]

  const commit = $`git log --format=%H teams/${teamName}/${latestFile}`
  const oldestMergeCommit =
    $`git rev-list --reverse --merges ${commit}^..HEAD`.split('\n')[0]
  const mergeCommitMessage = $`git log --format=%B -n 1 ${oldestMergeCommit}`
  const title = mergeCommitMessage.split('\n')[0]
  const prNumber = title.match(/Merge pull request #(\d+)/)?.[1]
  if (prNumber === undefined) {
    throw new Error('No PR number found')
  }
  return Number(prNumber)
}

async function collectMetaInfo(teamName: string): Promise<MetaInfo> {
  const prNumber = getPrNumber(teamName)
  const prInfo = process.env.DEV ? mockData : await getPRInfo(prNumber)

  const metaInfo: MetaInfo = {
    teamName,
    cover: false,
    prInfo,
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

const metaInfos = await Promise.all(teamNames.map(collectMetaInfo))

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
  const authorName = metaInfo.prInfo.head.user.login
  const authorUrl = metaInfo.prInfo.head.user.html_url
  const avatarUrl = metaInfo.prInfo.head.user.avatar_url
  const starUrl = metaInfo.prInfo.head.repo?.html_url
  const updateTime = metaInfo.prInfo.merged_at

  if (starUrl === undefined || updateTime === null) {
    throw new Error(
      JSON.stringify(
        {
          title,
          control,
          readme,
          starUrl,
          avatarUrl,
          updateTime,
        },
        null,
        2,
      ),
    )
  }

  const updateDate = new Date(updateTime).toLocaleDateString('zh-CN', {
    year: 'numeric',
    month: 'long',
    day: 'numeric',
  })

  const avatar = /*html*/ `
    <div class="avatar">
      <a href="${authorUrl}" class="avatar__photo" target="_blank">
        <img src="${avatarUrl}"/>
      </a>
      <div class="avatar__intro">
        <div class="avatar__name">
          <a href="${authorUrl}" target="_blank">${authorName}</a>
        </div>
        <p class="avatar__subtitle">${updateDate}</p>
      </div>
    </div>
  `
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

      .icons {
        margin-left: 0.5rem
      }

      .icons a {
        color: white
      }

      .icons a:hover {
        color: #f44cd5
      }

      .avatar {
        display: flex;
        gap: 1.5rem
      }

      .avatar__photo img {
        height: 64px;
        border-radius: 50%;
        display: block
      }

      .avatar__intro {
        display: flex;
        flex-direction: column;
        gap: 0.5rem;
        justify-content: center;
      }

      .avatar__name {
        font-size: 1.25rem;
        font-weight: bold;
      }

      .avatar__name a {
        color: #f44cd5;
        text-decoration: none;
      }

      .avatar__name a:hover {
        text-decoration: underline;
      }

      .avatar__subtitle {
        margin: 0;
      }

    </style>
  </head>
  <body>
    <div class='main-wrapper'>
      <main>
        <iframe class="wasm4-game" src="game.html" frameborder="0"></iframe>
        <p class="control">${control}</p>
        <h1>${title} <span class="icons"><a href="${starUrl}">${starSvg}</a></span></h1>
        ${avatar}
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
