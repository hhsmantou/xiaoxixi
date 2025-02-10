package com.example.demo.domain.dto;

import com.example.demo.domain.entity.Products;
import com.example.demo.domain.entity.SalesStats;
import com.example.demo.domain.entity.Users;
import lombok.Data;

@Data
public class SalesDetailsDTO {
    private SalesStats salesStats;
    private Products product;
    private Users user;
    public SalesDetailsDTO(SalesStats salesStats, Products product, Users user) {
        this.salesStats = salesStats;
        this.product = product;
        this.user = user;
    }
}
