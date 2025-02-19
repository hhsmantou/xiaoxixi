package com.example.demo.domain.dto;

import lombok.Data;

import java.math.BigDecimal;
@Data
public class TotalSalesDTO {
    private Integer totalQuantitySold;
    private BigDecimal totalRevenue;
}
