package com.syndic.dao;



import com.syndic.beans.Charge;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ChargeDAOImpl implements ChargeDAO {

    private final Connection connection;
    public ChargeDAOImpl(Connection connection) {
        this.connection = connection;
    }


    @Override
    public List<Charge> getChargesBySyndic(int syndicId) throws SQLException {
        List<Charge> charges = new ArrayList<>();
        String query = "SELECT * FROM charges WHERE charge_s_id = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, syndicId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Charge charge = new Charge();
                    charge.setChargesId(rs.getInt("charges_id"));
                    charge.setChargeName(rs.getString("charge_name"));
                    charge.setChargeDescription(rs.getString("charge_description"));
                    charge.setChargeAmount(rs.getDouble("charge_amount"));
                    charge.setChargeFrequency(rs.getString("charge_frequency"));
                    charge.setChargeCategory(rs.getString("charge_category"));
                    charge.setChargeSId(rs.getInt("charge_s_id"));
                    charge.setChargeDate(rs.getString("charge_date"));

                    charges.add(charge);
                }
            }
        }
        return charges;
    }
    @Override
    public List<Charge> getCharges() throws SQLException {
        List<Charge> charges = new ArrayList<>();
        String query = "SELECT * FROM charges ";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    int chargesId = resultSet.getInt("charges_id");
                    String chargeCode = resultSet.getString("charge_code");
                    String chargeName = resultSet.getString("charge_name");
                    String chargeDescription = resultSet.getString("charge_description");
                    Double chargeAmount = resultSet.getDouble("charge_amount");
                    String chargeFrequency = resultSet.getString("charge_frequency");
                    String chargeCategory = resultSet.getString("charge_category");
                    String chargeDueMonth = resultSet.getString("charge_due_month");

                    Charge charge = new Charge(chargesId, chargeCode, chargeName, chargeDescription, chargeAmount, chargeFrequency, chargeCategory, chargeDueMonth);
                    charges.add(charge);
                }
            }
        }
        return charges; // Retourner la liste de réunions
    }

    @Override
    public boolean insertCharge(Charge charge) throws SQLException {
        String query = "INSERT INTO charges (charge_name, charge_description, charge_amount, charge_frequency, charge_category, charge_s_id, charge_date) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setString(1, charge.getChargeName());
            pstmt.setString(2, charge.getChargeDescription());
            pstmt.setDouble(3, charge.getChargeAmount());
            pstmt.setString(4, charge.getChargeFrequency());
            pstmt.setString(5, charge.getChargeCategory());
            pstmt.setInt(6, charge.getChargeSId());
            pstmt.setString(7, charge.getChargeDate());

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        }
    }
    @Override
    public int getChargesCount() throws SQLException {
        String query = "SELECT COUNT(*) FROM charges";
        try (PreparedStatement pstmt = connection.prepareStatement(query);
             ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
            return 0;
        }
    }
    @Override
    public boolean deleteCharge(int chargesId) throws SQLException {
        String query = "DELETE FROM charges WHERE charges_id = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, chargesId);
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        }
    }


}
