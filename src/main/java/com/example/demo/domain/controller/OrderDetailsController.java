package com.example.demo.domain.controller;

import com.example.demo.common.Result;
import com.example.demo.domain.entity.OrderDetails;
import com.example.demo.domain.service.IOrderDetailsService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/order-details")
@Api(tags = "订单详情管理")
public class OrderDetailsController {

    @Autowired
    private IOrderDetailsService orderDetailsService;

    @PostMapping
    @ApiOperation(value = "添加订单详情", notes = "添加新的订单详情")
    public Result<String> addOrderDetails(@RequestBody OrderDetails orderDetails) {
        boolean isAdded = orderDetailsService.addOrderDetails(orderDetails);
        return isAdded ? Result.success("订单详情添加成功") : Result.error("订单详情添加失败");
    }

    @GetMapping("/{orderId}")
    @ApiOperation(value = "获取订单详情列表", notes = "根据订单ID获取订单详情")
    public Result<List<OrderDetails>> getOrderDetailsByOrderId(@PathVariable Integer orderId) {
        List<OrderDetails> orderDetailsList = orderDetailsService.getOrderDetailsByOrderId(orderId);
        return Result.success(orderDetailsList);
    }

    @PutMapping("/{id}")
    @ApiOperation(value = "更新订单详情", notes = "根据ID更新订单详情信息")
    public Result<String> updateOrderDetails(@PathVariable Integer id, @RequestBody OrderDetails orderDetails) {
        orderDetails.setId(id);
        boolean isUpdated = orderDetailsService.updateOrderDetails(orderDetails);
        return isUpdated ? Result.success("订单详情更新成功") : Result.error("订单详情更新失败");
    }

    @DeleteMapping("/{id}")
    @ApiOperation(value = "删除订单详情", notes = "根据ID删除订单详情")
    public Result<String> deleteOrderDetails(@PathVariable Integer id) {
        boolean isDeleted = orderDetailsService.deleteOrderDetailsById(id);
        return isDeleted ? Result.success("订单详情删除成功") : Result.error("订单详情删除失败");
    }
}