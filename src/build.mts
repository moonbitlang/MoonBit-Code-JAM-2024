import fs from 'node:fs'
import cp from 'node:child_process'
import querystring from 'node:querystring'
import markdownit from 'markdown-it'
import * as octokit from 'octokit'

const ghClient = new octokit.Octokit({
  auth: process.env.GITHUB_TOKEN,
})

const md = markdownit({
  html: true,
  linkify: true,
  typographer: true,
})

function githubBtn(
  authorName: string,
  repoName: string,
  option: { large: boolean },
): string {
  const { large } = option
  return `<iframe src="https://ghbtns.com/github-btn.html?user=${querystring.escape(
    authorName,
  )}&repo=${querystring.escape(repoName)}&type=star&count=true${
    large && '&size=large'
  }" frameborder="0" scrolling="0" width="140" height="32" title="GitHub">
  </iframe>`
}

async function getPRInfo(prNumber: number) {
  return (
    await ghClient.request('GET /repos/{owner}/{repo}/pulls/{pull_number}', {
      owner: 'moonbitlang',
      repo: 'MoonBit-Code-JAM-2024',
      pull_number: prNumber,
      headers: {
        'X-GitHub-Api-Version': '2022-11-28',
      },
    })
  ).data
}

type MetaInfo = {
  title?: string
  control?: string
  readme?: string
  cover: boolean
  prInfo: Awaited<ReturnType<typeof getPRInfo>>
}

const metaInfos = new Map<string, MetaInfo>()

async function collectMetaInfos(): Promise<void> {
  const pulls = await ghClient.request('GET /repos/{owner}/{repo}/pulls', {
    state: 'closed',
    owner: 'moonbitlang',
    repo: 'MoonBit-Code-JAM-2024',
    headers: {
      'X-GitHub-Api-Version': '2022-11-28',
    },
  })

  for (const pull of pulls.data) {
    const pull_number = pull.number
    const files = await ghClient.request(
      'GET /repos/{owner}/{repo}/pulls/{pull_number}/files',
      {
        owner: 'moonbitlang',
        repo: 'MoonBit-Code-JAM-2024',
        pull_number,
        headers: {
          'X-GitHub-Api-Version': '2022-11-28',
        },
      },
    )
    for (const file of files.data) {
      const [teams, teamName, name] = file.filename.split('/', 3)
      if (teams === 'teams' && name === 'game.wasm') {
        if (metaInfos.has(teamName)) {
          break
        }
        if (!fs.existsSync(`teams/${teamName}`)) {
          break
        }
        const prInfo = await getPRInfo(pull_number)
        const metaInfo: MetaInfo = {
          prInfo,
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

        console.log(`metainfo of ${teamName}:`, metaInfo)
        metaInfos.set(teamName, metaInfo)
        break
      }
    }
  }
}

function renderGameCard(teamName: string, metaInfo: MetaInfo): string {
  const coverPath = metaInfo.cover
    ? `${querystring.escape(teamName)}/cover.png`
    : 'default-cover.png'

  const teamPath = querystring.escape(teamName)
  const authorName = metaInfo.prInfo.head.user.login
  const repoName = metaInfo.prInfo.head.repo?.name

  if (repoName === undefined) {
    throw new Error(`renderGameCard: repoName is undefined`)
  }

  const footer = metaInfo.title
    ? `<h2>${metaInfo.title}</h2><p>${teamName}</p>`
    : `<p>${teamName}</p>`

  return /*html*/ `
<div class='game-card'>
  <a href='${teamPath}/index.html'>
    <div class='game-card__star'>
      ${githubBtn(authorName, repoName, { large: true })}
    </div>
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

function indexHtml(): string {
  const gameCards = [...metaInfos.entries()]
    .map(e => renderGameCard(...e))
    .join('\n')

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
        grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
        gap: 1rem;
      }

      .game-card {
        border-radius: 0.5rem;
        background-color: #242526;
        position: relative;
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

      .game-card__star {
        position: absolute;
        left: 4px;
        top: 4px;
        display: none
      }

      .game-card a:hover .game-card__star {
        display: block
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
            <a class='button' href='https://tianchi.aliyun.com/competition/entrance/532262'>立即报名</a>
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

function gameIndexHtml(teamName: string, metaInfo: MetaInfo): string {
  const title = metaInfo.title ?? teamName
  const control = metaInfo.control ?? ''
  const readme = metaInfo.readme ? md.render(metaInfo.readme) : ''
  const authorName = metaInfo.prInfo.head.user.login
  const repoName = metaInfo.prInfo.head.repo?.name
  const authorUrl = metaInfo.prInfo.head.user.html_url
  const avatarUrl = metaInfo.prInfo.head.user.avatar_url
  const updateTime = metaInfo.prInfo.merged_at

  if (repoName === undefined || updateTime === null) {
    throw new Error(
      JSON.stringify(
        {
          title,
          control,
          readme,
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

      a {
        color: #f44cd5;
        text-decoration: none;
      }

      a:hover {
        text-decoration: underline;
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

      .vote {
        display: flex;
        align-items: center;
        gap: 0.5rem;
        font-size: 1.125rem;
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
        <h1>${title}</h1>
        <p class="vote">Star 仓库，为 ta 投票
        ${githubBtn(authorName, repoName, { large: true })}
        </p>
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

fs.rmSync('dist', { recursive: true, force: true })
fs.mkdirSync('dist')
await collectMetaInfos()
fs.writeFileSync('dist/index.html', indexHtml())
fs.copyFileSync('assets/default-cover.png', 'dist/default-cover.png')
for (const [teamName, metaInfo] of metaInfos) {
  const gameIndex = gameIndexHtml(teamName, metaInfo)
  fs.mkdirSync(`dist/${teamName}`)
  copyWasm4(teamName)
  for (const file of fs.readdirSync(`teams/${teamName}`)) {
    fs.copyFileSync(
      `teams/${teamName}/${file}`,
      `dist/${teamName}/${file === 'game.wasm' ? 'cart.wasm' : file}`,
    )
  }
  fs.writeFileSync(`dist/${teamName}/index.html`, gameIndex)
}
