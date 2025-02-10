package com.example.demo.domain.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
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
@ApiModel(value = "Products对象", description = "")
public class Products implements Serializable {

    private static final long serialVersionUID = 1L;

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


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public String getInfo() {
        return info;
    }

    public void setInfo(String info) {
        this.info = info;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public Integer getCategory() {
        return category;
    }

    public void setCategory(Integer category) {
        this.category = category;
    }

    public String getCover() {
        return cover;
    }

    public void setCover(String cover) {
        this.cover = cover;
    }

    public Integer getInventory() {
        return inventory;
    }

    public void setInventory(Integer inventory) {
        this.inventory = inventory;
    }

    public LocalDateTime getCreateTime() {
        return createTime;
    }

    public void setCreateTime(LocalDateTime createTime) {
        this.createTime = createTime;
    }

    public LocalDateTime getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(LocalDateTime updateTime) {
        this.updateTime = updateTime;
    }

    @Override
    public String toString() {
        return "Products{" +
        "id=" + id +
        ", name=" + name +
        ", model=" + model +
        ", info=" + info +
        ", price=" + price +
        ", category=" + category +
        ", cover=" + cover +
        ", inventory=" + inventory +
        ", createTime=" + createTime +
        ", updateTime=" + updateTime +
        "}";
    }
}
