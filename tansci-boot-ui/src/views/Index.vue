<script setup lang="ts">
  import { reactive, onMounted } from "vue"

  const gzh = new URL('../assets/image/gzh.jpg', import.meta.url).href
  const state = reactive({
    versionList: [
      {timestamp:'2024-01-11', icon:'CircleCloseFilled', color:'#F56C6C', content: [
        '1、token 过期页面重复提示 “用户凭证已过期，请重新登录！” 问题处理；',
        '2、页面管理表格列表不会自适应 问题处理；'
      ]},
      {timestamp:'2024-01-09', icon:'CircleCheckFilled', color:'#409EFF', content: ['项目开源']},
      {timestamp:'2023-07-07', icon:'CircleCheckFilled', color:'#409EFF', content: ['v2.0.0 集成 magic-api']},
      {timestamp:'2023-07-06', icon:'CircleCheckFilled', color:'#409EFF', content: ['v1.0.0 前端amis，后端未使用 magic-api']},
      {timestamp:'2023-03-20', icon:'CircleCheckFilled', color:'#409EFF', content: ['项目初始化']},
    ]
  })

  onMounted(()=>{
      
  })

</script>
<template>
  <div class="home-container">
    <el-card shadow="never">
      <template #header>
        <span>公告</span>
      </template>
      <div>
        <div>
          <span class="title">Tansci Boot</span>
          <el-divider direction="vertical" />
          <el-link type="primary" href="https://gitee.com/typ1805" target="_blank">Gitee</el-link>
          <el-divider direction="vertical" />
          <el-link type="primary" href="https://github.com/typ1805" target="_blank">GitHub</el-link>
        </div>
        <div class="text">
          <el-space alignment="normal" direction="vertical">
            <el-text tag="p">基于 SpringBoot2 + magic-api + Vue3 + Element Plus + amis3.0 快速开发管理系统</el-text>
            <el-text tag="p">Tansci-Boot 是一个前后端分离后台管理系统， 前端集成 amis 低代码前端框架，后端集成 magic-api 的接口快速开发框架。包含基础权限、安全认证、以及常用的一些组件功能。项目易上手，技术更综合，能力更全面。</el-text>
            <el-text tag="p">amis 是一个低代码前端框架，它使用 JSON 配置来生成页面，可以减少页面开发工作量，极大提升效率。</el-text>
            <el-text tag="p">magic-api 一个基于 Java 的接口快速开发框架，通过 magic-api 提供的 UI 界面完成编写接口，无需定义 Controller、Service、Dao、Mapper、XML、VO 等 Java 对象即可完成常见的 HTTP API 接口开发。</el-text>
          </el-space>
        </div>
      </div>
    </el-card>
    <div class="cards">
      <el-card shadow="never">
        <template #header>
          <span>官方信息</span>
        </template>
        <div>
          <div>
            <el-text>博客：</el-text>
            <el-link type="success" href="https://typ1805.gitee.io" target="_blank">https://typ1805.gitee.io</el-link>
          </div>
          <div style="padding-top: 1rem;">
            <el-text>QQ：</el-text>
            <el-link type="success">742354529</el-link>
          </div>
          <div style="padding-top: 1rem;">
            <el-text>QQ群：</el-text>
            <el-link type="success">747200630</el-link>
          </div>
          <div style="padding-top: 1rem;">
            <el-text>公众号：</el-text><br>
            <el-image style="width: 100px; height: 100px" :src="gzh" fit="fit" />
          </div>
        </div>
      </el-card>
      <el-card shadow="never" style="flex: 1;">
        <template #header>
          <span>更新日志</span>
        </template>
        <div>
          <el-scrollbar max-height="22rem">
            <el-timeline>
              <el-timeline-item v-for="item in state.versionList" :key="item" :color="item.color" :icon="item.icon" :timestamp="item.timestamp" placement="top">
                <el-card v-if="item.content.length > 1">
                  <p v-for="c in item.content" :key="c">{{ c }}</p>
                </el-card>
                <p v-else>{{ item.content[0] }}</p>
              </el-timeline-item>
            </el-timeline>
          </el-scrollbar>
        </div>
      </el-card>
    </div>
  </div>
</template>
<style lang="scss" scoped>
  .home-container{
    .title{
      font-size: 20px;
      font-weight: 700;
    }
    .text{
      padding: 2rem 0;
    }
    .el-card{
      margin: 1rem 0;
    }
    .cards{
      display: flex;
      .el-card{
        margin-right: 1rem;
      }
    }
  }
</style>