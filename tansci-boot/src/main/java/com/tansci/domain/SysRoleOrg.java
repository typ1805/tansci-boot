package com.tansci.domain;

import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @ClassName： SysRoleOrg.java
 * @ClassPath： com.tansci.domain.SysRoleOrg.java
 * @Description： 用户组织机构关联表
 * @Author： tanyp
 * @Date： 2023/03/20 10:38
 **/
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@TableName(value = "sys_role_org")
@ApiModel(value = "用户组织机构关联表")
public class SysRoleOrg {

    @ApiModelProperty(value = "角色id")
    private String roleId;

    @ApiModelProperty(value = "组织机构id")
    private String orgId;

}