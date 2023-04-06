package com.tansci.domain.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;
import java.util.Map;

/**
 * @ClassName： SysMenuVo.java
 * @ClassPath： com.tansci.domain.SysMenuVo.java
 * @Description： 菜单
 * @Author： tanyp
 * @Date： 2023/03/20 10:38
 **/
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ApiModel(value = "菜单")
public class SysMenuVo {

    @ApiModelProperty(value = "主键id")
    private String id;

    @ApiModelProperty(value = "父菜单ID")
    private String parentId;

    @ApiModelProperty(value = "菜单名称")
    private String name;

    @ApiModelProperty(value = "菜单链接")
    private String path;

    @ApiModelProperty(value = "图标")
    private String icon;

    @ApiModelProperty(value = "排序")
    private Integer sort;

    @ApiModelProperty(value = "组件名称")
    private String component;

    @ApiModelProperty(value = "是否显示：0、不显示，1、显示")
    private Boolean isShow;

    @ApiModelProperty(value = "meta对象")
    private Map<String, Object> meta;

    @ApiModelProperty(value = "子级菜单")
    private List<SysMenuVo> children;

}