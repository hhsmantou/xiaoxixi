package com.example.demo.domain.service.impl;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.example.demo.domain.dto.OrderDetailsDTO;
import com.example.demo.domain.dto.OrderRequest;
import com.example.demo.domain.entity.Orders;
import com.example.demo.domain.entity.OrderDetails;
import com.example.demo.domain.entity.Products;
import com.example.demo.domain.entity.Users;
import com.example.demo.domain.mapper.OrdersMapper;
import com.example.demo.domain.mapper.OrderDetailsMapper;
import com.example.demo.domain.mapper.ProductsMapper;
import com.example.demo.domain.mapper.UsersMapper;
import com.example.demo.domain.service.IOrdersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.*;
import java.util.function.Function;
import java.util.stream.Collectors;

@Service
public  class OrdersServiceImpl extends ServiceImpl<OrdersMapper, Orders> implements IOrdersService {

    @Autowired
    private OrdersMapper ordersMapper;

    @Autowired
    private OrderDetailsMapper orderDetailsMapper;

    @Autowired
    private ProductsMapper productsMapper;

    @Autowired
    private UsersMapper usersMapper;

//    @Override
//    @Transactional(rollbackFor = Exception.class) // 事务回滚，确保数据一致性
//    public boolean createOrder(OrderRequest orderRequest) {
//        Orders order = orderRequest.getOrder();
//        List<OrderDetails> orderDetailsList = orderRequest.getOrderDetailsList();
//        order.setCreateTime(LocalDateTime.now());
//        if (orderDetailsList == null || orderDetailsList.isEmpty()) {
//            throw new IllegalArgumentException("订单详情不能为空");
//        }
//
//        BigDecimal totalPrice = BigDecimal.ZERO;
//        for (OrderDetails details : orderDetailsList) {
//            // 获取价格和数量，若为 null 则提供默认值
//            BigDecimal price = details.getPrice() != null ? details.getPrice() : BigDecimal.ZERO;  // 如果 price 为 null，使用 BigDecimal.ZERO
//            Integer quantity = details.getQuantity() != null ? details.getQuantity() : 0;  // 如果 quantity 为 null，使用 0
//
//            // 转换 quantity 为 BigDecimal 进行计算
//            BigDecimal quantityBD = BigDecimal.valueOf(quantity);
//            totalPrice = totalPrice.add(price.multiply(quantityBD));  // 计算总价并累加
//        }
//
//
//
//        order.setTotalPrice(totalPrice);
//
//        int orderResult = ordersMapper.insertOrder(order);
//        if (orderResult > 0) {
//            if (order.getId() == null) {
//                throw new IllegalStateException("订单插入失败，orderId 为空");
//            }
//
//            for (OrderDetails details : orderDetailsList) {
//                details.setOrderId(order.getId());
//                details.setCreateTime(LocalDateTime.now());
//                System.out.println("Inserting OrderDetails: " + details); // 调试数据
//                orderDetailsMapper.insertOrderDetails(details);
//            }
//            return true;
//        }
//        return false;
//    }
@Override
@Transactional(rollbackFor = Exception.class)
public boolean createOrder(OrderRequest orderRequest) {
    Orders order = orderRequest.getOrder();
    List<OrderDetails> orderDetailsList = orderRequest.getOrderDetailsList();
    order.setCreateTime(LocalDateTime.now());

    if (orderDetailsList == null || orderDetailsList.isEmpty()) {
        throw new IllegalArgumentException("订单详情不能为空");
    }

    BigDecimal totalPrice = BigDecimal.ZERO;
    for (OrderDetails details : orderDetailsList) {

        BigDecimal price = details.getPrice() != null ? details.getPrice() : BigDecimal.ZERO;
        Integer quantity = details.getQuantity() != null ? details.getQuantity() : 0;


        BigDecimal quantityBD = BigDecimal.valueOf(quantity);
        totalPrice = totalPrice.add(price.multiply(quantityBD));
    }


    Integer userId = order.getUserId();
    if (userId != null && isUserMember(userId)) {
        totalPrice = totalPrice.multiply(BigDecimal.valueOf(0.9));
    }

    order.setTotalPrice(totalPrice);
    boolean orderInserted = ordersMapper.insertOrder(order) > 0;

    if (!orderInserted) {
        throw new RuntimeException("订单创建失败");
    }

    for (OrderDetails details : orderDetailsList) {
        details.setOrderId(order.getId());
        boolean detailsInserted = orderDetailsMapper.insertOrderDetails(details) > 0;
        if (!detailsInserted) {
            throw new RuntimeException("订单详情创建失败");
        }
    }

    return true;
}

    // Helper method to check if a user is a member
    private boolean isUserMember(Integer userId) {
        Users user = usersMapper.selectById(userId);
        return user != null && user.getIsMember() == 1;
    }
    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean deleteOrderById(Integer id) {

        orderDetailsMapper.deleteOrderDetailsById(id);


        return ordersMapper.deleteOrderById(id) > 0;
    }

    @Override
    public List<Orders> getAllOrders() {
        return ordersMapper.selectAllOrders();
    }

    @Override
    public boolean updateOrder(Orders order) {
        return ordersMapper.updateOrder(order) > 0;
    }
    @Override
    public OrderRequest getOrderWithDetails(Integer orderId) {
        OrderRequest orderRequest = new OrderRequest();
        Orders order = ordersMapper.selectById(orderId);
        List<OrderDetails> orderDetailsList = orderDetailsMapper.getOrderDetailsByOrderId(orderId);
        orderRequest.setOrder(order);
        orderRequest.setOrderDetailsList(orderDetailsList);
        return orderRequest;
    }
    @Override
    public List<OrderRequest> getOrdersWithDetailsByUserId(Integer userId) {
        List<Orders> ordersList = ordersMapper.getOrdersByUserId(userId);
        List<OrderRequest> orderRequests = new ArrayList<>();

        for (Orders order : ordersList) {
            OrderRequest orderRequest = new OrderRequest(); // **每次循环都创建新对象**
            orderRequest.setOrder(order);
            List<OrderDetails> orderDetailsList = orderDetailsMapper.getOrderDetailsByOrderId(order.getId());
            orderRequest.setOrderDetailsList(orderDetailsList);
            orderRequests.add(orderRequest);
        }

        return orderRequests;
    }

    @Override
    public IPage<Orders> getOrdersPage(Page<Orders> page) {
        return ordersMapper.selectPage(page, null);
    }
    @Override
    public IPage<Orders> getOrdersByStatusPage(Page<Orders> page, Integer status) {
        return ordersMapper.selectOrdersByStatusPage(page, status);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public IPage<OrderDetailsDTO> getOrderDetailsPage(Page<Orders> page) {
        IPage<Orders> ordersPage = ordersMapper.selectPage(page, null);
        List<OrderDetailsDTO> orderDetailsList = ordersPage.getRecords().stream().map(order -> {
            List<OrderDetails> detailsList = orderDetailsMapper.getOrderDetailsByOrderId(order.getId());
            List<Products> products = detailsList.stream()
                    .map(detail -> productsMapper.selectById(detail.getProductId()))
                    .collect(Collectors.toList());
            return new OrderDetailsDTO(order, products);
        }).collect(Collectors.toList());

        Page<OrderDetailsDTO> orderDetailsDTOPage = new Page<>(page.getCurrent(), page.getSize(), ordersPage.getTotal());
        orderDetailsDTOPage.setRecords(orderDetailsList);
        return orderDetailsDTOPage;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public List<OrderDetailsDTO> getOrdersByStatusAndUserId(Integer status, Integer userId) {
        List<Orders> ordersList = ordersMapper.selectOrdersByStatusAndUserId(status, userId);
        return ordersList.stream().map(order -> {
            Products product = productsMapper.selectById(order.getProductId());
            return new OrderDetailsDTO(order, product);
        }).collect(Collectors.toList());
    }
}