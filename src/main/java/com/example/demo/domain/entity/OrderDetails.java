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
@TableName("order_details")
@ApiModel(value = "OrderDetails对象", description = "")
public class OrderDetails implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("订单详情ID")
      @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @ApiModelProperty("订单ID")
    private Integer orderId;

    @ApiModelProperty("商品ID")
    private Integer productId;

    @ApiModelProperty("商品数量")
    private Integer quantity;

    @ApiModelProperty("商品单价")
    private BigDecimal price;

    @ApiModelProperty("创建时间")
    private LocalDateTime createTime;


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public LocalDateTime getCreateTime() {
        return createTime;
    }

    public void setCreateTime(LocalDateTime createTime) {
        this.createTime = createTime;
    }

    @Override
    public String toString() {
        return "OrderDetails{" +
        "id=" + id +
        ", orderId=" + orderId +
        ", productId=" + productId +
        ", quantity=" + quantity +
        ", price=" + price +
        ", createTime=" + createTime +
        "}";
    }
}
