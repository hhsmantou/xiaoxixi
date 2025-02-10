package com.example.demo.domain.dto;

import com.example.demo.domain.entity.Orders;
import com.example.demo.domain.entity.Products;
import com.example.demo.domain.entity.Users;
import lombok.Data;

@Data
public class OrderDetailsDTO {
    private Orders order;
    private Products product;
    private Users user;

    public OrderDetailsDTO(Orders order, Products product, Users user) {
        this.order = order;
        this.product = product;
        this.user = user;
    }
}
