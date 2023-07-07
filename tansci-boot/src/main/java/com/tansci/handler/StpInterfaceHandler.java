package com.tansci.handler;

import cn.dev33.satoken.stp.StpUtil;
import cn.hutool.extra.servlet.ServletUtil;
import com.alibaba.fastjson2.JSON;
import com.tansci.common.WrapMapper;
import com.tansci.common.Wrapper;
import com.tansci.common.constant.Constants;
import com.tansci.utils.UUIDUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.annotation.Order;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.ssssssss.magicapi.core.context.RequestEntity;
import org.ssssssss.magicapi.core.interceptor.RequestInterceptor;
import org.ssssssss.magicapi.core.model.ApiInfo;
import org.ssssssss.magicapi.core.model.Options;
import org.ssssssss.magicapi.core.service.MagicAPIService;
import org.ssssssss.magicapi.core.servlet.MagicHttpServletRequest;
import org.ssssssss.magicapi.core.servlet.MagicHttpServletResponse;
import org.ssssssss.script.MagicScriptContext;

import javax.servlet.http.HttpServletRequest;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

/**
 * @ClassName： StpInterfaceHandler.java
 * @ClassPath： com.tansci.handler.StpInterfaceHandler.java
 * @Description： 自定义
 * @Author： tanyp
 * @Date： 2023/4/7 15:07
 **/
@Component
@Order(1)
public class StpInterfaceHandler implements RequestInterceptor, HandlerInterceptor {

    @Autowired
    MagicAPIService magicAPIService;

    @Autowired
    private JdbcTemplate template;

    @Override
    public Object preHandle(ApiInfo info, MagicScriptContext context, MagicHttpServletRequest request, MagicHttpServletResponse response) throws Exception {
        String requireLogin = Objects.toString(info.getOptionValue(Options.REQUIRE_LOGIN), "");
        if (requireLogin.equals("false")) {
            return null;
        }
        if (!StpUtil.isLogin()) {
            return WrapMapper.wrap(Wrapper.AUTHORIZATION_CODE, Wrapper.AUTHORIZATION_MESSAGE);
        } else {
            List<String> permissions = null;
            if (Objects.nonNull(StpUtil.getSession().get(Constants.PERMISSION_KEY))) {
                permissions = (List<String>) StpUtil.getSession().get(Constants.PERMISSION_KEY);
            } else {
                permissions = magicAPIService.execute("post", "/system/auth/permissions", new HashMap<String, Object>());
                StpUtil.getSession().set(Constants.PERMISSION_KEY, permissions);
            }

            String permission = Objects.toString(info.getOptionValue(Options.PERMISSION), "");
            if (StringUtils.isNotBlank(permission) && !permissions.contains(permission)) {
                return WrapMapper.wrap(Wrapper.FORBIDDEN_CODE, Wrapper.FORBIDDEN_MESSAGE);
            }
        }
        return null;
    }

    @Override
    public Object postHandle(RequestEntity requestEntity, Object returnValue) throws Exception {
        if (StpUtil.isLogin()) {
            try {
                HttpServletRequest request = requestEntity.getRequest().getRequest();
                ApiInfo info = requestEntity.getApiInfo();

                template.update("insert into sys_oper_log(id,method,type,message,req_param,res_param,take_up_time,user_id,status,uri,ip,version,create_time) values(?,?,?,?,?,?,?,?,?,?,?,?,?)",
                        UUIDUtils.getUUID(),
                        request.getMethod(),
                        request.getMethod(),
                        null,
                        JSON.toJSONString(converMap(request.getParameterMap())),
                        null,
                        System.currentTimeMillis() - requestEntity.getRequestTime(),
                        StpUtil.getLoginId(),
                        0,
                        request.getRequestURI(),
                        ServletUtil.getClientIP(request),
                        "2.0.0",
                        LocalDateTime.now()
                );
            } catch (Exception ignored) {
                ignored.printStackTrace();
            }
        }
        return null;
    }

    public Map<String, String> converMap(Map<String, String[]> paramMap) {
        Map<String, String> rtnMap = new HashMap<>();
        for (String key : paramMap.keySet()) {
            rtnMap.put(key, paramMap.get(key)[0]);
        }
        return rtnMap;
    }

}
