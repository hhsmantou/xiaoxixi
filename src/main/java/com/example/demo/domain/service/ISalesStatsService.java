package com.example.demo.domain.service;

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

    List<Products> getTop10ProductsBySales();
    List<Products> getBottom10ProductsBySales();
    Products getBestSellingProduct();
}
