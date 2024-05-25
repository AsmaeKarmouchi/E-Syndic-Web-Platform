package com.syndic.dao;


import com.syndic.beans.User;

import java.sql.SQLException;

public interface UserDAO {

    User getUserById(int userId);
    User getUserByEmail(String email);
    User login(String email, String password);
    void createUser(User user);
    void createSyndic(User user);
    void updateUser(User user);
    void deleteUser(int userId);
    int getUserIdByEmail(String email) throws SQLException;
    int getUserCount() throws SQLException;
}