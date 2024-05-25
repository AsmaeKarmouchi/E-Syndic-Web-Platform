package com.syndic.beans;

public class User {
    private int id_user;
    private String name;
    private String email;
    private String password;
    private int isAdmin;


    private String buildingNumber;


    // Constructeur par d�faut
    public User() {
    }

    public User(int idUser, String name) {
        this.id_user = idUser;
        this.name = name;
    }

    public User(int idUser) {
        this.id_user = idUser;

    }
    // Constructeur avec tous les champs
    public User(int idUser, String name, String email, String password , int isAdmin) {
        this.id_user = idUser;
        this.name = name;
        this.email = email;
        this.password = password;
        this.isAdmin = isAdmin;
    }

    public User(int idUser, String name, String email, String password , int isAdmin , String apartmentNumber , String buildingNumber,String phoneNumber ) {
        this.id_user = idUser;
        this.name = name;
        this.email = email;
        this.password = password;
        this.isAdmin = isAdmin;

    }

    public User(String email, String hashedPassword, int isAdmin) {
        this.email = email;
        this.password = hashedPassword;
        this.isAdmin = isAdmin;
    }

    public User(String name, String email, String password, int isAdmin) {
        this.name = name;
        this.email = email;
        this.password = password;
        this.isAdmin = isAdmin;
    }

    // Getters et setters
    public int getIdUser() {
        return id_user;
    }

    public void setIdUser(int idUser) {
        this.id_user = idUser;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getId_user() {
        return id_user;
    }

    public void setId_user(int id_user) {
        this.id_user = id_user;
    }

    public int getAdmin() {
        return isAdmin;
    }
    public void setAdmin(int isAdmin) {
        this.isAdmin = isAdmin;
    }


    // Getters and setters


    public String getBuildingNumber() {
        return buildingNumber;
    }

    public void setBuildingNumber(String buildingNumber) {
        this.buildingNumber = buildingNumber;
    }


    public void setApartmentNumber(String uApartmentNumber) {
    }
}
