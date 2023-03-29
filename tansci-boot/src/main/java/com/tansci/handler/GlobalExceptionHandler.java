package com.tansci.handler;

import com.tansci.common.WrapMapper;
import com.tansci.common.Wrapper;
import com.tansci.common.exception.BusinessException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

/**
 * @ClassName： GlobalExceptionHandler.java
 * @ClassPath： com.tansci.handler.GlobalExceptionHandler.java
 * @Description： 全局异常拦截
 * @Author： tanyp
 * @Date： 2023/3/20 15:02
 **/
@Slf4j
@RestControllerAdvice
public class GlobalExceptionHandler {

//    @ExceptionHandler
//    public SaResult handlerException(Exception e) {
//        e.printStackTrace();
//        return SaResult.error(e.getMessage());
//    }

    @ExceptionHandler(value = Exception.class)
    public Wrapper handleException(Exception e) {
        if (e instanceof BusinessException) {
            BusinessException ex = (BusinessException) e;
            log.error("系统自定义业务异常：{}", ex.getMessage());
            return WrapMapper.wrap(ex.getCode(), ex.getMessage(), null);
        } else if (e instanceof MethodArgumentNotValidException) {
            MethodArgumentNotValidException ex = (MethodArgumentNotValidException) e;
            log.error("参数校验异常：{}", ex.getBindingResult().getFieldError().getDefaultMessage());
            return WrapMapper.wrap(Wrapper.ILLEGAL_ARGUMENT_CODE_, "参数有误：" + ex.getBindingResult().getFieldError().getDefaultMessage(), null);
        } else {
            log.error("统一系统异常：{}", e);
            return WrapMapper.wrap(Wrapper.ERROR_CODE, e.getMessage(), null);
        }
    }

}
