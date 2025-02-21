package com.example.demo.domain.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.demo.common.Result;
import com.example.demo.domain.dto.SalesDetailsDTO;
import com.example.demo.domain.dto.SalesStatsDTO;
import com.example.demo.domain.dto.SalesStatsProductDTO;
import com.example.demo.domain.dto.TotalSalesDTO;
import com.example.demo.domain.entity.Products;
import com.example.demo.domain.entity.SalesStats;
import com.example.demo.domain.service.ISalesStatsService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/sales")
@Api(tags = "销售管理")
public class SalesStatsController {

    @Autowired
    private ISalesStatsService salesStatsService;

    @PostMapping
    @ApiOperation(value = "创建销售记录", notes = "创建新的销售记录")
    public Result<String> createSale(@RequestBody SalesStats salesStats) {
        boolean isCreated = salesStatsService.createSale(salesStats);
        return isCreated ? Result.success("销售记录创建成功") : Result.error("销售记录创建失败");
    }

    @PutMapping("/{id}")
    @ApiOperation(value = "更新销售记录", notes = "根据ID更新销售记录")
    public Result<String> updateSale(@PathVariable Integer id, @RequestBody SalesStats salesStats) {
        salesStats.setId(id);
        boolean isUpdated = salesStatsService.updateSale(salesStats);
        return isUpdated ? Result.success("销售记录更新成功") : Result.error("销售记录更新失败");
    }

    @DeleteMapping("/{id}")
    @ApiOperation(value = "删除销售记录", notes = "根据ID删除销售记录")
    public Result<String> deleteSale(@PathVariable Integer id) {
        boolean isDeleted = salesStatsService.deleteSaleById(id);
        return isDeleted ? Result.success("销售记录删除成功") : Result.error("销售记录删除失败");
    }

    @GetMapping("/{id}")
    @ApiOperation(value = "获取销售记录", notes = "根据ID获取销售记录")
    public Result<SalesStats> getSaleById(@PathVariable Integer id) {
        SalesStats salesStats = salesStatsService.getSaleById(id);
        return Result.success(salesStats);
    }
    @GetMapping("/details/page")
    @ApiOperation(value = "获取销售详细信息分页", notes = "获取销售及其相关的商品和用户信息的分页列表")
    public Result<IPage<SalesDetailsDTO>> getSalesDetailsPage(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size) {
        Page<SalesStats> salesPage = new Page<>(page, size);
        IPage<SalesDetailsDTO> salesDetails = salesStatsService.getSalesDetailsPage(salesPage);
        return Result.success(salesDetails);
    }

    @GetMapping("/top10")
    @ApiOperation(value = "获取销售最多的前十个商品", notes = "获取销售最多的前十个商品及其详细信息")
    public Result<List<SalesStatsProductDTO>> getTop10ProductsBySales() {
        List<SalesStatsProductDTO> top10Products = salesStatsService.getTop10ProductsBySales();
        System.out.println(salesStatsService.getBottom10ProductsBySales());
        return Result.success(top10Products);
    }

    @GetMapping("/bottom10")
    @ApiOperation(value = "获取销售最少的后十个商品", notes = "获取销售最少的后十个商品及其详细信息")
    public Result<List<SalesStatsProductDTO>> getBottom10ProductsBySales() {
        List<SalesStatsProductDTO> bottom10Products = salesStatsService.getBottom10ProductsBySales();
        return Result.success(bottom10Products);
    }

    @GetMapping("/best-selling")
    @ApiOperation(value = "获取销售量最好的商品", notes = "获取销售量最好的商品及其详细信息")
    public Result<SalesStatsProductDTO> getBestSellingProduct() {
        SalesStatsProductDTO  bestSellingProduct = salesStatsService.getBestSellingProduct();
        return Result.success(bestSellingProduct);
    }



    @GetMapping("/stats/month/{year}/{month}")
    @ApiOperation(value = "获取指定月份销售统计", notes = "获取指定年份和月份的销售量和总收入")
    public Result<List<SalesStatsDTO>> getSalesStatsByMonth(@PathVariable int year, @PathVariable int month) {
        List<SalesStatsDTO> stats = salesStatsService.getSalesStatsByMonth(year, month);
        return Result.success(stats);
    }

    @GetMapping("/stats/day/{date}")
    @ApiOperation(value = "获取指定日期销售统计", notes = "获取指定日期的销售量和总收入")
    public Result<List<SalesStatsDTO>> getSalesStatsByDay(@PathVariable String date) {
        List<SalesStatsDTO> stats = salesStatsService.getSalesStatsByDay(date);
        return Result.success(stats);
    }

    @GetMapping("/stats/monthly-total")
    @ApiOperation(value = "获取本月销售总数和营业额", notes = "获取本月的销售总数和营业额")
    public Result<TotalSalesDTO> getMonthlyTotalSales() {
        TotalSalesDTO totalSales = salesStatsService.getMonthlyTotalSales();
        return Result.success(totalSales);
    }
}