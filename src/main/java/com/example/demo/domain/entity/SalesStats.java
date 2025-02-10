package com.example.demo.domain.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

/**
 * <p>
 * 
 * </p>
 *
 * @author 
 * @since 2025-01-19
 */
@TableName("sales_stats")
@ApiModel(value = "SalesStats对象", description = "")
public class SalesStats implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("销售统计ID")
      @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @ApiModelProperty("商品ID")
    private Integer productId;

    @ApiModelProperty("用户ID")
    private Integer userId;

    @ApiModelProperty("售出数量")
    private Integer quantitySold;

    @ApiModelProperty(" 总收入")
    private BigDecimal totalRevenue;

    @ApiModelProperty("售出时间  ")
    private LocalDateTime soldTime;


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getQuantitySold() {
        return quantitySold;
    }

    public void setQuantitySold(Integer quantitySold) {
        this.quantitySold = quantitySold;
    }

    public BigDecimal getTotalRevenue() {
        return totalRevenue;
    }

    public void setTotalRevenue(BigDecimal totalRevenue) {
        this.totalRevenue = totalRevenue;
    }

    public LocalDateTime getSoldTime() {
        return soldTime;
    }

    public void setSoldTime(LocalDateTime soldTime) {
        this.soldTime = soldTime;
    }

    @Override
    public String toString() {
        return "SalesStats{" +
        "id=" + id +
        ", productId=" + productId +
        ", userId=" + userId +
        ", quantitySold=" + quantitySold +
        ", totalRevenue=" + totalRevenue +
        ", soldTime=" + soldTime +
        "}";
    }
}
