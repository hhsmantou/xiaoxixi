package com.example.demo.domain.service;

import com.example.demo.domain.entity.OrderDetails;
import java.util.List;

public interface IOrderDetailsService {
    boolean addOrderDetails(OrderDetails orderDetails);
    List<OrderDetails> getOrderDetailsByOrderId(Integer orderId);
    boolean updateOrderDetails(OrderDetails orderDetails);
    boolean deleteOrderDetailsById(Integer id);
}