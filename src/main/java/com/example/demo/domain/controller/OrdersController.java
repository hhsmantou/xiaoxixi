package com.example.demo.domain.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.demo.common.Result;
import com.example.demo.domain.dto.OrderDetailsDTO;
import com.example.demo.domain.dto.OrderRequest;
import com.example.demo.domain.entity.Orders;
import com.example.demo.domain.entity.OrderDetails;
import com.example.demo.domain.service.IOrdersService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/orders")
@Api(tags = "订单管理")
public class OrdersController {

    @Autowired
    private IOrdersService ordersService;

    @PostMapping
    @ApiOperation(value = "创建订单", notes = "创建新的订单")
    public Result<String> createOrder(@RequestBody OrderRequest orderRequest) {
        boolean isCreated = ordersService.createOrder(orderRequest);
        return isCreated ? Result.success("订单创建成功") : Result.error("订单创建失败");
    }

    @GetMapping
    @ApiOperation(value = "获取订单列表", notes = "获取所有订单")
    public Result<List<Orders>> getOrders() {
        List<Orders> ordersList = ordersService.getAllOrders();
        return Result.success(ordersList);
    }

    @PutMapping("/{id}")
    @ApiOperation(value = "更新订单", notes = "根据ID更新订单信息")
    public Result<String> updateOrder(@PathVariable Integer id, @RequestBody Orders order) {
        order.setId(id);
        boolean isUpdated = ordersService.updateOrder(order);
        return isUpdated ? Result.success("订单更新成功") : Result.error("订单更新失败");
    }

    @DeleteMapping("/{id}")
    @ApiOperation(value = "删除订单", notes = "根据ID删除订单")
    public Result<String> deleteOrder(@PathVariable Integer id) {
        boolean isDeleted = ordersService.deleteOrderById(id);
        return isDeleted ? Result.success("订单删除成功") : Result.error("订单删除失败");
    }
    @GetMapping("/{orderId}/details")
    @ApiOperation(value = "获取订单及其详情", notes = "根据订单ID获取订单及其详情")
    public Result<OrderRequest> getOrderWithDetails(@PathVariable Integer orderId) {
        OrderRequest orderRequest = ordersService.getOrderWithDetails(orderId);
        return Result.success(orderRequest);
    }

    @GetMapping("/user/{userId}")
    @ApiOperation(value = "获取用户的订单及其详情", notes = "根据用户ID获取订单及其详情")
    public Result<List<OrderRequest>> getOrdersWithDetailsByUserId(@PathVariable Integer userId) {
        List<OrderRequest> orderRequests = ordersService.getOrdersWithDetailsByUserId(userId);
        return Result.success(orderRequests);
    }
    @GetMapping("/page")
    @ApiOperation(value = "获取订单分页列表", notes = "获取订单的分页列表")
    public Result<IPage<Orders>> getOrdersPage(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size) {
        Page<Orders> orderPage = new Page<>(page, size);
        IPage<Orders> ordersPage = ordersService.getOrdersPage(orderPage);
        return Result.success(ordersPage);
    }

    @GetMapping("/status/{status}/page")
    @ApiOperation(value = "根据订单状态获取分页订单", notes = "根据订单状态获取分页订单列表")
    public Result<IPage<Orders>> getOrdersByStatusPage(
            @PathVariable Integer status,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size) {
        Page<Orders> orderPage = new Page<>(page, size);
        IPage<Orders> ordersPage = ordersService.getOrdersByStatusPage(orderPage, status);
        return Result.success(ordersPage);
    }
    @GetMapping("/details/page")
    @ApiOperation(value = "获取订单详细信息分页", notes = "获取订单及其相关的商品和用户信息的分页列表")
    public Result<IPage<OrderDetailsDTO>> getOrderDetailsPage(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size) {
        Page<Orders> orderPage = new Page<>(page, size);
        IPage<OrderDetailsDTO> orderDetails = ordersService.getOrderDetailsPage(orderPage);
        return Result.success(orderDetails);
    }
    @GetMapping("/status/{status}/user/{userId}/page")
    @ApiOperation(value = "根据订单状态和用户ID分页获取订单列表", notes = "根据订单状态和用户ID分页获取订单列表，并携带商品详情和用户信息")
    public Result<IPage<OrderDetailsDTO>> getOrdersByStatusAndUserId(
            @PathVariable Integer status,
            @PathVariable Integer userId,
            @RequestParam(defaultValue = "1") int pageNum,
            @RequestParam(defaultValue = "10") int pageSize) {
        Page<Orders> orderPage = new Page<>(pageNum, pageSize);
        IPage<OrderDetailsDTO> orders = ordersService.getOrdersByStatusAndUserId(orderPage, status, userId);
        return Result.success(orders);
    }
}