package com.example.demo.domain.mapper;

import com.example.demo.domain.entity.Products;
import com.example.demo.domain.entity.SalesStats;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

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
    // Fetch top 10 products by sales volume with product details
    @Select("SELECT p.*, SUM(s.quantity_sold) as total_sold FROM sales_stats s " +
            "JOIN products p ON s.product_id = p.id " +
            "GROUP BY p.id ORDER BY total_sold DESC LIMIT 10")
    List<Products> selectTop10ProductsBySales();

    // Fetch bottom 10 products by sales volume with product details
    @Select("SELECT p.*, SUM(s.quantity_sold) as total_sold FROM sales_stats s " +
            "JOIN products p ON s.product_id = p.id " +
            "GROUP BY p.id ORDER BY total_sold ASC LIMIT 10")
    List<Products> selectBottom10ProductsBySales();

    // Fetch the best-selling product with product details
    @Select("SELECT p.*, SUM(s.quantity_sold) as total_sold FROM sales_stats s " +
            "JOIN products p ON s.product_id = p.id " +
            "GROUP BY p.id ORDER BY total_sold DESC LIMIT 1")
    Products selectBestSellingProduct();
}
