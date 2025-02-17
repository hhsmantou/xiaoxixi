package com.example.demo.domain.mapper;

import com.baomidou.mybatisplus.extension.service.IService;
import com.example.demo.domain.entity.OrderDetails;
import com.example.demo.domain.entity.Products;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface OrderDetailsMapper extends IService<OrderDetails> {
    int insertOrderDetails(OrderDetails orderDetails);
    List<OrderDetails> getOrderDetailsByOrderId(@Param("orderId") Integer orderId);
    int updateOrderDetails(OrderDetails orderDetails);
    int deleteOrderDetailsById(@Param("id") Integer id);

}