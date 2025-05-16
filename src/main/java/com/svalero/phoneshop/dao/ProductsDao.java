package com.svalero.phoneshop.dao;

import com.svalero.phoneshop.exception.ProductNotFoundException;
import com.svalero.phoneshop.model.Products;

import java.sql.SQLException;
import java.util.ArrayList;

public interface ProductsDao {
    public boolean delete(int productsId) throws SQLException;

    public boolean modify(Products products) throws SQLException;

    public Products get(int id) throws SQLException, ProductNotFoundException;

    public ArrayList<Products> getAll(String search) throws SQLException;

    public ArrayList<Products> getNotOrdered() throws  SQLException;
    public ArrayList<Products> getAll() throws SQLException;

    public boolean add(Products products) throws SQLException;

}
