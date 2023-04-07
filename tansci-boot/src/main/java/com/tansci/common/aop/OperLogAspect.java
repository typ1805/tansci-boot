package com.tansci.common.aop;

import cn.dev33.satoken.stp.StpUtil;
import com.alibaba.fastjson2.JSON;
import com.tansci.common.annotation.Log;
import com.tansci.common.constant.Constants;
import com.tansci.domain.SysOperLog;
import com.tansci.domain.vo.SysUserSessionVo;
import com.tansci.service.SysOperLogService;
import com.tansci.utils.SystemUtils;
import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.*;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Method;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

/**
 * @ClassName： OperLogAspect.java
 * @ClassPath： com.tansci.common.aop.OperLogAspect.java
 * @Description： 操作日志记录
 * @Author： tanyp
 * @Date： 2023/4/7 14:02
 **/
@Slf4j
@Aspect
@Component
public class OperLogAspect {

    /**
     * 统计请求的处理时间
     */
    ThreadLocal<Long> startTime = new ThreadLocal<>();
    @Autowired
    private SysOperLogService sysOperLogService;

    /**
     * @MonthName： logPoinCut
     * @Description： 设置操作日志切入点 记录操作日志 在注解的位置切入代码
     * @Author： tanyp
     * @Date： 2023/4/7 14:06
     * @Param： []
     * @return： void
     **/
    @Pointcut("@annotation(com.tansci.common.annotation.Log)")
    public void logPoinCut() {
    }

    /**
     * @MonthName： exceptionLogPoinCut
     * @Description： 设置操作异常切入点记录异常日志 扫描所有controller包下操作
     * @Author： tanyp
     * @Date： 2023/4/7 14:07
     * @Param： []
     * @return： void
     **/
    @Pointcut("execution(* com.tansci.controller..*.*(..))")
    public void exceptionLogPoinCut() {
    }

    @Before("logPoinCut()")
    public void doBefore() {
        // 接收到请求，记录请求开始时间
        startTime.set(System.currentTimeMillis());
    }

    /**
     * @MonthName： doAfterReturning
     * @Description： 正常返回通知，拦截用户操作日志，连接点正常执行完成后执行， 如果连接点抛出异常，则不会执行
     * @Author： tanyp
     * @Date： 2023/4/7 14:08
     * @Param： [joinPoint, keys]
     * @return： void
     **/
    @AfterReturning(value = "logPoinCut()", returning = "keys")
    public void doAfterReturning(JoinPoint joinPoint, Object keys) {
        try {
            RequestAttributes requestAttributes = RequestContextHolder.getRequestAttributes();
            HttpServletRequest request = (HttpServletRequest) requestAttributes.resolveReference(RequestAttributes.REFERENCE_REQUEST);
            MethodSignature signature = (MethodSignature) joinPoint.getSignature();
            Method method = signature.getMethod();
            SysUserSessionVo sessionVo = (SysUserSessionVo) StpUtil.getSession().get(String.valueOf(StpUtil.getLoginId()));

            SysOperLog operLog = SysOperLog.builder()
                    .reqParam(JSON.toJSONString(converMap(request.getParameterMap())))
                    .resParam(JSON.toJSONString(keys))
                    .takeUpTime(System.currentTimeMillis() - startTime.get())
                    .userId(String.valueOf(StpUtil.getLoginId()))
                    .userName(sessionVo.getUsername())
                    .method(joinPoint.getTarget().getClass().getName() + "." + method.getName())
                    .uri(request.getRequestURI())
                    .ip(SystemUtils.getIp(request))
                    .status(Constants.OPER_LOG_STATUS_SUCCESS)
                    .createTime(LocalDateTime.now())
                    .build();

            Log log = method.getAnnotation(Log.class);
            if (Objects.nonNull(log)) {
                operLog.setModule(log.modul());
                operLog.setType(log.type());
                operLog.setMessage(log.desc());
            }

            sysOperLogService.save(operLog);
        } catch (Exception e) {
            log.error("记录操作日志异常：{}", e);
        }
    }

    /**
     * @MonthName： doAfterThrowing
     * @Description： 异常返回通知，用于拦截异常日志信息 连接点抛出异常后执行
     * @Author： tanyp
     * @Date： 2023/4/7 14:36
     * @Param： [joinPoint, e]
     * @return： void
     **/
    @AfterThrowing(pointcut = "exceptionLogPoinCut()", throwing = "e")
    public void doAfterThrowing(JoinPoint joinPoint, Throwable e) {
        try {
            RequestAttributes requestAttributes = RequestContextHolder.getRequestAttributes();
            HttpServletRequest request = (HttpServletRequest) requestAttributes.resolveReference(RequestAttributes.REFERENCE_REQUEST);
            MethodSignature signature = (MethodSignature) joinPoint.getSignature();
            Method method = signature.getMethod();
            SysUserSessionVo sessionVo = (SysUserSessionVo) StpUtil.getSession().get(String.valueOf(StpUtil.getLoginId()));

            SysOperLog operLog = SysOperLog.builder()
                    .reqParam(JSON.toJSONString(converMap(request.getParameterMap())))
                    .takeUpTime(System.currentTimeMillis() - startTime.get())
                    .userId(String.valueOf(StpUtil.getLoginId()))
                    .userName(sessionVo.getUsername())
                    .method(joinPoint.getTarget().getClass().getName() + "." + method.getName())
                    .uri(request.getRequestURI())
                    .ip(SystemUtils.getIp(request))
                    .status(Constants.OPER_LOG_STATUS_ERROR)
                    .unusual(stackTraceToString(e.getClass().getName(), e.getMessage(), e.getStackTrace()))
                    .createTime(LocalDateTime.now())
                    .build();

            Log log = method.getAnnotation(Log.class);
            if (Objects.nonNull(log)) {
                operLog.setModule(log.modul());
                operLog.setType(log.type());
                operLog.setMessage(log.desc());
            }

            sysOperLogService.save(operLog);
        } catch (Exception e2) {
            log.error("记录操作日志异常：{}", e2);
        }
    }

    public Map<String, String> converMap(Map<String, String[]> paramMap) {
        Map<String, String> rtnMap = new HashMap<>();
        for (String key : paramMap.keySet()) {
            rtnMap.put(key, paramMap.get(key)[0]);
        }
        return rtnMap;
    }

    public String stackTraceToString(String exceptionName, String exceptionMessage, StackTraceElement[] elements) {
        StringBuffer strbuff = new StringBuffer();
        for (StackTraceElement stet : elements) {
            strbuff.append(stet + "<br/>");
        }
        String message = exceptionName + ":" + exceptionMessage + "<br/>" + strbuff.toString();
        return message;
    }


}
