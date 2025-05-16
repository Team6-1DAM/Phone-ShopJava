package com.svalero.phoneshop.dao;

import com.svalero.phoneshop.exception.SupplierNotFoundException;
import com.svalero.phoneshop.model.Supplier;

import java.sql.SQLException;
import java.util.ArrayList;

public interface SupplierDao {

    boolean add(Supplier supplier) throws SQLException;
    Supplier get(int id) throws SQLException, SupplierNotFoundException;
    ArrayList<Supplier> getAll(String search) throws SQLException;
    ArrayList<Supplier> getAll() throws SQLException;
    boolean modify(Supplier supplier) throws SQLException;
    boolean delete(int supplierId) throws SQLException;




}
