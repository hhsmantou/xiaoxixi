package com.example.demo.domain.dto;

import com.example.demo.domain.entity.Products;
import lombok.Data;

import java.math.BigDecimal;

@Data
public class SalesStatsDTO {
    private Integer productId;
    private String productName;
    private String model;
    private String info;
    private BigDecimal price;
    private Integer category;
    private String cover;
    private Integer inventory;
    private Integer quantitySold;
    private BigDecimal totalRevenue;
}
