package com.tansci.utils;

import java.util.UUID;

/**
 * @ClassName： UUIDUtils.java
 * @ClassPath： com.tansci.utils.UUIDUtils.java
 * @Description： UUID工具类
 * @Author： tanyp
 * @Date： 2023/3/20 15:33
 **/
public class UUIDUtils {

    public static String getUUID() {
        return UUID.randomUUID().toString().replaceAll("-", "");
    }

    /**
     * @MonthName： getUUID
     * @Description： 自定义长度
     * @Author： tanyp
     * @Date： 2022/03/29 10:38
     * @Param： [len]
     * @return： java.lang.String
     **/
    public static String getUUID(Integer len) {
        return UUID.randomUUID().toString().replaceAll("-", "").substring(0, len);
    }

}
