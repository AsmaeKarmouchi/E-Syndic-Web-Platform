package com.syndic.dao;

import com.syndic.beans.PaymentFlow;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class PaymentFlowDAOImpl implements PaymentFlowDAO {
    private Connection connection;

    public PaymentFlowDAOImpl(Connection connection) {
        this.connection = connection;
    }
    @Override
    public void addPaymentFlow(PaymentFlow paymentFlow) throws SQLException {
        String query = "INSERT INTO payment_flows (syndic_id, flow_type, amount, description, transaction_date) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, paymentFlow.getSyndicId());
            pstmt.setInt(2, paymentFlow.getFlowType());
            pstmt.setBigDecimal(3, BigDecimal.valueOf(paymentFlow.getAmount()));
            pstmt.setString(4, paymentFlow.getDescription());
            pstmt.setDate(5, new java.sql.Date(paymentFlow.getTransactionDate().getTime()));
            pstmt.executeUpdate();
        }
    }
}
