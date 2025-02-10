package com.example.demo.domain.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.demo.domain.dto.SalesDetailsDTO;
import com.example.demo.domain.entity.SalesStats;
import com.example.demo.domain.entity.Products;
import com.example.demo.domain.entity.Users;
import com.example.demo.domain.mapper.SalesStatsMapper;
import com.example.demo.domain.mapper.ProductsMapper;
import com.example.demo.domain.mapper.UsersMapper;
import com.example.demo.domain.service.ISalesStatsService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author 
 * @since 2025-01-19
 */
@Service
public class SalesStatsServiceImpl extends ServiceImpl<SalesStatsMapper, SalesStats> implements ISalesStatsService {
    @Autowired
    private SalesStatsMapper salesStatsMapper;

    @Autowired
    private ProductsMapper productsMapper;


    @Autowired
    private UsersMapper usersMapper;

    @Override
    public IPage<SalesDetailsDTO> getSalesDetailsPage(Page<SalesStats> page) {
        IPage<SalesStats> salesPage = salesStatsMapper.selectPage(page, null);
        List<SalesDetailsDTO> salesDetailsList = salesPage.getRecords().stream().map(sale -> {
            Products product = productsMapper.selectById(sale.getProductId());
            Users user = usersMapper.selectById(sale.getUserId());

            return new SalesDetailsDTO(sale, product, user);
        }).collect(Collectors.toList());

        return new Page<SalesDetailsDTO>(page.getCurrent(), page.getSize(), salesPage.getTotal())
                .setRecords(salesDetailsList);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean createSale(SalesStats salesStats) {
        // Insert sale record
        salesStats.setSoldTime(LocalDateTime.now());
        boolean saleInserted = salesStatsMapper.insert(salesStats) > 0;
        if (!saleInserted) {
            throw new RuntimeException("销售记录创建失败");
        }

        // Update product stock
        Products product = productsMapper.selectById(salesStats.getProductId());
        if (product != null) {
            int newStock = product.getInventory() - salesStats.getQuantitySold();
            if (newStock < 0) {
                throw new RuntimeException("库存不足");
            }
            product.setInventory(newStock);
            return productsMapper.updateById(product) > 0;
        }
        return false;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean updateSale(SalesStats salesStats) {

        return salesStatsMapper.updateById(salesStats) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean deleteSaleById(Integer id) {

        return salesStatsMapper.deleteById(id) > 0;
    }

    @Override
    public SalesStats getSaleById(Integer id) {

        return salesStatsMapper.selectById(id);
    }
    @Override
    public List<Products> getTop10ProductsBySales() {
        return salesStatsMapper.selectTop10ProductsBySales();
    }

    @Override
    public List<Products> getBottom10ProductsBySales() {
        return salesStatsMapper.selectBottom10ProductsBySales();
    }

    @Override
    public Products getBestSellingProduct() {
        return salesStatsMapper.selectBestSellingProduct();
    }
}
