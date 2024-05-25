package com.syndic.beans;

import java.math.BigDecimal;
import java.util.Date;

public class Expense {

    private int expenseId;
    private String expenseCode;
    private int expenseSupplierId;
    private BigDecimal expenseAmount;
    private String expenseCategory;
    private Date expensePaymentDate;
    private int expenseTaskOrCharge;
    private int expenseTaskId;
    private int expenseChargeId;

    // Constructors
    public Expense() {}

    public Expense(int expenseId, String expenseCode, int expenseSupplierId, BigDecimal expenseAmount, String expenseCategory, Date expensePaymentDate, int expenseTaskOrCharge, int expenseTaskId, int expenseChargeId) {
        this.expenseId = expenseId;
        this.expenseCode = expenseCode;
        this.expenseSupplierId = expenseSupplierId;
        this.expenseAmount = expenseAmount;
        this.expenseCategory = expenseCategory;
        this.expensePaymentDate = expensePaymentDate;
        this.expenseTaskOrCharge = expenseTaskOrCharge;
        this.expenseTaskId = expenseTaskId;
        this.expenseChargeId = expenseChargeId;
    }

    // Getters and Setters
    public int getExpenseId() {
        return expenseId;
    }

    public void setExpenseId(int expenseId) {
        this.expenseId = expenseId;
    }

    public String getExpenseCode() {
        return expenseCode;
    }

    public void setExpenseCode(String expenseCode) {
        this.expenseCode = expenseCode;
    }

    public int getExpenseSupplierId() {
        return expenseSupplierId;
    }

    public void setExpenseSupplierId(int expenseSupplierId) {
        this.expenseSupplierId = expenseSupplierId;
    }

    public BigDecimal getExpenseAmount() {
        return expenseAmount;
    }

    public void setExpenseAmount(BigDecimal expenseAmount) {
        this.expenseAmount = expenseAmount;
    }

    public String getExpenseCategory() {
        return expenseCategory;
    }

    public void setExpenseCategory(String expenseCategory) {
        this.expenseCategory = expenseCategory;
    }

    public Date getExpensePaymentDate() {
        return expensePaymentDate;
    }

    public void setExpensePaymentDate(Date expensePaymentDate) {
        this.expensePaymentDate = expensePaymentDate;
    }

    public int getExpenseTaskOrCharge() {
        return expenseTaskOrCharge;
    }

    public void setExpenseTaskOrCharge(int expenseTaskOrCharge) {
        this.expenseTaskOrCharge = expenseTaskOrCharge;
    }

    public int getExpenseTaskId() {
        return expenseTaskId;
    }

    public void setExpenseTaskId(int expenseTaskId) {
        this.expenseTaskId = expenseTaskId;
    }

    public int getExpenseChargeId() {
        return expenseChargeId;
    }

    public void setExpenseChargeId(int expenseChargeId) {
        this.expenseChargeId = expenseChargeId;
    }
}

