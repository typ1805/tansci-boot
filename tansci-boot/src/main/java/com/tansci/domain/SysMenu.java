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
import java.util.List;

/**
 * @ClassName： SysMenu.java
 * @ClassPath： com.tansci.domain.SysMenu.java
 * @Description： 菜单
 * @Author： tanyp
 * @Date： 2023/03/20 10:38
 **/
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@TableName(value = "sys_menu")
@ApiModel(value = "菜单")
public class SysMenu {

    @TableId(type = IdType.ASSIGN_UUID)
    @ApiModelProperty(value = "主键id", hidden = true)
    private String id;

    @ApiModelProperty(value = "父菜单ID")
    private String parentId;

    @ApiModelProperty(value = "菜单名称")
    private String name;

    @ApiModelProperty(value = "菜单链接")
    private String url;

    @ApiModelProperty(value = "图标")
    private String icon;

    @ApiModelProperty(value = "中文名称")
    private String chineseName;

    @ApiModelProperty(value = "英文名称")
    private String englishName;

    @ApiModelProperty(value = "权限")
    private String permission;

    @ApiModelProperty(value = "排序")
    private Integer sort;

    @ApiModelProperty(value = "组件名称")
    private String component;

    @ApiModelProperty(value = "打开方式：0、默认，1、iframe，2、新标签页")
    private Integer openMode;

    @ApiModelProperty(value = "是否删除：0、未删除，1、已删除")
    private Integer isDel;

    @ApiModelProperty(value = "是否缓存：0、不缓存，1、缓存")
    private Integer keepAlive;

    @ApiModelProperty(value = "是否显示：0、不显示，1、显示")
    private Integer isShow;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", locale = "zh", timezone = "GMT+8")
    @ApiModelProperty(value = "更新时间")
    private LocalDateTime updateTime;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", locale = "zh", timezone = "GMT+8")
    @ApiModelProperty(value = "创建时间")
    private LocalDateTime createTime;

    @ApiModelProperty(value = "描述")
    private String remarks;

    @TableField(exist = false)
    @ApiModelProperty(value = "子级菜单")
    private List<SysMenu> children;

}