package com.svalero.phoneshop.dao;

import com.svalero.phoneshop.exception.OrderNotFoundException;
import com.svalero.phoneshop.model.Orders;

import java.sql.SQLException;
import java.util.ArrayList;
import java.sql.Date;

public interface OrderDao {
    // Create
    boolean add(Orders orders) throws SQLException;

    // Read
    Orders getById(int id) throws SQLException, OrderNotFoundException;
    ArrayList<Orders> getAll() throws SQLException;
    ArrayList<Orders> getAll(String search) throws SQLException;
    int getOrdersByUserId(int userId) throws SQLException;

    // Update
    boolean modify(Orders orders) throws SQLException;
    // Delete
    boolean delete(int ordersId) throws SQLException;

}
