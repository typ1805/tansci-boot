import Layout from '@/components/layout/Index.vue'
export default[
  {
    path: '/index',
    name: 'index',
    type: 0,
    icon: 'HomeFilled',
    meta: { title: "首页" },
    component: () => Layout,
    children: [
      {
        path: '/index',
        name: 'index',
        type: 0,
        icon: 'HomeFilled',
        meta: { title: "首页" },
        component: () => import('@/views/Index.vue')
      }
    ]
  },
  {
    path: '/system',
    name: 'system',
    type: 0,
    icon: 'Grid',
    meta: { title: "系统管理" },  
    children: [
      {
        path: '/menu',
        name: 'menu',
        type: 0,
        icon: 'Grid',
        meta: { title: "菜单管理" },
        component: () => Layout,
        children: [
          {
            path: '/menu',
            name: 'menu',
            type: 0,
            icon: 'Grid',
            meta: { title: "菜单管理" },
            component: () => import('@/views/system/Manu.vue')
          },
        ]
      },
      {
        path: '/org',
        name: 'org',
        type: 0,
        icon: 'QuestionFilled',
        meta: { title: "组织管理" },
        component: () => Layout,
        children: [
          {
            path: '/org',
            name: 'org',
            type: 0,
            icon: 'QuestionFilled',
            meta: { title: "组织管理" },
            component: () => import('@/views/system/Org.vue')
          }
        ]
      },
      {
        path: '/user',
        name: 'user',
        type: 0,
        icon: 'QuestionFilled',
        meta: { title: "用户管理" },
        component: () => Layout,
        children: [
          {
            path: '/user',
            name: 'user',
            type: 0,
            icon: 'QuestionFilled',
            meta: { title: "用户管理" },
            component: () => import('@/views/system/User.vue')
          }
        ]
      },
    ]
  },
]