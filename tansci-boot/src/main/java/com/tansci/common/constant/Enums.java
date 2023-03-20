package com.tansci.common.constant;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.Objects;

/**
 * @ClassName： Enums.java
 * @ClassPath： com.tansci.common.constant.Enums.java
 * @Description： 常用枚举
 * @Author： tanyp
 * @Date： 2023/3/20 15:25
 **/
@Getter
@NoArgsConstructor
@AllArgsConstructor
public enum Enums {
    /**
     * 用户性别
     */
    USER_GENDER_MALE(0, "user_gender", "男"),
    USER_GENDER_GIRL(1, "user_gender", "女"),

    /**
     * 用户类型
     */
    USER_TYPE_1(1, "user_type", "管理员"),
    USER_TYPE_2(2, "user_type", "商户"),

    ;

    private Integer key;
    private String group;
    private String value;


    public static String getVlaueByGroup(Integer key, String group) {
        for (Enums item : Enums.values()) {
            if (Objects.equals(key, item.key) && Objects.equals(group, item.group)) {
                return item.getValue();
            }
        }
        return null;
    }

}
