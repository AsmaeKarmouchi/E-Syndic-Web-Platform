package com.syndic.beans;

public class Charge {

    private int chargesId;
    private String chargeCode;
    private String chargeName;
    private String chargeDescription;
    private double chargeAmount;
    private String chargeFrequency;
    private String chargeCategory;
    private String chargeDueMonth;

    // Constructors
    public Charge() {}

    public Charge(int chargesId, String chargeCode, String chargeName, String chargeDescription, double chargeAmount, String chargeFrequency, String chargeCategory, String chargeDueMonth) {
        this.chargesId = chargesId;
        this.chargeCode = chargeCode;
        this.chargeName = chargeName;
        this.chargeDescription = chargeDescription;
        this.chargeAmount = chargeAmount;
        this.chargeFrequency = chargeFrequency;
        this.chargeCategory = chargeCategory;
        this.chargeDueMonth = chargeDueMonth;
    }

    // Getters and Setters
    public int getChargesId() {
        return chargesId;
    }

    public void setChargesId(int chargesId) {
        this.chargesId = chargesId;
    }

    public String getChargeCode() {
        return chargeCode;
    }

    public void setChargeCode(String chargeCode) {
        this.chargeCode = chargeCode;
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

    public String getChargeDueMonth() {
        return chargeDueMonth;
    }

    public void setChargeDueMonth(String chargeDueMonth) {
        this.chargeDueMonth = chargeDueMonth;
    }
}

