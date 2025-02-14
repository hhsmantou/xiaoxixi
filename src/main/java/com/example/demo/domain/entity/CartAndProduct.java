package com.example.demo.domain.entity;

public class CartAndProduct extends Cart {
    private Products products;

    public Products getProducts() {
        return products;
    }

    public void setProducts(Products products) {
        this.products = products;
    }


}
