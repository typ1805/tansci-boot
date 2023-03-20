package com.tansci.config;

import cn.dev33.satoken.interceptor.SaInterceptor;
import cn.dev33.satoken.stp.StpUtil;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * @ClassName： SaTokenConfig.java
 * @ClassPath： com.tansci.config.SaTokenConfig.java
 * @Description： 鉴权拦截器
 * @Author： tanyp
 * @Date： 2023/3/20 15:03
 **/
@Configuration
public class SaTokenConfig implements WebMvcConfigurer {

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        // 注册 Sa-Token 拦截器，打开注解式鉴权功能
        registry.addInterceptor(new SaInterceptor(handle -> StpUtil.checkLogin()))
                // 验证所有接口
                .addPathPatterns("/**")
                // 忽略校验
                .excludePathPatterns("/auth/**","/magic/**");
    }

}
