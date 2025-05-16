package com.svalero.phoneshop.model;
import lombok.Data;

@Data
public class Supplier {

    private int id;
    private String supplier_name;
    private String tel;
    private String address;
    private String zip_code;
    private String city;
    private String country;
    private String website;
    private String email;
}
