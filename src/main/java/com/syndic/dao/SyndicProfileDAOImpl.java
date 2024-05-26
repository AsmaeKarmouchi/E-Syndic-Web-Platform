package com.syndic.dao;

import com.syndic.beans.Payment;
import com.syndic.beans.Syndic;
import com.syndic.beans.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class SyndicProfileDAOImpl implements SyndicProfileDAO {
    private final Connection connection;

    public SyndicProfileDAOImpl(Connection connection) {
        this.connection = connection;
    }

    @Override
    public void addSyndic(Syndic syndic) throws SQLException {

        String query = "INSERT INTO syndics (s_fulladdress, s_iduser , residence_name) VALUES (?, ?, ?)";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, syndic.getFulladdress());
            preparedStatement.setInt(2, syndic.getUserId());
            preparedStatement.setString(3, syndic.getResidenceName());
            preparedStatement.executeUpdate();
        }
    }

    @Override
    public void updateSyndic(Syndic syndic) throws SQLException {
        String query = "UPDATE syndics SET s_firstname = ?,   s_lastname = ?,    s_codepostal = ?,    s_phonenumber = ?,    s_fulladdress  = ?,   s_mail  = ? WHERE  s_iduser = ? ";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, syndic.getFirstName());
            preparedStatement.setString(2, syndic.getLastName());
            preparedStatement.setString(3, syndic.getCodepostal());
            preparedStatement.setString(4, syndic.getPhoneNumber());
            preparedStatement.setString(5, syndic.getFulladdress());
            preparedStatement.setString(6, syndic.getMail());
            preparedStatement.setInt(7, syndic.getUserId());
            preparedStatement.executeUpdate();
        }
    }

        @Override
        public void updateSyndic2(Syndic syndic) throws SQLException {
            String query = "UPDATE syndics SET s_firstname = ?, s_lastname = ?, s_codepostal = ?, s_phonenumber = ?, s_fulladdress = ?, s_mail = ?, residence_name = ?, residence_address = ?, residence_type = ?, residence_size = ?, apartment_count = ?, villa_count = ?, garden_count = ?, pool_count = ?, parking_count = ?, elevators_count = ?, security_system = ? , account = ? WHERE s_iduser = ?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                preparedStatement.setString(1, syndic.getFirstName());
                preparedStatement.setString(2, syndic.getLastName());
                preparedStatement.setString(3, syndic.getCodepostal());
                preparedStatement.setString(4, syndic.getPhoneNumber());
                preparedStatement.setString(5, syndic.getFulladdress());
                preparedStatement.setString(6, syndic.getMail());
                preparedStatement.setString(7, syndic.getResidenceName());
                preparedStatement.setString(8, syndic.getResidenceAddress());
                preparedStatement.setString(9, syndic.getResidenceType());
                preparedStatement.setInt(10, syndic.getResidenceSize());
                preparedStatement.setInt(11, syndic.getApartmentCount());
                preparedStatement.setInt(12, syndic.getVillaCount());
                preparedStatement.setInt(13, syndic.getGardenCount());
                preparedStatement.setInt(14, syndic.getPoolCount());
                preparedStatement.setInt(15, syndic.getParkingCount());
                preparedStatement.setInt(16, syndic.getElevatorsCount());
                preparedStatement.setBoolean(17, syndic.isSecuritySystem());
              //  preparedStatement.setInt(18, syndic.getUserId());
                preparedStatement.setDouble(18, syndic.getAccount());
                preparedStatement.executeUpdate();
            }
    }

    @Override
    public void updateSyndic3(Syndic syndic) throws SQLException {
        String query = "UPDATE syndics SET   account = ? WHERE s_iduser = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setDouble(1, syndic.getAccount());
            preparedStatement.setInt(2, syndic.getUserId());
            preparedStatement.executeUpdate();
        }
    }

    @Override
    public Syndic getSyndicByUserId(int userId) throws SQLException {
        String query = "SELECT * FROM syndics WHERE s_iduser = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, userId);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    int id = resultSet.getInt("s_id");
                    String firstName = resultSet.getString("s_firstname");
                    String lastName = resultSet.getString("s_lastname");
                    String fulladdress = resultSet.getString("s_fulladdress");
                    String codepostal = resultSet.getString("s_codepostal");
                    String phoneNumber = resultSet.getString("s_phonenumber");
                    String mail = resultSet.getString("s_mail");
                    String residenceName = resultSet.getString("residence_name");

                    return new Syndic(id, firstName, lastName, fulladdress, codepostal, phoneNumber, mail, userId, residenceName);
                }
            }
        }
        return null; // Retourne null si aucun synd n'est trouvé avec cet identifiant utilisateur.
    }
    @Override
    public int getSyndicIdByUserId(int userId) throws SQLException {
        String sql = "SELECT s_id FROM syndics WHERE s_iduser = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, userId);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return resultSet.getInt("s_id");
                } else {
                    throw new SQLException("Syndic not found for user id: " + userId);
                }
            }
        }
    }

    @Override
    public Syndic getSyndicByresidence(String residence) throws SQLException {
        String query = "SELECT s_id FROM syndics WHERE residence_name = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, residence);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    int id = resultSet.getInt("s_id");

                    Syndic syndic = new Syndic();
                    syndic.setId(id);
                    return  syndic ;
                }
            }
        }
        return null; // Retourne null si aucun synd n'est trouvé avec cet identifiant utilisateur.
    }

    public Syndic getSyndicById(int id) throws SQLException {
        String query = "SELECT * FROM syndics WHERE s_id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, id);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    Syndic syndic = new Syndic();

                    syndic.setId(resultSet.getInt("s_id"));
                    syndic.setFirstName(resultSet.getString("s_firstname"));
                    syndic.setLastName(resultSet.getString("s_lastname"));
                    syndic.setFulladdress(resultSet.getString("s_fulladdress"));
                    syndic.setCodepostal(resultSet.getString("s_codepostal"));
                    syndic.setPhoneNumber(resultSet.getString("s_phonenumber"));
                    syndic.setMail(resultSet.getString("s_mail"));
                    syndic.setUserId(resultSet.getInt("s_iduser"));

                    syndic.setResidenceName(resultSet.getString("residence_Name"));
                    syndic.setResidenceAddress(resultSet.getString("residence_Address"));
                    syndic.setResidenceType(resultSet.getString("residence_Type"));
                    syndic.setResidenceSize(resultSet.getInt("residence_Size"));
                    syndic.setApartmentCount(resultSet.getInt("apartment_Count"));
                    syndic.setVillaCount(resultSet.getInt("villa_Count"));
                    syndic.setGardenCount(resultSet.getInt("garden_Count"));
                    syndic.setPoolCount(resultSet.getInt("pool_Count"));
                    syndic.setParkingCount(resultSet.getInt("parking_Count"));
                    syndic.setElevatorsCount(resultSet.getInt("elevators_Count"));
                    syndic.setSecuritySystem(resultSet.getBoolean("security_System"));
                    syndic.setAccount(resultSet.getInt("account"));
                    return syndic;
                }
            }
        }
        return null; // Returns null if no syndic is found with the given ID.
    }


    public List<Syndic> getSyndic() throws SQLException {
        List<Syndic> syndics = new ArrayList<>();
        String query = "SELECT * FROM syndics";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Syndic syndic = new Syndic();

                    syndic.setId(resultSet.getInt("s_id"));
                    syndic.setFirstName(resultSet.getString("s_firstname"));
                    syndic.setLastName(resultSet.getString("s_lastname"));
                    syndic.setFulladdress(resultSet.getString("s_fulladdress"));
                    syndic.setCodepostal(resultSet.getString("s_codepostal"));
                    syndic.setPhoneNumber(resultSet.getString("s_phonenumber"));
                    syndic.setMail(resultSet.getString("s_mail"));
                    syndic.setUserId(resultSet.getInt("s_iduser"));

                    syndic.setResidenceName(resultSet.getString("residence_Name"));
                    syndic.setResidenceAddress(resultSet.getString("residence_Address"));
                    syndic.setResidenceType(resultSet.getString("residence_Type"));
                    syndic.setResidenceSize(resultSet.getInt("residence_Size"));
                    syndic.setApartmentCount(resultSet.getInt("apartment_Count"));
                    syndic.setVillaCount(resultSet.getInt("villa_Count"));
                    syndic.setGardenCount(resultSet.getInt("garden_Count"));
                    syndic.setPoolCount(resultSet.getInt("pool_Count"));
                    syndic.setParkingCount(resultSet.getInt("parking_Count"));
                    syndic.setElevatorsCount(resultSet.getInt("elevators_Count"));
                    syndic.setSecuritySystem(resultSet.getBoolean("security_System"));
                    syndic.setAccount(resultSet.getInt("account"));

                    syndics.add(syndic);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return syndics;
    }
    // Implémentation de la méthode getSyndicIdByResidence
    @Override
    public int getSyndicIdByResidence(String residence) throws SQLException {
        int syndicId = -1; // Valeur par défaut si aucun syndic correspondant n'est trouvé
        String query = "SELECT s_id FROM syndics WHERE residence_name = ?";

        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, residence);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    syndicId = resultSet.getInt("s_id");
                }
            }
        }
        return syndicId;
    }
}


