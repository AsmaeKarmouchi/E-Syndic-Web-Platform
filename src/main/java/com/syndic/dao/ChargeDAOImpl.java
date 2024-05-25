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




}
