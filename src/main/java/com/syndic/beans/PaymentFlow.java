package com.syndic.beans;

import java.util.Date;

public class PaymentFlow {
    private int id;
    private int syndicId;
    private int flowType;  // 0 for charge, 1 for payment
    private double amount;
    private String description;
    private Date transactionDate;

    // Getters and setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getSyndicId() {
        return syndicId;
    }

    public void setSyndicId(int syndicId) {
        this.syndicId = syndicId;
    }

    public int getFlowType() {
        return flowType;
    }

    public void setFlowType(int flowType) {
        this.flowType = flowType;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getTransactionDate() {
        return transactionDate;
    }

    public void setTransactionDate(Date transactionDate) {
        this.transactionDate = transactionDate;
    }
}
