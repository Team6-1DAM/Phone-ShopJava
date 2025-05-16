package com.svalero.phoneshop.model;

import lombok.Data;

import java.sql.Date;

@Data
public class User {

    private int id;
    private String name;
    private String email;
    private int phone;
    private String city;
    private Date birth_date;
    private String role;
    private String username;
    private String password;

}
