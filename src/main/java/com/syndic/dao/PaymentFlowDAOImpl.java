package com.syndic.dao;

import com.syndic.beans.PaymentFlow;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

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

    @Override
    public List<PaymentFlow> getAllPaymentFlows() throws SQLException {
        List<PaymentFlow> paymentFlows = new ArrayList<>();
        String query = "SELECT id, syndic_id, flow_type, amount, description, transaction_date FROM payment_flows";

        try (PreparedStatement pstmt = connection.prepareStatement(query);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                PaymentFlow paymentFlow = new PaymentFlow();
                paymentFlow.setId(rs.getInt("id"));
                paymentFlow.setSyndicId(rs.getInt("syndic_id"));
                paymentFlow.setFlowType(rs.getInt("flow_type"));
                paymentFlow.setAmount(rs.getBigDecimal("amount").doubleValue());
                paymentFlow.setDescription(rs.getString("description"));
                paymentFlow.setTransactionDate(rs.getDate("transaction_date"));
                paymentFlows.add(paymentFlow);
            }
        }
        return paymentFlows;
    }
    @Override
    public List<PaymentFlow> getPaymentFlowsBySyndicId(int syndicId) throws SQLException {
        List<PaymentFlow> paymentFlows = new ArrayList<>();
        String query = "SELECT id, syndic_id, flow_type, amount, description, transaction_date FROM payment_flows WHERE syndic_id = ?";

        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, syndicId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    PaymentFlow paymentFlow = new PaymentFlow();
                    paymentFlow.setId(rs.getInt("id"));
                    paymentFlow.setSyndicId(rs.getInt("syndic_id"));
                    paymentFlow.setFlowType(rs.getInt("flow_type"));
                    paymentFlow.setAmount(rs.getBigDecimal("amount").doubleValue());
                    paymentFlow.setDescription(rs.getString("description"));
                    paymentFlow.setTransactionDate(rs.getDate("transaction_date"));
                    paymentFlows.add(paymentFlow);
                }
            }
        }
        return paymentFlows;
    }
}
