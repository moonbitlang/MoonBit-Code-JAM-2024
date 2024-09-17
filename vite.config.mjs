import { defineConfig } from 'vite'
import chokidar from 'chokidar'
import cp from 'node:child_process'

/**
 * @type {import('vite').Plugin}
 */
const plugin = {
  buildStart() {
    cp.execSync('tsx src/build.mts', { stdio: 'inherit' })
    chokidar.watch(['src', 'teams']).on('all', (event, path) => {
      cp.execSync('tsx src/build.mts', { stdio: 'inherit' })
    })
  },
}

export default defineConfig({
  root: 'dist',
  plugins: [plugin],
})
