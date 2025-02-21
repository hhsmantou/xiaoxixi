package com.example.demo.domain.service;

import com.example.demo.domain.dto.SalesStatsDTO;
import com.example.demo.domain.dto.SalesStatsProductDTO;
import com.example.demo.domain.dto.TotalSalesDTO;
import com.example.demo.domain.entity.SalesStats;
import com.baomidou.mybatisplus.extension.service.IService;
import com.example.demo.domain.dto.SalesDetailsDTO;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
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
public interface ISalesStatsService extends IService<SalesStats> {
    boolean createSale(SalesStats salesStats);
    boolean updateSale(SalesStats salesStats);
    boolean deleteSaleById(Integer id);
    SalesStats getSaleById(Integer id);

    IPage<SalesDetailsDTO> getSalesDetailsPage(Page<SalesStats> page);

    List<SalesStatsProductDTO> getTop10ProductsBySales();
    List<SalesStatsProductDTO> getBottom10ProductsBySales();
    SalesStatsProductDTO getBestSellingProduct();

    List<SalesStatsDTO> getSalesStatsByMonth(int year, int month);

    List<SalesStatsDTO> getSalesStatsByDay(String date);

    TotalSalesDTO getMonthlyTotalSales();
}
