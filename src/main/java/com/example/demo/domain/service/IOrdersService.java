package com.example.demo.domain.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.demo.domain.dto.OrderDetailsDTO;
import com.example.demo.domain.dto.OrderRequest;
import com.example.demo.domain.entity.OrderDetails;
import com.example.demo.domain.entity.Orders;
import com.baomidou.mybatisplus.extension.service.IService;
import com.example.demo.domain.entity.Products;

import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author 
 * @since 2025-01-19
 */
public interface IOrdersService extends IService<Orders> {
    boolean createOrder(OrderRequest orderRequest);
    List<Orders> getAllOrders();
    boolean updateOrder(Orders order);
    boolean deleteOrderById(Integer id);

    OrderRequest getOrderWithDetails(Integer orderId);

    List<OrderRequest> getOrdersWithDetailsByUserId(Integer userId);

    IPage<Orders> getOrdersPage(Page<Orders> page);
    IPage<Orders> getOrdersByStatusPage(Page<Orders> page, Integer status);

    IPage<OrderDetailsDTO> getOrderDetailsPage(Page<Orders> page);
}
