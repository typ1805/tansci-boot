package com.tansci.domain.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

/**
 * @ClassName： SysUserSession.java
 * @ClassPath： com.tansci.domain.vo.SysUserSession.java
 * @Description： 用户session信息
 * @Author： tanyp
 * @Date： 2023/3/29 11:02
 **/
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ApiModel(value = "用户session信息")
public class SysUserSessionVo {

    @ApiModelProperty(value = "用户ID")
    private String id;

    @ApiModelProperty(value = "用户名称")
    private String username;

    @ApiModelProperty(value = "用户昵称")
    private String nickname;

    @ApiModelProperty(value = "用户类型：1、管理员，2、普通用户")
    private Integer type;

    @ApiModelProperty(value = "权限IDS")
    private List<String> roleIds;

}
