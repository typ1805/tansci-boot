package com.tansci.model;

import java.util.HashMap;
import java.util.Map;

/**
 * @ClassName： CodeCacheMap.java
 * @ClassPath： com.tansci.utils.CodeCacheMap.java
 * @Description： 验证码缓存
 * @Author： tanyp
 * @Date： 2023/3/20 15:34
 **/
public class CodeCacheMap {

    private static Map<String, String> map = new HashMap<String, String>();

    public static void put(String key, String value) {
        map.put(key, value);
    }

    public static void remove(String key) {
        map.remove(key);
    }

    public static String get(String key) {
        return map.get(key);
    }

}
