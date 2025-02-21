package com.example.demo.domain.controller;

import com.example.demo.common.Result;
import com.example.demo.domain.dto.ReviewWithUserDTO;
import com.example.demo.domain.entity.Reviews;
import com.example.demo.domain.service.IReviewsService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import java.util.List;

@RestController
@RequestMapping("/api/reviews")
@Api(tags = "评价管理")
public class ReviewsController {

    @Autowired
    private IReviewsService reviewsService;

    @PostMapping
    @ApiOperation(value = "添加评价", notes = "添加新的评价")
    public Result<String> addReview(@RequestBody Reviews review) {
        try {
            boolean isAdded = reviewsService.addReview(review);
            return isAdded ? Result.success("评价添加成功") : Result.error("评价添加失败");
        } catch (Exception e) {

            System.err.println("Exception while adding review: " + e.getMessage());
            return Result.error("服务器错误");
        }
    }

    @GetMapping
    @ApiOperation(value = "获取所有评价", notes = "获取所有评价列表")
    public Result<List<Reviews>> getAllReviews() {
        List<Reviews> reviewsList = reviewsService.getAllReviews();
        return Result.success(reviewsList);
    }

    @PutMapping("/{id}")
    @ApiOperation(value = "更新评价", notes = "根据ID更新评价信息")
    public Result<String> updateReview(@PathVariable Integer id, @RequestBody Reviews review) {
        review.setId(id);
        boolean isUpdated = reviewsService.updateReview(review);
        return isUpdated ? Result.success("评价更新成功") : Result.error("评价更新失败");
    }

    @DeleteMapping("/{id}")
    @ApiOperation(value = "删除评价", notes = "根据ID删除评价")
    public Result<String> deleteReview(@PathVariable Integer id) {
        boolean isDeleted = reviewsService.deleteReviewById(id);
        return isDeleted ? Result.success("评价删除成功") : Result.error("评价删除失败");
    }

    @GetMapping("/user/{userId}")
    @ApiOperation(value = "根据用户ID获取评价", notes = "获取指定用户的所有评价")
    public Result<List<Reviews>> getReviewsByUserId(@PathVariable Integer userId) {
        List<Reviews> reviewsList = reviewsService.getReviewsByUserId(userId);
        return Result.success(reviewsList);
    }

    @GetMapping("/product/{productId}")
    @ApiOperation(value = "根据商品ID获取评价", notes = "获取指定商品的所有评价")
    public Result<List<Reviews>> getReviewsByProductId(@PathVariable Integer productId) {
        List<Reviews> reviewsList = reviewsService.getReviewsByProductId(productId);
        return Result.success(reviewsList);
    }
    @GetMapping("/page")
    @ApiOperation(value = "获取评价分页列表", notes = "获取评价的分页列表")
    public Result<IPage<Reviews>> getReviewsPage(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size) {
        Page<Reviews> reviewPage = new Page<>(page, size);
        IPage<Reviews> reviewsPage = reviewsService.getReviewsPage(reviewPage);
        return Result.success(reviewsPage);
    }
    @GetMapping("/product/{productId}/page")
    @ApiOperation(value = "根据商品ID获取评价分页列表", notes = "获取指定商品的评价分页列表")
    public Result<IPage<Reviews>> getReviewsByProductIdPage(
            @PathVariable Integer productId,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size) {
        Page<Reviews> reviewPage = new Page<>(page, size);
        IPage<Reviews> reviewsPage = reviewsService.getReviewsByProductIdPage(reviewPage, productId);
        return Result.success(reviewsPage);
    }

    @GetMapping("/user/{userId}/page")
    @ApiOperation(value = "根据用户ID获取评价分页列表", notes = "获取指定用户的评价分页列表")
    public Result<IPage<Reviews>> getReviewsByUserIdPage(
            @PathVariable Integer userId,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size) {
        Page<Reviews> reviewPage = new Page<>(page, size);
        IPage<Reviews> reviewsPage = reviewsService.getReviewsByUserIdPage(reviewPage, userId);
        return Result.success(reviewsPage);
    }
    @GetMapping("/product/{productId}/with-user/page")
    @ApiOperation(value = "根据商品ID获取评价及用户信息分页列表", notes = "获取指定商品的评价及用户信息分页列表")
    public Result<IPage<ReviewWithUserDTO>> getReviewsWithUserByProductIdPage(
            @PathVariable Integer productId,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size) {
        Page<ReviewWithUserDTO> reviewPage = new Page<>(page, size);
        IPage<ReviewWithUserDTO> reviewsPage = reviewsService.getReviewsWithUserByProductIdPage(reviewPage, productId);
        return Result.success(reviewsPage);
    }
    @GetMapping("/latest")
    @ApiOperation(value = "获取最新的十条评价及用户信息", notes = "获取最新的十条评价及用户信息")
    public Result<List<ReviewWithUserDTO>> getLatestReviewsWithUser() {
        List<ReviewWithUserDTO> reviews = reviewsService.getLatestReviewsWithUser();
        return Result.success(reviews);
    }
}