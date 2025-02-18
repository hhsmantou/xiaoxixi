package com.example.demo.domain.dto;

import com.example.demo.domain.entity.Orders;
import com.example.demo.domain.entity.Products;
import com.example.demo.domain.entity.Users;
import lombok.Data;

import java.util.List;

@Data
public class OrderDetailsDTO {
    private Orders order;
    private Products product;
    private Users user;
    private List<Products> products;

    public OrderDetailsDTO(Orders order, Products product, Users user) {
        this.order = order;
        this.product = product;
        this.user = user;
    }

    public OrderDetailsDTO(Orders order, Products product) {
        this.order = order;
        this.product = product;
    }

    public OrderDetailsDTO(Orders order, List<Products> products) {
        this.order = order;
        this.products = products;
    }
    public OrderDetailsDTO(Orders order, Users user, List<Products> products) {
        this.order = order;
        this.user = user;
        this.products = products;
    }
}
