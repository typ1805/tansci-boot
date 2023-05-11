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
 * @ClassName： LcPages.java
 * @ClassPath： com.tansci.domain.LcPages.java
 * @Description： 页面管理
 * @Author： tanyp
 * @Date： 2023/5/11 8:47
 **/
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ApiModel(value = "页面管理")
@TableName(value = "lc_pages")
public class LcPages {

    @TableId(type = IdType.ASSIGN_UUID)
    @ApiModelProperty(value = "主键id")
    private String id;

    @ApiModelProperty(value = "标题")
    private String title;

    @ApiModelProperty(value = "副标题")
    private String subtitle;

    @ApiModelProperty(value = "父ID")
    private String parentId;

    @ApiModelProperty(value = "页面json")
    private String pageschema;

    @ApiModelProperty(value = "状态：0、正常，1、禁用")
    private Integer status;

    @ApiModelProperty(value = "创建人")
    private String creatorId;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", locale = "zh", timezone = "GMT+8")
    @ApiModelProperty(value = "更新时间")
    private LocalDateTime updateTime;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", locale = "zh", timezone = "GMT+8")
    @ApiModelProperty(value = "创建时间")
    private LocalDateTime createTime;

    @ApiModelProperty(value = "描述")
    private String remarks;

    @ApiModelProperty(value = "IDS")
    @TableField(exist = false)
    private List<String> ids;

    @ApiModelProperty(value = "菜单ids")
    @TableField(exist = false)
    private List<String> menuIds;

}
