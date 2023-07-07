package com.tansci.config;

import com.tansci.common.WrapMapper;
import org.springframework.stereotype.Component;
import org.ssssssss.magicapi.core.context.RequestEntity;
import org.ssssssss.magicapi.core.interceptor.ResultProvider;
import org.ssssssss.magicapi.modules.db.model.Page;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @ClassName： MagicAPIJsonConfig.java
 * @ClassPath： com.tansci.config.MagicAPIJsonConfig.java
 * @Description： 统一请求响应配置
 * @Author： tanyp
 * @Date： 2023/4/17 9:43
 **/
@Component
public class MagicAPIJsonConfig implements ResultProvider {

    /**
     * @MonthName： buildResult
     * @Description： 定义返回结果，默认返回JsonBean
     * @Author： tanyp
     * @Date： 2023/4/17 9:45
     * @Param： [requestEntity, i, s, o]
     * @return： java.lang.Object
     **/
    @Override
    public Object buildResult(RequestEntity requestEntity, int code, String message, Object data) {
        return WrapMapper.wrap(code, message, data);
    }

    /**
     * @MonthName： buildPageResult
     * @Description： 定义分页返回结果
     * @Author： tanyp
     * @Date： 2023/4/17 9:47
     * @Param： [requestEntity, page, total, data]
     * @return： java.lang.Object
     **/
    @Override
    public Object buildPageResult(RequestEntity requestEntity, Page page, long total, List<Map<String, Object>> data) {
        return new HashMap<String,Object>(){
            {
                put("total", total);
                put("pages", page.getOffset());
                put("size", page.getLimit());
                put("records", data);
            }
        };
    }

}
