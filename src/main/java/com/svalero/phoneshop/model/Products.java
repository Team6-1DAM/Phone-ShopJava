package com.svalero.phoneshop.model;

import lombok.Data;

import java.sql.Date;

@Data
public class Products {

    private int id;
    private int id_supplier;
    private String product_name;
    private String description;
    private double sale_price;
    private boolean stocks_units;
    private String image;
    private Date release_date;
    private String product_status;
}
