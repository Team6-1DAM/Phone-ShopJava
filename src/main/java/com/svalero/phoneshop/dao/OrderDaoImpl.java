package com.svalero.phoneshop.dao;

import com.svalero.phoneshop.exception.OrderNotFoundException;
import com.svalero.phoneshop.model.Orders;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.ArrayList;
import java.sql.Date;


public class OrderDaoImpl implements OrderDao {

    private Connection connection;

    public OrderDaoImpl(Connection connection) {
        this.connection = connection;
    }


    @Override
    public Orders getById(int id) throws SQLException, OrderNotFoundException {
        String sql = "SELECT * FROM orders WHERE id = ?";

        PreparedStatement statement;
        ResultSet result;

        statement = connection.prepareStatement(sql);
        statement.setInt(1, id);
        result = statement.executeQuery();
        if (!result.next()) {
            throw new OrderNotFoundException();
        }

        Orders orders = new Orders();
        orders.setId(result.getInt("id"));
        orders.setId_user(result.getInt("id_user"));
        orders.setOrder_date(result.getDate("order_date"));
        orders.setTotal_price(result.getDouble("total_price"));
        orders.setUsername(result.getString("username"));
        orders.setNotes(result.getString("notes"));

        statement.close();

        return orders;

    }

    @Override
    public ArrayList<Orders> getAll() throws SQLException {
        String sql = "SELECT * FROM orders";
        return launchQuery(sql);
    }

    @Override
    public ArrayList<Orders> getAll(String search) throws SQLException {
        if (search == null || search.isEmpty()) {
            return getAll();
        }

        String sql = "SELECT o.* FROM orders o JOIN products p ON o.id = p.id WHERE p.name LIKE ? OR o.notes LIKE ?";
        return launchQuery(sql, search);
    }

    @Override
    public Orders getByUserId(int userId) throws SQLException, OrderNotFoundException {
        String sql = "SELECT * FROM orders WHERE id_user = ?";

        PreparedStatement statement;
        ResultSet result;

        statement = connection.prepareStatement(sql);
        statement.setInt(1, userId);
        result = statement.executeQuery();
        if (!result.next()) {
            throw new OrderNotFoundException();
        }

        Orders orders = new Orders();
        orders.setId(result.getInt("id"));
        orders.setId_product(result.getInt("id_product"));
        orders.setId_user(result.getInt("id_user"));
        orders.setOrder_date(result.getDate("order_date"));
        orders.setTotal_price(result.getDouble("total_price"));
        orders.setUsername(result.getString("username"));
        orders.setNotes(result.getString("notes"));

        statement.close();

        return orders;
    }

    @Override
    public int getOrdersByUserId(int userId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM orders WHERE id_user = ?";

        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, userId);

            try (ResultSet result = statement.executeQuery()) {
                if (result.next()) {
                    return result.getInt(1); // Get COUNT(*) value
                } else {
                    return 0; // No rows = count is 0
                }
            }
        }
    }


    @Override
    public Orders getByProductsId(int productId) throws SQLException, OrderNotFoundException {
        String sql = "SELECT * FROM orders WHERE id_product = ?";

        PreparedStatement statement;
        ResultSet result;

        statement = connection.prepareStatement(sql);
        statement.setInt(1, productId);
        result = statement.executeQuery();
        if (!result.next()) {
            throw new OrderNotFoundException();
        }

        Orders orders = new Orders();
        orders.setId(result.getInt("id"));
        orders.setId_product(result.getInt("id_product"));
        orders.setId_user(result.getInt("id_user"));
        orders.setOrder_date(result.getDate("order_date"));
        orders.setTotal_price(result.getDouble("total_price"));
        orders.setUsername(result.getString("username"));
        orders.setNotes(result.getString("notes"));

        statement.close();

        return orders;
    }

    @Override
    public Orders getByShelterId(int userId) throws SQLException, OrderNotFoundException {
        String sql = "SELECT * FROM orders WHERE id_user = ?";

        PreparedStatement statement;
        ResultSet result;

        statement = connection.prepareStatement(sql);
        statement.setInt(1, userId);
        result = statement.executeQuery();
        if (!result.next()) {
            throw new OrderNotFoundException();
        }

        Orders orders = new Orders();
        orders.setId(result.getInt("id"));
        orders.setId_product(result.getInt("id_product"));
        orders.setId_user(result.getInt("id_user"));
        orders.setOrder_date(result.getDate("order_date"));
        orders.setTotal_price(result.getDouble("total_price"));
        orders.setUsername(result.getString("username"));
        orders.setNotes(result.getString("notes"));

        statement.close();

        return orders;
    }

    @Override
    public Orders getByDateRange(Date startDate, Date endDate) throws SQLException, OrderNotFoundException {
        ArrayList<Orders> orderList = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE order_date BETWEEN ? AND ?";

        PreparedStatement statement;
        ResultSet result;

        statement = connection.prepareStatement(sql);
        statement.setDate(1, new java.sql.Date(startDate.getTime()));
        statement.setDate(2, new java.sql.Date(endDate.getTime()));
        result = statement.executeQuery();
        if (!result.next()) {
            throw new OrderNotFoundException();
        }

        Orders orders = new Orders();
        orders.setId(result.getInt("id"));
        orders.setId_product(result.getInt("id_product"));
        orders.setId_user(result.getInt("id_user"));
        orders.setOrder_date(result.getDate("order_date"));
        orders.setTotal_price(result.getDouble("total_price"));
        orders.setUsername(result.getString("username"));
        orders.setNotes(result.getString("notes"));

        statement.close();
        return orders;
    }

    @Override
    public boolean modify(Orders orders) throws SQLException {
        String sql = "UPDATE orders SET id_product = ?, id_user = ?, order_date = ?, total_price = ?, username = ?, " +
                "notes = ? WHERE id = ?";

        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setInt(1, orders.getId_product());
        statement.setInt(2, orders.getId_user());
        statement.setDate(3, orders.getOrder_date());
        statement.setDouble(4, orders.getTotal_price());
        statement.setString(5, orders.getUsername());
        statement.setString(6, orders.getNotes());
        statement.setInt(7, orders.getId());
        int affectedRows = statement.executeUpdate();

        return affectedRows != 0;
    }
    @Override
    public boolean delete(int ordersId) throws SQLException {
        String sql = "DELETE FROM orders WHERE id = ?";

        PreparedStatement statement;
        statement = connection.prepareStatement(sql);
        statement.setInt(1, ordersId);
        int affectedRows = statement.executeUpdate();

        return affectedRows != 0;
    }

    @Override
    public boolean add(Orders orders) throws SQLException {
        String sql = "INSERT INTO orders (id_product, id_user, order_date, total_price , username, notes) " +
                " VALUES (?, ?, ?, ?, ?, ?)";
        PreparedStatement statement;

        statement = connection.prepareStatement(sql);
        statement.setInt(1, orders.getId_product());
        statement.setInt(2, orders.getId_user());
        statement.setDate(3, orders.getOrder_date());
        statement.setDouble(4, orders.getTotal_price());
        statement.setString(5, orders.getUsername());
        statement.setString(6, orders.getNotes());


        int affectedRows = statement.executeUpdate();

        return affectedRows != 0;
    }


    private ArrayList<Orders> launchQuery(String query, String... search) throws SQLException {
        PreparedStatement statement;
        ResultSet result;

        statement = connection.prepareStatement(query);
        if (search.length > 0) {
            statement.setString(1, "%" + search[0] + "%");
            statement.setString(2, "%" + search[0] + "%");
        }
        result = statement.executeQuery();
        ArrayList<Orders> ordersList = new ArrayList<>();
        while (result.next()) {
            Orders orders = new Orders();
            orders.setId(result.getInt("id"));
            orders.setId_product(result.getInt("id_product"));
            orders.setId_user(result.getInt("id_user"));
            orders.setOrder_date(result.getDate("order_date"));
            orders.setTotal_price(result.getDouble("total_price"));
            orders.setUsername(result.getString("username"));
            orders.setNotes(result.getString("notes"));

            ordersList.add(orders);
        }

        statement.close();

        return ordersList;
    }
}
