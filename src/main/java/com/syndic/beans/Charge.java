package com.syndic.beans;

public class Charge {

    private int chargesId;
    private String chargeName;
    private String chargeDescription;
    private double chargeAmount;
    private String chargeFrequency;
    private String chargeCategory;
    private int chargeSId;
    private String chargeDate;


    // Constructors
    public Charge() {}



    public Charge(int chargesId, String chargeName, String chargeDescription, double chargeAmount, String chargeFrequency, String chargeCategory, int chargeSId, String chargeDate) {
        this.chargesId = chargesId;
        this.chargeName = chargeName;
        this.chargeDescription = chargeDescription;
        this.chargeAmount = chargeAmount;
        this.chargeFrequency = chargeFrequency;
        this.chargeCategory = chargeCategory;
        this.chargeSId = chargeSId;
        this.chargeDate = String.valueOf(chargeDate);
    }

    public Charge(int chargesId, String chargeCode, String chargeName, String chargeDescription, Double chargeAmount, String chargeFrequency, String chargeCategory, String chargeDueMonth) {
    }

    // Getters and Setters
    public int getChargesId() {
        return chargesId;
    }

    public void setChargesId(int chargesId) {
        this.chargesId = chargesId;
    }

    public String getChargeName() {
        return chargeName;
    }

    public void setChargeName(String chargeName) {
        this.chargeName = chargeName;
    }

    public String getChargeDescription() {
        return chargeDescription;
    }

    public void setChargeDescription(String chargeDescription) {
        this.chargeDescription = chargeDescription;
    }

    public double getChargeAmount() {
        return chargeAmount;
    }

    public void setChargeAmount(double chargeAmount) {
        this.chargeAmount = chargeAmount;
    }

    public String getChargeFrequency() {
        return chargeFrequency;
    }

    public void setChargeFrequency(String chargeFrequency) {
        this.chargeFrequency = chargeFrequency;
    }

    public String getChargeCategory() {
        return chargeCategory;
    }

    public void setChargeCategory(String chargeCategory) {
        this.chargeCategory = chargeCategory;
    }

    public int getChargeSId() {
        return chargeSId;
    }

    public void setChargeSId(int chargeSId) {
        this.chargeSId = chargeSId;
    }

    public String getChargeDate() {
        return chargeDate;
    }

    public void setChargeDate(String chargeDate) {
        this.chargeDate = chargeDate;
    }
}
