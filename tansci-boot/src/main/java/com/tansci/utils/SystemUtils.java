package com.tansci.utils;

import cn.hutool.core.net.Ipv4Util;
import cn.hutool.http.HttpUtil;
import cn.hutool.http.useragent.UserAgent;
import cn.hutool.http.useragent.UserAgentUtil;
import cn.hutool.json.JSONUtil;

import javax.servlet.http.HttpServletRequest;

/**
 * @ClassName： SystemUtils.java
 * @ClassPath： com.tansci.utils.SystemUtils.java
 * @Description： SystemUtils
 * @Author： tanyp
 * @Date： 2023/3/20 15:32
 **/
public class SystemUtils {

    /**
     * @MonthName： getOS
     * @Description： 获取操作系统名称
     * @Author： tanyp
     * @Date： 2022/6/1 15:30
     * @Param： [request]
     * @return： java.lang.String
     **/
    public static String getOS(HttpServletRequest request) {
        UserAgent userAgent = UserAgentUtil.parse(request.getHeaders("User-Agent").toString());
        return userAgent.getBrowser().toString();
    }

    /**
     * @MonthName： getBrowser
     * @Description： 获取浏览器名称
     * @Author： tanyp
     * @Date： 2022/6/1 15:29
     * @Param： [request]
     * @return： java.lang.String
     **/
    public static String getBrowser(HttpServletRequest request) {
        UserAgent userAgent = UserAgentUtil.parse(request.getHeaders("User-Agent").toString());
        return userAgent.getOs().toString();
    }

    /**
     * @methodName：getIp
     * @description：获取IP地址
     * @author：tanyp
     * @dateTime：2022/2/15 14:19
     * @Params： [request]
     * @Return： java.lang.String
     * @editNote：
     */
    public static String getIp(HttpServletRequest request) {

        String ip = request.getHeader("X-Forwarded-For");
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_X_FORWARDED_FOR");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_X_FORWARDED");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_X_CLUSTER_CLIENT_IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_CLIENT_IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_FORWARDED_FOR");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_FORWARDED");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_VIA");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("REMOTE_ADDR");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        if (ip.contains(",")) {
            return ip.split(",")[0];
        } else {
            return ip;
        }
    }

    /**
     * @MonthName： getAddress
     * @Description： 获取地址
     * @Author： tanyp
     * @Date： 2023/4/7 11:24
     * @Param： [ip]
     * @return： java.lang.String
     **/
    public static String getAddress(HttpServletRequest request) {
        String ip = getIp(request);
        try {
            if (Ipv4Util.isInnerIP(ip)) {
                return "内网IP";
            }
            return JSONUtil.parseObj(HttpUtil.get("https://whois.pconline.com.cn/ipJson.jsp?json=true&ip=" + ip)).getStr("addr");
        } catch (IllegalArgumentException e) {
            return "内网IP";
        } catch (Exception e) {
            return "未知";
        }
    }

}
