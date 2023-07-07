import { defineConfig } from 'vite'
import path from 'path'
import vue from '@vitejs/plugin-vue'

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
      '/tansci': {
        target: 'http://127.0.0.1:8000',
        changeOrigin: true,
        pathRewrite: {'^/tansci':'/tansci'} 
      }
    } as any
  }
})
