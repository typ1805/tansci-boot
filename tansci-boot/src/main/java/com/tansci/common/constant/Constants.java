package com.tansci.common.constant;

/**
 * @ClassName： Constants.java
 * @ClassPath： com.tansci.common.constant.Constants.java
 * @Description： 常量
 * @Author： tanyp
 * @Date： 2023/3/20 17:02
 **/
public class Constants {

    /**
     * 删除状态：0、正常，1、删除
     */
    public final static Integer NOT_DEL_FALG = 0;
    public final static Integer IS_DEL_FALG = 1;

    /**
     * 用户是否禁用：0、正常，1、禁用
     */
    public final static Integer USER_IS_LOGIN_IN = 0;
    public final static Integer USER_IS_LOGIN_ON = 1;

    /**
     * 操作日志状态：0、成功，1、失败
     */
    public final static Integer OPER_LOG_STATUS_SUCCESS = 0;
    public final static Integer OPER_LOG_STATUS_ERROR = 1;

    /**
     * 接口操作类型
     */
    public final static String SELECT = "SELECT";
    public final static String INSERT = "INSERT";
    public final static String UPDATE = "INSERT";
    public final static String DELETE = "DELETE";

    /**
     * 权限校验
     */
    public final static String PERMISSION_KEY = "permission-session";
    /**
     * 角色校验
     */
    public final static String ROLE_KEY = "role-session";


}
