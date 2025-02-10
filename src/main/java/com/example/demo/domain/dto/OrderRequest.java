package com.example.demo.domain.dto;

import com.example.demo.domain.entity.OrderDetails;
import com.example.demo.domain.entity.Orders;
import lombok.Data;

import java.util.List;
@Data
public class OrderRequest {
    private Orders order;
    private List<OrderDetails> orderDetailsList;


}
