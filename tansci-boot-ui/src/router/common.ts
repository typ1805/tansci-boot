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
  }
]