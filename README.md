# Tansci-Boot

<p align="center">
<a href="https://www.oracle.com/java/technologies/downloads/#java8"><img src="https://img.shields.io/badge/jdk-8+-green.svg" alt="jdk8"></a>
<a href="https://vuejs.org"><img src="https://img.shields.io/badge/-Vue-34495e?logo=vue.js" alt="Vue3"></a>
<a href="https://element-plus.gitee.io/#/zh-CN/component/changelog"><img src="https://img.shields.io/badge/element--plus-latest-blue" alt="Element Plus"></a>
<a href="https://aisuda.bce.baidu.com/amis/zh-CN/docs/index"><img src="./doc/logo_408c434.png" width="60" height="20" alt="amis"></a>
<a href="https://gitee.com/link?target=http%3A%2F%2Fwww.opensource.org%2Flicenses%2FMIT"><img src="https://img.shields.io/badge/license-MIT-brightgreen.svg" alt="MIT"></a>
</p>

<p align="center">基于 SpringBoot2 + Vue3 + Element Plus + amis3.0 快速开发管理系统</p>

Tansci-Boot 是一个前后端分离后台管理系统， 前端集成 `amis` 低代码前端框架。包含基础权限、安全认证、以及常用的一些组件功能。项目易上手，技术更综合，能力更全面。

[amis](https://aisuda.bce.baidu.com/amis/zh-CN/docs/index) 是一个低代码前端框架，它使用 `JSON` 配置来生成页面，可以减少页面开发工作量，极大提升效率。

全面的技术运用：

- 解决前后端分离难题：前后端功能整合，集成 HTTP 组件 Axios，解决前后端分离架构中常见的问题，如跨域、参数传递、多环境配置等；
- 落地实践工程化项目：涵盖日志、配置文件、部署、Git、Maven，后端接口统一返回参数设计、封装统一请求返回参数、工具类封装；
- amis：低代码前端配置框架。

## 项目预览

![登录](doc/login.png) | ![登录日志](doc/loginlog.png)
---|---

![首页](doc/home.png) | ![首页](doc/home-1.png)
---|---

![菜单](doc/menu.png) | ![操作日志](doc/log.png)
---|---

![amis](doc/amis.png) | ![magic-api](doc/LcPages.png)
---|---

## 开始使用

执行 SQL 初始化数据（MySQL8+ 版本），测试用户：`admin/123456`。

**项目目录：**

- tansci-boot：后端项目
- tansci-boot-ui：前端项目
- tansci-boot-ui-editor：amis 低代码编辑器
- sql：数据库 SQL 脚本

**amis 配置说明：**

在 ``tansci-boot-ui/public/gh-pages/config.js`` 可配置编辑器获取页面JSON和保存接口的配置。

> 注意：在页面编辑器中业务接口回报404可忽略。

**接口开发配置：**

接口开发菜单页面加载不了，检查环境变量配置的服务地址是否和后端服务一致：``tansci-boot-ui/.env.development`` 参数 `VITE_BASE_API`

**项目地址：**

Gitee: [https://gitee.com/typ1805/tansci-boot](https://gitee.com/typ1805/tansci-boot)

GitHub: [https://github.com/typ1805/tansci-boot](https://github.com/typ1805/tansci-boot)

## 开发者联系

- QQ：742354529 （742354529@qq.com）
- QQ 群： 747200630
- 个人主站：[https://typ1805.gitee.io](https://typ1805.gitee.io)
- 公众号：

![个人公众号](doc/gzh.jpg)