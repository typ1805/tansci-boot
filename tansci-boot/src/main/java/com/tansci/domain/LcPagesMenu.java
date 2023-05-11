package com.tansci.domain;

import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @ClassName： LcPagesMenu.java
 * @ClassPath： com.tansci.domain.LcPagesMenu.java
 * @Description： 页面菜单关系表
 * @Author： tanyp
 * @Date： 2023/5/11 8:47
 **/
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ApiModel(value = "页面菜单关系")
@TableName(value = "lc_pages_menu")
public class LcPagesMenu {

    @ApiModelProperty(value = "页面id")
    private String pagesId;

    @ApiModelProperty(value = "菜单id")
    private String menuId;

}
