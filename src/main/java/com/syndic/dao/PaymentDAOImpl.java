package com.syndic.dao;

import com.syndic.beans.Payment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PaymentDAOImpl implements PaymentDAO {
    private final Connection connection;

    public PaymentDAOImpl(Connection connection) {
        this.connection = connection;
    }

    private static final String COUNT_PAYMENTS = "SELECT SUM(payment_amount) FROM  Payments ";


    public List<Payment> getAllPayments() {
        List<Payment> payments = new ArrayList<>();
        String sql = "SELECT * FROM Payments";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Payment payment = new Payment();
                payment.setCode(rs.getInt("payment_code"));
                payment.setDate(rs.getString("payment_date"));
                payment.setAmount(rs.getDouble("payment_amount"));
                payment.setMethod(rs.getString("payment_method"));
                payment.setType(rs.getString("payment_type"));
                payment.setAccount_id(rs.getInt("payment_account_id"));
                payment.setMember_id(rs.getInt("payment_member_id"));
                payment.setStatus(rs.getString("payment_status"));

                payments.add(payment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return payments;
    }



    @Override
    public boolean insertPayment(Payment payment) {
        String query = "INSERT INTO Payments (payment_code, payment_date, payment_amount, payment_method, payment_type, payment_account_id, payment_member_id, payment_status) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, payment.getCode());
            statement.setString(2, payment.getDate());
            statement.setDouble(3, payment.getAmount());
            statement.setString(4, payment.getMethod());
            statement.setString(5, payment.getType());
            statement.setInt(6, payment.getAccount_id());
            statement.setInt(7, payment.getMember_id());
            statement.setString(8, payment.getStatus());

            int rowsInserted = statement.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean updatePayment(Payment payment) {
        String query = "UPDATE Payments SET payment_date = ?, payment_amount = ?, payment_method = ?, payment_type = ?, payment_account_id = ?, payment_member_id = ?, payment_status = ? WHERE payment_code = ?";

        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, payment.getDate());
            statement.setDouble(2, payment.getAmount());
            statement.setString(3, payment.getMethod());
            statement.setString(4, payment.getType());
            statement.setInt(5, payment.getAccount_id());
            statement.setInt(6, payment.getMember_id());
            statement.setString(7, payment.getStatus());
            statement.setInt(8, payment.getCode());

            int rowsUpdated = statement.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean deletePayment(int code) {
        String query = "DELETE FROM Payments WHERE payment_code = ?";

        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, code);

            int rowsDeleted = statement.executeUpdate();
            return rowsDeleted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }


    public float getPaymentSum() throws SQLException {
        try (PreparedStatement preparedStatement = connection.prepareStatement(COUNT_PAYMENTS);
             ResultSet resultSet = preparedStatement.executeQuery()) {
            if (resultSet.next()) {
                return resultSet.getInt(1);
            }
            return 0;
        }
    }
}

