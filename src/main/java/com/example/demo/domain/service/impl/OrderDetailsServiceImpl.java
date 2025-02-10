package com.example.demo.domain.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.example.demo.domain.entity.OrderDetails;
import com.example.demo.domain.entity.Products;
import com.example.demo.domain.mapper.OrderDetailsMapper;
import com.example.demo.domain.mapper.ProductsMapper;
import com.example.demo.domain.service.IOrderDetailsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;

@Service
public class OrderDetailsServiceImpl implements IOrderDetailsService {

    @Autowired
    private OrderDetailsMapper orderDetailsMapper;

    @Override
    public boolean addOrderDetails(OrderDetails orderDetails) {
        return orderDetailsMapper.insertOrderDetails(orderDetails) > 0;
    }

    @Override
    public List<OrderDetails> getOrderDetailsByOrderId(Integer orderId) {
        return orderDetailsMapper.getOrderDetailsByOrderId(orderId);
    }



    @Override
    public boolean updateOrderDetails(OrderDetails orderDetails) {
        return orderDetailsMapper.updateOrderDetails(orderDetails) > 0;
    }

    @Override
    public boolean deleteOrderDetailsById(Integer id) {
        return orderDetailsMapper.deleteOrderDetailsById(id) > 0;
    }



}