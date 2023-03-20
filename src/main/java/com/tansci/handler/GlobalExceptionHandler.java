package com.tansci.handler;

import cn.dev33.satoken.util.SaResult;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

/**
 * @ClassName： GlobalExceptionHandler.java
 * @ClassPath： com.tansci.handler.GlobalExceptionHandler.java
 * @Description： 全局异常拦截
 * @Author： tanyp
 * @Date： 2023/3/20 15:02
 **/
@RestControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler
    public SaResult handlerException(Exception e) {
        e.printStackTrace();
        return SaResult.error(e.getMessage());
    }

}
