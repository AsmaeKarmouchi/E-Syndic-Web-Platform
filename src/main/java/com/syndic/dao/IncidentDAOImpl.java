package com.syndic.dao;



import com.syndic.beans.Incident;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
public class IncidentDAOImpl implements IncidentDAO {


    private static final String COUNT_INCIDENTS = "SELECT COUNT(*) FROM Incidents";
    private final Connection connection;


    public IncidentDAOImpl(Connection connection) {
        this.connection = connection;
    }

    @Override
    public void addIncident(Incident incident) throws SQLException {
        String query = "INSERT INTO incidents (incident_type, incident_description, incident_status,incident_s_id) " +
                "VALUES (?, ?, ?, ?)";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, incident.getIncidentType());
            preparedStatement.setString(2, incident.getIncidentDescription());
            preparedStatement.setString(3, incident.getIncidentStatus());
            preparedStatement.setInt(4, incident.getIncidentSId());
            preparedStatement.executeUpdate();
        }
    }

    @Override

    public List<Incident> getIncidentBySyndicId(int syndicId) throws SQLException {
        List<Incident> incidents = new ArrayList<>();
        String query = "SELECT * FROM incidents WHERE incident_s_id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, syndicId);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {

                    int incidentId = resultSet.getInt("incident_id");
                    Date incidentDate = resultSet.getDate("incident_date");
                    String incidentType = resultSet.getString("incident_type");
                    String incidentDescription = resultSet.getString("incident_description");
                    String incidentStatus = resultSet.getString("incident_status");
                    Date incidentResolutionDate = resultSet.getDate("incident_resolution_date");

                    Incident incident= new Incident(incidentId, incidentDate, incidentType, incidentDescription, incidentStatus, incidentResolutionDate, syndicId);
                    incidents.add(incident); // Ajouter la réunion à la liste
                }
            }
        }
        return incidents; // Retourner la liste de réunions
    }


    @Override
    public void updateIncident(int incidentId, String incidentStatus, Date incidentResolutionDate) throws SQLException {
        String query = "UPDATE incidents SET incident_status = ?, incident_resolution_date = ? WHERE incident_id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1,incidentStatus);
            preparedStatement.setDate(2, incidentResolutionDate);
            preparedStatement.setInt(3, incidentId);
            preparedStatement.executeUpdate();
        }
        }

    public int getIncidentCount() throws SQLException {
        try (PreparedStatement preparedStatement = connection.prepareStatement(COUNT_INCIDENTS);
             ResultSet resultSet = preparedStatement.executeQuery()) {
            if (resultSet.next()) {
                return resultSet.getInt(1);
            }
            return 0;
        }
    }

    public int getIncidentCountsyndic(int syndicid) throws SQLException {
        String COUNT_INCIDENTSSyndic = "SELECT COUNT(*) FROM Incidents WHERE incident_s_id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(COUNT_INCIDENTSSyndic)) {
            preparedStatement.setInt(1, syndicid);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    return resultSet.getInt(1);
                }
            }
        }
        return 0;
    }
}
