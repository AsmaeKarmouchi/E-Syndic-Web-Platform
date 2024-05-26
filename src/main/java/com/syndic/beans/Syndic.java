package com.syndic.beans;

public class Syndic {
    private int id;
    private String firstName;
    private String lastName;
    private String fulladdress;
    private String codepostal;
    private String phoneNumber;
    private String mail;
    private int userId;
    //-----------------------
    private String residenceName;
    private String residenceAddress;
    private String residenceType;
    private int residenceSize;
    private int apartmentCount;
    private int villaCount;
    private int gardenCount;
    private int poolCount;
    private int parkingCount;
    private int elevatorsCount;
    private boolean securitySystem;
    private double account;

    public Syndic() {
    }
    public Syndic(String fulladdress) {
        this.fulladdress = fulladdress;
    }

    public Syndic(int id , int userId){
        this.id = id;
        this.userId = userId;
    }
    // Constructeur avec tous les champs syndic
    public Syndic(int id, String firstName, String lastName, String fulladdress,String codepostal, String phoneNumber,String mail, int userId) {
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
        this.fulladdress = fulladdress;
        this.codepostal = codepostal;
        this.phoneNumber = phoneNumber;
        this.mail = mail;
        this.userId = userId;
    }

    public Syndic(int id, String firstName, String lastName, String fulladdress,String codepostal, String phoneNumber,String mail, int userId ,String residenceName) {
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
        this.fulladdress = fulladdress;
        this.codepostal = codepostal;
        this.phoneNumber = phoneNumber;
        this.mail = mail;
        this.userId = userId;
        this.residenceName = residenceName;
    }

    public Syndic(int id, String firstName, String lastName, String fullAddress, String codePostal, String phoneNumber, String mail, int userId,
                  String residenceName, String residenceAddress, String residenceType, int residenceSize, int apartmentCount, int villaCount,
                  int gardenCount, int poolCount, int parkingCount, int elevatorsCount, boolean securitySystem,double account) {
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
        this.fulladdress = fullAddress;
        this.codepostal = codePostal;
        this.phoneNumber = phoneNumber;
        this.mail = mail;
        this.userId = userId;
        this.residenceName = residenceName;
        this.residenceAddress = residenceAddress;
        this.residenceType = residenceType;
        this.residenceSize = residenceSize;
        this.apartmentCount = apartmentCount;
        this.villaCount = villaCount;
        this.gardenCount = gardenCount;
        this.poolCount = poolCount;
        this.parkingCount = parkingCount;
        this.elevatorsCount = elevatorsCount;
        this.securitySystem = securitySystem;
        this.account = account;
    }

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public String getFirstName() {
        return firstName;
    }
    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getFulladdress() {
        return fulladdress;
    }

    public void setFulladdress(String fulladdress) {
        this.fulladdress = fulladdress;
    }

    public String getCodepostal() {
        return codepostal;
    }

    public void setCodepostal(String codepostal) {
        this.codepostal = codepostal;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getMail() {
        return mail;
    }
    public void setMail(String mail) {
        this.mail=mail;
    }

    //--------
    public String getResidenceName() {
        return residenceName;
    }

    public void setResidenceName(String residenceName) {
        this.residenceName = residenceName;
    }

    public String getResidenceAddress() {
        return residenceAddress;
    }

    public void setResidenceAddress(String residenceAddress) {
        this.residenceAddress = residenceAddress;
    }

    public String getResidenceType() {
        return residenceType;
    }

    public void setResidenceType(String residenceType) {
        this.residenceType = residenceType;
    }

    public int getResidenceSize() {
        return residenceSize;
    }

    public void setResidenceSize(int residenceSize) {
        this.residenceSize = residenceSize;
    }

    public int getApartmentCount() {
        return apartmentCount;
    }

    public void setApartmentCount(int apartmentCount) {
        this.apartmentCount = apartmentCount;
    }

    public int getVillaCount() {
        return villaCount;
    }

    public void setVillaCount(int villaCount) {
        this.villaCount = villaCount;
    }

    public int getGardenCount() {
        return gardenCount;
    }

    public void setGardenCount(int gardenCount) {
        this.gardenCount = gardenCount;
    }

    public int getPoolCount() {
        return poolCount;
    }

    public void setPoolCount(int poolCount) {
        this.poolCount = poolCount;
    }

    public int getParkingCount() {
        return parkingCount;
    }

    public void setParkingCount(int parkingCount) {
        this.parkingCount = parkingCount;
    }

    public int getElevatorsCount() {
        return elevatorsCount;
    }

    public void setElevatorsCount(int elevatorsCount) {
        this.elevatorsCount = elevatorsCount;
    }

    public boolean isSecuritySystem() {
        return securitySystem;
    }

    public void setSecuritySystem(boolean securitySystem) {
        this.securitySystem = securitySystem;
    }

    // Getter and setter for account
    public double getAccount() {
        return account;
    }
    public void setAccount(int account) {
        this.account = account;
    }
}

