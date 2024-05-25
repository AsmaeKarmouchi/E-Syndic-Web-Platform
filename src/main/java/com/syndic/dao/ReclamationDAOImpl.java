package com.syndic.dao;

import com.syndic.beans.Reclamation;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class ReclamationDAOImpl implements ReclamationDAO {
    private Connection connection;

    public ReclamationDAOImpl(Connection connection) {
        this.connection = connection;
    }

    @Override
    public void ajouterReclamation(Reclamation reclamation) throws SQLException {
        String query = "INSERT INTO reclamations (sujet, description, date_soumission, id_user) VALUES (?, ?, ?, ?)";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, reclamation.getSujet());
            preparedStatement.setString(2, reclamation.getDescription());
            preparedStatement.setTimestamp(3, new java.sql.Timestamp(reclamation.getDateSoumission().getTime()));
            preparedStatement.setInt(4, reclamation.getIdUser());
            preparedStatement.executeUpdate();
        }
    }
}
