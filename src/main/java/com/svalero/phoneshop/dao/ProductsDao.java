package com.svalero.phoneshop.dao;

import com.svalero.phoneshop.exception.ProductNotFoundException;
import com.svalero.phoneshop.model.Products;

import java.sql.SQLException;
import java.util.ArrayList;

public interface ProductsDao {
    boolean delete(int productsId) throws SQLException;

    boolean modify(Products products) throws SQLException;

    Products get(int id) throws SQLException, ProductNotFoundException;
    ArrayList<Products> getAll(String search) throws SQLException;

    ArrayList<Products> getNotOrdered() throws  SQLException;
    ArrayList<Products> getAll() throws SQLException;

    boolean add(Products products) throws SQLException;

}
