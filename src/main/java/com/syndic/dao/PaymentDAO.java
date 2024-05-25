package com.syndic.dao;

import com.syndic.beans.Payment;

import java.sql.SQLException;
import java.util.List;

public interface PaymentDAO {
    List<Payment> getAllPayments();

    boolean insertPayment(Payment payment);

    boolean updatePayment(Payment payment);

    boolean deletePayment(int code);

    float getPaymentSum() throws SQLException;
}
