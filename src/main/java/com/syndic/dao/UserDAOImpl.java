package com.syndic.dao;

import com.syndic.beans.User;
import com.syndic.connection.AbstractDAOA;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.mindrot.jbcrypt.BCrypt;

public class UserDAOImpl extends AbstractDAOA implements UserDAO {

    private static final String SELECT_USER_BY_ID = "SELECT * FROM users WHERE id=?";
    private static final String SELECT_USER_BY_EMAIL = "SELECT * FROM users WHERE u_email=?";
    private static final String INSERT_USER = "INSERT INTO users (u_name, u_email, u_pwd,checkadmin) VALUES (?, ?, ?,0)";
    private static final String INSERT_SYNDIC = "INSERT INTO users (u_name, u_email, u_pwd,checkadmin) VALUES (?, ?, ?,2)";

    private static final String UPDATE_USER = "UPDATE users SET u_name=?, u_email=?, u_pwd=? WHERE id=?";
    private static final String DELETE_USER = "DELETE FROM users WHERE id=?";
    private static final String LOGIN_USER = "SELECT * FROM users WHERE u_email=? ";

    private static final String COUNT_USERS = "SELECT COUNT(*) FROM users";

    private final Connection connection;

    public UserDAOImpl(Connection connection) {
        this.connection = connection;
    }



    @Override
    public User getUserById(int userId) {
        User user = null;

        try (PreparedStatement preparedStatement = connection.prepareStatement(SELECT_USER_BY_ID)) {
            preparedStatement.setInt(1, userId);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                user = extractUserFromResultSet(resultSet);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return user;
    }

    @Override
    public User getUserByEmail(String email) {
        User user = null;
        System.out.println("DOAIMPL!!"+connection);
        try (PreparedStatement preparedStatement = connection.prepareStatement(SELECT_USER_BY_EMAIL)) {
            preparedStatement.setString(1, email);
            System.out.println("DOAIMPL!!"+email+"..");
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                user = extractUserFromResultSet(resultSet);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return user;
    }



    @Override
    public User login(String email, String password) {
        User user = null;
        System.out.println("DOAIMPLlogin!!"+connection);
        try (PreparedStatement preparedStatement = connection.prepareStatement(LOGIN_USER)) {
            preparedStatement.setString(1, email);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                String hashedPasswordFromDB = resultSet.getString("u_pwd");
                if (BCrypt.checkpw(password, hashedPasswordFromDB)) {
                    user = extractUserFromResultSet(resultSet);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return user;
    }

    @Override
    public void createUser(User user) {
        try (PreparedStatement preparedStatement = connection.prepareStatement(INSERT_USER)) {
            preparedStatement.setString(1, user.getName());
            preparedStatement.setString(2, user.getEmail());
            preparedStatement.setString(3, user.getPassword());

            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void createSyndic(User user) {
        try (PreparedStatement preparedStatement = connection.prepareStatement(INSERT_SYNDIC)) {
            preparedStatement.setString(1, user.getName());
            preparedStatement.setString(2, user.getEmail());
            preparedStatement.setString(3, user.getPassword());

            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    @Override
    public void updateUser(User utilisateur) {
        try (PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_USER)) {
            preparedStatement.setString(1, utilisateur.getName());
            preparedStatement.setString(2, utilisateur.getEmail());
            preparedStatement.setString(3, utilisateur.getPassword());
            preparedStatement.setInt(4, utilisateur.getIdUser());

            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteUser(int userId) {
        try (PreparedStatement preparedStatement = connection.prepareStatement(DELETE_USER)) {
            preparedStatement.setInt(1, userId);

            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private User extractUserFromResultSet(ResultSet resultSet) throws SQLException {
        int id = resultSet.getInt("id");
        String name = resultSet.getString("u_name");
        String email = resultSet.getString("u_email");
        String password = resultSet.getString("u_pwd");
        int isAdmin = resultSet.getInt("checkadmin");

        return new User(id, name, email, password,isAdmin);
    }


    public int getUserIdByEmail(String email) throws SQLException {
        int userId = 0;
        String query = "SELECT id FROM users WHERE u_email = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, email);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    userId = resultSet.getInt("id");
                }
            }
        }
        return userId;
    }


    public int getUserCount() throws SQLException {
        try (PreparedStatement preparedStatement = connection.prepareStatement(COUNT_USERS);
             ResultSet resultSet = preparedStatement.executeQuery()) {
            if (resultSet.next()) {
                return resultSet.getInt(1);
            }
            return 0;
        }
    }

}