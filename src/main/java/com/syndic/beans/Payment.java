package com.syndic.beans;

public class Payment {
    private int code;
    private String date;
    private double amount;
    private String method;
    private String type;
    private int account_id;
    private int member_id;
    private String status;



    public Payment() {
        super();
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public int getAccount_id() {
        return account_id;
    }

    public void setAccount_id(int account_id) {
        this.account_id = account_id;
    }

    public int getMember_id() {
        return member_id;
    }

    public void setMember_id(int member_id) {
        this.member_id = member_id;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getMethod() {
        return method;
    }

    public void setMethod(String method) {
        this.method = method;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    @Override
    public String toString() {
        return "Payment{" +
                "code=" + code +
                ", date='" + date + '\'' +
                ", amount=" + amount +
                ", method='" + method + '\'' +
                ", type='" + type + '\'' + "," +
                " account_id=" + account_id +
                ", member_id=" + member_id +
                ", status='" + status + '\'' +
                '}';
    }
}
