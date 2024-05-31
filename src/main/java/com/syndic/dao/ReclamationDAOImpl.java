package com.syndic.dao;

import com.syndic.beans.Reclamation;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ReclamationDAOImpl implements ReclamationDAO {
    private Connection connection;

    public ReclamationDAOImpl(Connection connection) {
        this.connection = connection;
    }

    public int getReclamationCountsyndic(int syndicid) throws SQLException {
        String COUNT_ReclamationSyndic = "SELECT COUNT(*) FROM reclamations WHERE reclaim_s_id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(COUNT_ReclamationSyndic)) {
            preparedStatement.setInt(1, syndicid);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    return resultSet.getInt(1);
                }
            }
        }
        return 0;
    }

    public boolean insertReclaim(Reclamation reclaim) {
        String sql = "INSERT INTO reclamations (reclaim_date , reclaim_type, reclaim_description, reclaim_status, reclaim_resolution_date, reclaim_s_id, reclaim_m_id) VALUES (?, ?, ?, ?, ?, ? , ?)";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1,reclaim.getDate());
            statement.setString(2, reclaim.getReclaimType());
            statement.setString(3, reclaim.getReclaimDescription());
            statement.setString(4, reclaim.getReclaimStatus());
            statement.setString(5, reclaim.getReclaimResolutionDate());
            statement.setInt(6, reclaim.getReclaimSId());
            statement.setInt(7, reclaim.getReclaimMId());

            int rowsInserted = statement.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Reclamation> getAllReclamationsByMemberId(int memberId) {
        List<Reclamation> reclaims = new ArrayList<>();
        String sql = "SELECT * FROM reclamations WHERE reclaim_m_id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, memberId);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                Reclamation reclaim = new Reclamation();
                reclaim.setReclaimId(resultSet.getInt("reclaim_id"));
                reclaim.setDate(resultSet.getString("reclaim_date"));
                reclaim.setReclaimType(resultSet.getString("reclaim_type"));
                reclaim.setReclaimDescription(resultSet.getString("reclaim_description"));
                reclaim.setReclaimStatus(resultSet.getString("reclaim_status"));
                reclaim.setReclaimResolutionDate(resultSet.getString("reclaim_resolution_date"));
                reclaim.setReclaimSId(resultSet.getInt("reclaim_s_id"));
                reclaim.setReclaimMId(resultSet.getInt("reclaim_m_id"));
                reclaims.add(reclaim);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reclaims;
    }
}
