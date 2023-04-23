<script setup lang="ts">
  import { reactive, onMounted } from "vue"

  const state = reactive({
    versionList: [
      {content:'项目初始化',timestamp:'2023-04-01'},
      {content:'项目初始化',timestamp:'2023-04-01'},
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
            <el-text tag="p">一款基于 SpringBoot + Vue3.2 + Element Plus 的后台管理系统。带你快速掌握SpringBoot核心知识 + Vue全家桶全栈技能。在此过程中，从0到1经历开发全流程，掌握前后端分离开发模式，搭建一个专属自己的、内容可灵活配置的知识库系统。</el-text>
            <el-text tag="p">此项目是为了减少业务代码的重复轮子,它具有一个系统该有的通用性核心业务代码,无论是微服务还是单体,都是通用的业务 但更多的,是为了学习微服务的理念以及开发 您可以使用它进行网站管理后台，网站会员中心，CMS，CRM，OA等待系统的开发, 当然,不仅仅是一些小系统,我们可以生产更多的服务模块,不断完善项目。</el-text>
            <el-text tag="p">系统初心是为了能够更快地完成业务的需求，带来更好的体验、更多的时间。它将会用于孵化一些实用的功能点。 我们希望它们是轻量级，可移植性高的功能插件。</el-text>
            <el-text tag="p">同时，我们更希望广大开发者能在其中更快地获得更好的解决方案、尽量降低我们的学习成本。 由此，我们应当把更多的时间投入到其它更有意义的事情当中，我们深知知识的重要性，但，并不希望仅拥有单一”知识“。 去感受/关爱更多光彩，无论人、事、物，它们也将成为你最好的灵感。</el-text>
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
            <el-text>官网：</el-text>
            <el-link type="success" href="https://typ1805.gitee.io" target="_blank">https://typ1805.gitee.io</el-link>
          </div>
          <div style="padding-top: 1rem;">
            <el-text>交流群：</el-text>
            <el-link type="success">747200630</el-link>
          </div>
        </div>
      </el-card>
      <el-card shadow="never" style="flex: 1;">
        <template #header>
          <span>Tansci发展史</span>
        </template>
        <div>
          <el-timeline>
            <el-timeline-item v-for="item in state.versionList" :key="item" :timestamp="item.timestamp">
              {{ item.content }}
            </el-timeline-item>
          </el-timeline>
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