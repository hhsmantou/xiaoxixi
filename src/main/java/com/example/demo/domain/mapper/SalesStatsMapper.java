package com.example.demo.domain.mapper;

import com.example.demo.domain.dto.SalesStatsDTO;
import com.example.demo.domain.dto.TotalSalesDTO;
import com.example.demo.domain.entity.Products;
import com.example.demo.domain.entity.SalesStats;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.springframework.data.repository.query.Param;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author 
 * @since 2025-01-19
 */
public interface SalesStatsMapper extends BaseMapper<SalesStats> {

    @Select("SELECT p.*, SUM(s.quantity_sold) as total_sold FROM sales_stats s " +
            "JOIN products p ON s.product_id = p.id " +
            "GROUP BY p.id ORDER BY total_sold DESC LIMIT 10")
    List<Products> selectTop10ProductsBySales();


    @Select("SELECT p.*, SUM(s.quantity_sold) as total_sold FROM sales_stats s " +
            "JOIN products p ON s.product_id = p.id " +
            "GROUP BY p.id ORDER BY total_sold ASC LIMIT 10")
    List<Products> selectBottom10ProductsBySales();


    @Select("SELECT p.*, SUM(s.quantity_sold) as total_sold FROM sales_stats s " +
            "JOIN products p ON s.product_id = p.id " +
            "GROUP BY p.id ORDER BY total_sold DESC LIMIT 1")
    Products selectBestSellingProduct();

    List<SalesStatsDTO> getSalesStatsByMonth(@Param("year") int year, @Param("month") int month);

    List<SalesStatsDTO> getSalesStatsByDay(@Param("date") String date);

    TotalSalesDTO getMonthlyTotalSales();
}
