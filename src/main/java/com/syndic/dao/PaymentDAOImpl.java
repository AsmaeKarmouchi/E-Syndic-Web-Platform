package com.syndic.dao;

import com.syndic.beans.Member;
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
              //  payment.setAccount_id(rs.getInt("payment_account_id"));
                payment.setMember_id(rs.getInt("payment_member_id"));
                payment.setStatus(rs.getString("payment_status"));

                payments.add(payment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return payments;
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

    @Override
    public List<Member> getMembersBySyndic(int syndicId) {
        List<Member> members = new ArrayList<>();
        String query = "SELECT * FROM members WHERE member_syndic_id = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, syndicId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Member member = new Member();
                    member.setId(rs.getInt("member_id"));
                    member.setFirstName(rs.getString("member_firstname"));
                    member.setLastName(rs.getString("member_lastname"));
                    // Assurez-vous de récupérer tous les champs nécessaires
                    members.add(member);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return members;
    }

    @Override
    public List<Payment> getPaymentsBySyndic(int syndicId) {
        List<Payment> payments = new ArrayList<>();
        String query = "SELECT * FROM payments WHERE payment_syndic_id = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, syndicId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Payment payment = new Payment();
                    payment.setCode(rs.getInt("payment_code"));
                    payment.setDate(rs.getString("payment_date"));
                    payment.setAmount(rs.getDouble("payment_amount"));
                    payment.setMethod(rs.getString("payment_method"));
                    payment.setType(rs.getString("payment_type"));
                  //  payment.setAccount_id(rs.getInt("payment_account_id"));
                    payment.setMember_id(rs.getInt("payment_member_id"));
                    payment.setStatus(rs.getString("payment_status"));
                    payment.setSyndicId(rs.getInt("payment_syndic_id"));
                    payments.add(payment);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return payments;}
    public boolean insertPayment(Payment payment) {
        String query = "INSERT INTO payments (payment_code, payment_date, payment_amount, payment_method, payment_type,  payment_member_id, payment_status, payment_syndic_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, payment.getCode());
            pstmt.setString(2, payment.getDate());
            pstmt.setDouble(3, payment.getAmount());
            pstmt.setString(4, payment.getMethod());
            pstmt.setString(5, payment.getType());
           // pstmt.setInt(6, payment.getAccount_id());
            pstmt.setInt(6, payment.getMember_id());
            pstmt.setString(7, payment.getStatus());
            pstmt.setInt(8, payment.getSyndicId());
            int rowsInserted = pstmt.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updatePayment(Payment payment) {
        String query = "UPDATE payments SET payment_date = ?, payment_amount = ?, payment_method = ?, payment_type = ?, payment_member_id = ?, payment_status = ? WHERE payment_code = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setString(1, payment.getDate());
            pstmt.setDouble(2, payment.getAmount());
            pstmt.setString(3, payment.getMethod());
            pstmt.setString(4, payment.getType());
          //  pstmt.setInt(5, payment.getAccount_id());
            pstmt.setInt(5, payment.getMember_id());
            pstmt.setString(6, payment.getStatus());
            pstmt.setInt(7, payment.getCode());
            int rowsUpdated = pstmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deletePayment(int code) {
        String query = "DELETE FROM payments WHERE payment_code = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, code);
            int rowsDeleted = pstmt.executeUpdate();
            return rowsDeleted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}


