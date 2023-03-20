package com.tansci.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * @ClassName： SysRole.java
 * @ClassPath： com.tansci.domain.SysRole.java
 * @Description： 权限
 * @Author： tanyp
 * @Date： 2023/03/20 10:38
 **/
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@TableName(value = "sys_role")
@ApiModel(value = "权限")
public class SysRole {

    @TableId(type = IdType.ASSIGN_UUID)
    @ApiModelProperty(value = "主键id")
    private String id;

    @ApiModelProperty(value = "角色名称")
    private String name;

    @ApiModelProperty(value = "状态：0、默认，1、启用，2、禁用")
    private Integer status;
    @TableField(exist = false)
    private String statusName;

    @ApiModelProperty(value = "创建人")
    private String creator;
    @TableField(exist = false)
    private String creatorName;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", locale = "zh", timezone = "GMT+8")
    @ApiModelProperty(value = "更新时间")
    private LocalDateTime updateTime;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", locale = "zh", timezone = "GMT+8")
    @ApiModelProperty(value = "创建时间")
    private LocalDateTime createTime;

    @ApiModelProperty(value = "描述")
    private String remarks;

}