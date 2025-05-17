package com.svalero.phoneshop.dao;

import com.svalero.phoneshop.exception.SupplierNotFoundException;
import com.svalero.phoneshop.model.Supplier;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


public class SupplierDaoImpl implements SupplierDao {
    private Connection connection;

    public SupplierDaoImpl(Connection connection) {
        this.connection = connection;
    }

    @Override
    public boolean add(Supplier supplier) throws SQLException {
        String sql = "INSERT INTO supplier (supplier_name, tel, address, zip_code ,city, country, website, email) " +
                " VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement statement;

        statement = connection.prepareStatement(sql);
        statement.setString(1, supplier.getSupplier_name());
        statement.setString(2, supplier.getTel());
        statement.setString(3, supplier.getAddress());
        statement.setString(4,  supplier.getZip_code());
        statement.setString(5, supplier.getCity());

        statement.setString(6, supplier.getCountry());
        statement.setString(7, supplier.getWebsite());
        statement.setString(8, supplier.getEmail());

        int affectedRows = statement.executeUpdate();

        return affectedRows != 0;
    }

    @Override
    public Supplier get(int id) throws SQLException, SupplierNotFoundException {
        String sql = "SELECT * FROM supplier WHERE id = ?";
        PreparedStatement statement;
        ResultSet result;

        statement = connection.prepareStatement(sql);
        statement.setInt(1, id);
        result = statement.executeQuery();
        if (!result.next()) {
            throw new SupplierNotFoundException();
        }

        Supplier supplier = new Supplier();
        supplier.setId(result.getInt("id"));
        supplier.setSupplier_name(result.getString("supplier_name"));
        supplier.setTel(result.getString("tel"));
        supplier.setCountry(result.getString("country"));
        supplier.setCity(result.getString("city"));
        supplier.setAddress(result.getString("address"));
        supplier.setZip_code(result.getString("zip_code"));
        supplier.setWebsite(result.getString("website"));
        supplier.setEmail(result.getString("email"));

        statement.close();

        return supplier;
    }

    @Override
    public ArrayList<Supplier> getAll(String search) throws SQLException {
        if (search == null || search.isEmpty()) {
            return getAll();
        }

        String sql = "SELECT * FROM supplier WHERE supplier_name LIKE ? OR city LIKE ?";
        return launchQuery(sql, search);
    }

    @Override
    public ArrayList<Supplier> getAll() throws SQLException {
        String sql = "SELECT * FROM supplier";
        return launchQuery(sql);
    }

    @Override
    public boolean modify(Supplier supplier) throws SQLException{
        String sql = "UPDATE supplier SET supplier_name = ?, tel = ?, address = ?, zip_code = ?, city = ?, country = ?, website = ?," +
                "email = ?  WHERE id = ?";
        PreparedStatement statement = connection.prepareStatement(sql);

        statement.setString(1, supplier.getSupplier_name());
        statement.setString(2, supplier.getTel());
        statement.setString(3, supplier.getAddress());
        statement.setString(4, supplier.getZip_code());
        statement.setString(5, supplier.getCity());
        statement.setString(6, supplier.getCountry());
        statement.setString(7, supplier.getWebsite());
        statement.setString(8, supplier.getEmail());
        statement.setInt(9, supplier.getId());


        int affectedRows = statement.executeUpdate();

        return affectedRows != 0;
    }

    @Override
    public boolean delete(int supplierId) throws SQLException {
        String sql = "DELETE FROM supplier WHERE id = ?";

        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setInt(1, supplierId);
        int affectedRows = statement.executeUpdate();

        return affectedRows != 0;
    }


    private ArrayList<Supplier> launchQuery(String query, String... search) throws SQLException {
        PreparedStatement statement;
        ResultSet result;

        statement = connection.prepareStatement(query);
        if (search.length > 0) {
            statement.setString(1, "%" + search[0] + "%");
            statement.setString(2, "%" + search[0] + "%");
        }
        result = statement.executeQuery();
        ArrayList<Supplier> shelterList = new ArrayList<>();
        while (result.next()) {
            Supplier supplier = new Supplier();
            supplier.setId(result.getInt("id"));
            supplier.setSupplier_name(result.getString("supplier_name"));
            supplier.setSupplier_name(result.getString("zip_code"));
            supplier.setAddress(result.getString("address"));
            supplier.setTel(result.getString("tel"));
            supplier.setCountry(result.getString("country"));
            supplier.setCity(result.getString("city"));
            supplier.setWebsite(result.getString("website"));
            supplier.setEmail(result.getString("email"));

            shelterList.add(supplier);
        }

        statement.close();

        return shelterList;
    }

}


