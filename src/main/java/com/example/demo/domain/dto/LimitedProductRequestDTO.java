package com.example.demo.domain.dto;

public class LimitedProductRequestDTO {
    private Integer productId;
    private Integer limitQuantity;
    private String limitTimeframe;

    // Getters and setters
    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }

    public Integer getLimitQuantity() {
        return limitQuantity;
    }

    public void setLimitQuantity(Integer limitQuantity) {
        this.limitQuantity = limitQuantity;
    }

    public String getLimitTimeframe() {
        return limitTimeframe;
    }

    public void setLimitTimeframe(String limitTimeframe) {
        this.limitTimeframe = limitTimeframe;
    }
}