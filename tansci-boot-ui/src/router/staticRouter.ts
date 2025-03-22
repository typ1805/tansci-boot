export default[
  {
    path: '/',
    redirect: 'login',
  },
  {
    path: '/login',
    name: 'login',
    meta: {title: "登录"},
    component: () => import("@/views/common/Login.vue"),
  },
  {
    path: '/404',
    name: '404',
    meta: {title: "404"},
    component: () => import('@/views/common/404.vue')
  },
  {
    path: '/500',
    name: '500',
    meta: {title: "500"},
    component: () => import('@/views/common/500.vue') 
  },
  {
    path: '/index',
    name: 'index',
    icon: 'HomeFilled',
    meta: { title: "首页" },
    isShow: false,
    redirect: '/index/index',
    component: () => import("@/components/layout/Index.vue"),
    children: [
      {
        path: 'index',
        icon: 'HomeFilled',
        meta: { title: "首页" },
        isShow: false,
        component: () => import('@/views/Index.vue')
      }
    ]
  }
]