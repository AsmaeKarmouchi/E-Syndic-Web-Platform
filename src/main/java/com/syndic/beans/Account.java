// Account.java
package com.syndic.beans;

import java.math.BigDecimal;
import java.util.Date;

public class Account {
    private int accountId;
    private int accountNumber;
    private String accountType;
    private BigDecimal accountBalance;
    private Date accountCreatedAt;
    private int accountSyndicId;

    // Getters and setters
    public int getAccountId() {
        return accountId;
    }

    public void setAccountId(int accountId) {
        this.accountId = accountId;
    }

    public int getAccountNumber() {
        return accountNumber;
    }

    public void setAccountNumber(int accountNumber) {
        this.accountNumber = accountNumber;
    }

    public String getAccountType() {
        return accountType;
    }

    public void setAccountType(String accountType) {
        this.accountType = accountType;
    }

    public BigDecimal getAccountBalance() {
        return accountBalance;
    }

    public void setAccountBalance(BigDecimal accountBalance) {
        this.accountBalance = accountBalance;
    }

    public Date getAccountCreatedAt() {
        return accountCreatedAt;
    }

    public void setAccountCreatedAt(Date accountCreatedAt) {
        this.accountCreatedAt = accountCreatedAt;
    }

    public int getAccountSyndicId() {
        return accountSyndicId;
    }

    public void setAccountSyndicId(int accountSyndicId) {
        this.accountSyndicId = accountSyndicId;
    }
}
