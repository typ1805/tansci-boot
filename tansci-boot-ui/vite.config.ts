import { defineConfig } from 'vite'
import path from 'path'
import vue from '@vitejs/plugin-vue'

const url = "http://127.0.0.1:8000"
export default defineConfig({
  resolve: {
    alias: {
      '@': path.resolve(__dirname, 'src'),
    },
  },
  css: {
    preprocessorOptions: {
      scss: {
        additionalData: `@use "@/styles/element/index.scss" as *;`,
      },
    },
  },
  plugins: [
    vue()
  ],
  server: {
    proxy: {
      '/system': {
        target: url,
        changeOrigin: true,
        pathRewrite: {
          '^/system':'/system'
        }
      }
    }
  }
})
