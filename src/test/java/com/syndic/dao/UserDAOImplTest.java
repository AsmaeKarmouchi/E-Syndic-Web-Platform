package com.syndic.dao;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import com.syndic.beans.User;
import com.syndic.connection.Syndic_con;
import java.sql.Connection;
import java.sql.SQLException;

import com.syndic.dao.UserDAO;
import com.syndic.dao.UserDAOImpl;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.mindrot.jbcrypt.BCrypt;

public class UserDAOImplTest {

    private static UserDAO userDao;
    private Connection connection;

    @Before
    public void setUp() throws SQLException {
        connection = Syndic_con.getConnection(); // Établir une connexion avant chaque test
        userDao = new UserDAOImpl(connection);
    }

    @After
    public void tearDown() throws SQLException {
        connection.close(); // Fermer la connexion après chaque test
    }

    @Test
    public void testLogin() throws SQLException {
        // Arrange
        String plainPassword = "resident1";
        String hashedPassword = BCrypt.hashpw(plainPassword, BCrypt.gensalt());
        User user = new User("resident1", "resident1@gmail.com", hashedPassword, 0);
        userDao.createUser(user);

        // Act
        User loggedInUser = userDao.login("resident1@gmail.com", plainPassword);

        // Assert
        assertNotNull("L'utilisateur connecté ne doit pas être nul", loggedInUser);
        assertEquals("Le nom d'utilisateur doit correspondre", "resident1", loggedInUser.getName());
        assertEquals("L'email doit correspondre", "resident1@gmail.com", loggedInUser.getEmail());
        //assertEquals("Le mot de passe doit correspondre", hashedPassword, loggedInUser.getPassword());
        assertEquals("L'indicateur d'administrateur doit être 0", 0, loggedInUser.getAdmin());
    }
}
