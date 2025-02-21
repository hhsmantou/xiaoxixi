package com.example.demo.domain.dto;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.example.demo.domain.entity.Products;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
public class SalesStatsProductDTO {
    @ApiModelProperty("商品ID")
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @ApiModelProperty(value = "商品名",required = true)
    private String name;

    @ApiModelProperty("商品型号")
    private String model;

    @ApiModelProperty("商品信息")
    private String info;

    @ApiModelProperty(value = "商品价钱",required = true)
    private BigDecimal price;

    @ApiModelProperty(value = "分类ID",required = true)
    private Integer category;

    @ApiModelProperty("商品图片")
    private String cover;

    @ApiModelProperty("库存量")
    private Integer inventory;

    @ApiModelProperty("商品创建时间")
    private LocalDateTime createTime;

    @ApiModelProperty("商品修改时间")
    private LocalDateTime updateTime;

    private Integer totalSold;
}
