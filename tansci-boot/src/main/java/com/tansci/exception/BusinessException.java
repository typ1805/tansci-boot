package com.tansci.exception;

import lombok.Getter;

/**
 * @ClassName： BusinessException.java
 * @ClassPath： com.tansci.exception.BusinessException.java
 * @Description： 业务异常处理
 * @Author： tanyp
 * @Date： 2023/3/20 15:31
 **/
@Getter
public class BusinessException extends RuntimeException {

    /**
     * 异常码
     */
    private int code = 500;

    /**
     * 异常描述
     */
    private String message;

    public BusinessException(String message) {
        super(message);
        this.message = message;
    }

    public BusinessException(int code, String message) {
        super(message);
        this.code = code;
        this.message = message;
    }

    public BusinessException(int code, String message, Throwable throwable) {
        super(message, throwable);
        this.code = code;
        this.message = message;
    }

}
