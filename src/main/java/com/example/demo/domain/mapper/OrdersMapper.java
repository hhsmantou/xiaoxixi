package com.example.demo.domain.mapper;


import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.demo.domain.entity.Orders;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectProvider;
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
@Mapper
public interface OrdersMapper extends BaseMapper<Orders> {
    @Options(useGeneratedKeys = true, keyProperty = "id")
    int insertOrder(Orders order);
    List<Orders> selectAllOrders();
    int updateOrder(Orders order);
    int deleteOrderById(@Param("id") Integer id);

    List<Orders> getOrdersByUserId(@Param("userId") Integer userId);

    @Select("SELECT * FROM orders WHERE status = #{status}")
    List<Orders> selectOrdersByStatus(@Param("status") Integer status);


    @Select("SELECT * FROM orders WHERE status = #{status}")
    IPage<Orders> selectOrdersByStatusPage(Page<Orders> page, @Param("status") Integer status);

    @Select("SELECT * FROM orders WHERE status = #{status} AND user_id = #{userId}")
    List<Orders> selectOrdersByStatusAndUserId(@Param("status") Integer status, @Param("userId") Integer userId);


    @Select("SELECT * FROM orders WHERE status = #{status} AND user_id = #{userId}")
    IPage<Orders> selectOrdersByStatusAndUserIdPage(Page<Orders> page, @Param("status") Integer status, @Param("userId") Integer userId);

    IPage<Orders> selectOrdersByUserIdAndStatus(Page<Orders> page, @Param("userId") Integer userId, @Param("status") Integer status);
}
