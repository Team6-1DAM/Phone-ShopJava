package com.svalero.phoneshop.model;

import lombok.Data;

import java.sql.Date;

@Data
public class Orders {

    private int id;
    private int id_product;
    private int id_user;
    private Date order_date;
    private double total_price;
    private String username;
    private String notes;

}
