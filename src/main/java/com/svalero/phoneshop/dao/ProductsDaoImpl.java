package com.svalero.phoneshop.dao;

import com.svalero.phoneshop.exception.ProductNotFoundException;
import com.svalero.phoneshop.model.Products;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class ProductsDaoImpl implements ProductsDao{
    private Connection connection;

    public ProductsDaoImpl(Connection connection) {
        this.connection = connection;
    }

    @Override
    public boolean add(Products products) throws SQLException {
        String sql = "INSERT INTO products (id_supplier, product_name, description, sale_price, stocks_units, image, release_date, product_status) " +
                " VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement statement;

        statement = connection.prepareStatement(sql);
        statement.setInt(1, products.getId_supplier());
        statement.setString(2, products.getProduct_name());
        statement.setString(3, products.getDescription());
        statement.setDouble(4, products.getSale_price());
        statement.setBoolean(5, products.isStocks_units());
        statement.setString(6, products.getImage());
        statement.setDate(7, products.getRelease_date());
        statement.setString(8, products.getProduct_status());


        int affectedRows = statement.executeUpdate();

        return affectedRows != 0;
    }

    @Override
    public ArrayList<Products> getAll() throws SQLException {
        String sql = "SELECT * FROM products";
        return launchQuery(sql);
    }

    @Override
    public ArrayList<Products> getNotOrdered() throws  SQLException {
        String sql = "SELECT * FROM products WHERE id NOT IN (SELECT id_product FROM orders )";
        return launchQuery(sql);
    }

    @Override
    public ArrayList<Products> getAll(String search) throws SQLException {
        if (search == null || search.isEmpty()) {
            return getAll();
        }

        String sql = "SELECT * FROM products WHERE product_name LIKE ? OR description LIKE ?";
        return launchQuery(sql, search);
    }

    @Override
    public Products get(int id) throws SQLException, ProductNotFoundException {
        String sql = "SELECT * FROM products WHERE id = ?";
        PreparedStatement statement;
        ResultSet result;

        statement = connection.prepareStatement(sql);
        statement.setInt(1, id);
        result = statement.executeQuery();
        if (!result.next()) {
            throw new ProductNotFoundException();
        }

        Products product = new Products();
        product.setId(result.getInt("id"));
        product.setId_supplier(result.getInt("id_supplier"));
        product.setProduct_name(result.getString("product_name"));
        product.setDescription(result.getString("description"));
        product.setSale_price(result.getDouble("sale_price"));
        product.setStocks_units(result.getBoolean("stocks_units"));
        product.setImage(result.getString("image"));
        product.setRelease_date(result.getDate("release_date"));
        product.setProduct_status(result.getString("product_status"));

        System.out.println(product);
        System.out.println(product.getId());
        statement.close();

        return product;
    }

    @Override
    public boolean modify(Products products) throws SQLException{
        String sql = "UPDATE products SET id_supplier = ?, product_name = ?, description = ?, sale_price = ?, " +
                "stocks_units = ?, image = ?, release_date = ?, product_status = ? WHERE id = ?";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setInt(1, products.getId_supplier());
        statement.setString(2, products.getProduct_name());
        statement.setString(3, products.getDescription());
        statement.setDouble(4, products.getSale_price());
        statement.setBoolean(5, products.isStocks_units());
        statement.setString(6, products.getImage());
        statement.setDate(7, products.getRelease_date());
        statement.setString(8, products.getProduct_status());
        statement.setInt(9, products.getId());
        int affectedRows = statement.executeUpdate();

        return affectedRows != 0;
    }

    @Override
    public boolean delete(int productsId) throws SQLException {
        String sql = "DELETE FROM products WHERE id = ?";

        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setInt(1, productsId);
        int affectedRows = statement.executeUpdate();

        return affectedRows != 0;
    }

    private ArrayList<Products> launchQuery(String query, String... search) throws SQLException {
        PreparedStatement statement;
        ResultSet result;

        statement = connection.prepareStatement(query);
        if (search.length > 0) {
            statement.setString(1, "%" + search[0] + "%");
            statement.setString(2, "%" + search[0] + "%");
        }
        result = statement.executeQuery();
        ArrayList<Products> productsList = new ArrayList<>();
        while (result.next()) {
            Products products = new Products();
            products.setId(result.getInt("id"));
            products.setId_supplier(result.getInt("id_supplier"));
            products.setProduct_name(result.getString("product_name"));
            products.setDescription(result.getString("description"));
            products.setSale_price(result.getDouble("sale_price"));
            products.setStocks_units(result.getBoolean("stocks_units"));
            products.setImage(result.getString("image"));
            products.setRelease_date(result.getDate("release_date"));
            products.setProduct_status(result.getString("product_status"));
            productsList.add(products);
        }

        statement.close();

        return productsList;
    }
}
