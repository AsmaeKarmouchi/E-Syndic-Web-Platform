package com.syndic.beans;

public class Supplier {
    private int supplier_id;
    private String supplier_name;
    private String supplier_email;
    private String supplier_phone;
   // private String supplier_type;
    private boolean supplier_active;
    private String supplier_rating;
    private int supplier_s_id;


    public Supplier() {
        super();
    }

    public int getSupplier_id() {
        return supplier_id;
    }

    public String getSupplier_email() {
        return supplier_email;
    }

    public String getSupplier_name() {
        return supplier_name;
    }

    public String getSupplier_phone() {
        return supplier_phone;
    }

    public String getSupplier_rating() {
        return supplier_rating;
    }

 //   public String getSupplier_type() {
    //      return supplier_type;
    //  }

    public int getSupplier_s_id() {
        return supplier_s_id;
    }

    public boolean isSupplier_active() {
        return supplier_active;
    }

    public void setSupplier_active(boolean supplier_active) {
        this.supplier_active = supplier_active;
    }

    public void setSupplier_email(String supplier_email) {
        this.supplier_email = supplier_email;
    }

    public void setSupplier_id(int supplier_id) {
        this.supplier_id = supplier_id;
    }

    public void setSupplier_name(String supplier_name) {
        this.supplier_name = supplier_name;
    }

    public void setSupplier_phone(String supplier_phone) {
        this.supplier_phone = supplier_phone;
    }

    public void setSupplier_rating(String supplier_rating) {
        this.supplier_rating = supplier_rating;
    }



    public void setSupplier_s_id(int supplier_s_id) {
        this.supplier_s_id = supplier_s_id;
    }

    //   public void setSupplier_type(String supplier_type) {
    //       this.supplier_type = supplier_type;
    //  }



}
