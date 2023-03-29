package com.tansci.domain.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * @ClassName： SysUserVo.java
 * @ClassPath： com.tansci.domain.vo.SysUserVo.java
 * @Description： 用户信息
 * @Author： tanyp
 * @Date： 2023/3/29 9:13
 **/
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ApiModel(value = "用户信息")
public class SysUserVo {

    @ApiModelProperty(value = "用户名称")
    private String username;

    @ApiModelProperty(value = "用户昵称")
    private String nickname;

    @ApiModelProperty(value = "用户类型：1、管理员，2、普通用户")
    private Integer type;

    @ApiModelProperty(value = "头像")
    private String avatar;

    @ApiModelProperty(value = "token")
    private String token;

    @ApiModelProperty(value = "登录时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", locale = "zh", timezone = "GMT+8")
    private LocalDateTime loginTime;

}
