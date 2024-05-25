package com.syndic.dao;

import static org.junit.jupiter.api.Assertions.*;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;


import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import com.syndic.beans.Member;

class MemberProfileDAOImplTest {

    private Connection connection;
    private MemberProfileDAOImpl memberProfileDAO;

    @BeforeEach
    void setUp() throws Exception {

        connection = DriverManager.getConnection("jdbc:h2:mem:testdb;DB_CLOSE_DELAY=-1");
        memberProfileDAO = new MemberProfileDAOImpl(connection);


        try (Statement statement = connection.createStatement()) {
            statement.execute("CREATE TABLE members (" +
                    "m_id INT AUTO_INCREMENT PRIMARY KEY," +
                    "m_firstname VARCHAR(255)," +
                    "m_lastname VARCHAR(255)," +
                    "m_codepostal VARCHAR(255)," +
                    "m_phonenumber VARCHAR(255)," +
                    "m_fulladdress VARCHAR(255)," +
                    "m_mail VARCHAR(255)," +
                    "m_iduser INT," +
                    "member_s_id INT," +
                    "property_code INT," +
                    "property_address VARCHAR(255)," +
                    "property_type VARCHAR(255)," +
                    "property_size INT," +
                    "coOwnershipFee INT" +
                    ")");
        }
    }

    @AfterEach
    void tearDown() throws Exception {
        // Supprimer la table members
        try (Statement statement = connection.createStatement()) {
            statement.execute("DROP TABLE members");
        }

        // Fermer la connexion
        connection.close();
    }

    @Test
    void testAddMember() throws Exception {
        // Préparer les données de test
        Member member = new Member();
        member.setFirstName("John");
        member.setLastName("Doe");
        member.setCodepostal("12345");
        member.setPhoneNumber("123-456-7890");
        member.setFulladdress("123 Main St");
        member.setMail("john.doe@example.com");
        member.setUserId(1);
        member.setMemberSId(2);
        member.setPropertyCode(123);
        member.setPropertyAddress("456 Elm St");
        member.setPropertyType("House");
        member.setPropertySize(2000);
        member.setCoOwnershipFee(100);

        // Tester la méthode
        memberProfileDAO.addMember(member);

        // Vérifier que le membre a été ajouté
        try (Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery("SELECT * FROM members WHERE m_iduser = 1")) {
            assertTrue(resultSet.next());
            assertEquals("John", resultSet.getString("m_firstname"));
            assertEquals("Doe", resultSet.getString("m_lastname"));
            assertEquals("12345", resultSet.getString("m_codepostal"));
            assertEquals("123-456-7890", resultSet.getString("m_phonenumber"));
            assertEquals("123 Main St", resultSet.getString("m_fulladdress"));
            assertEquals("john.doe@example.com", resultSet.getString("m_mail"));
            assertEquals(123, resultSet.getInt("property_code"));
            assertEquals("456 Elm St", resultSet.getString("property_address"));
            assertEquals("House", resultSet.getString("property_type"));
            assertEquals(2000, resultSet.getInt("property_size"));
            assertEquals(100, resultSet.getInt("coOwnershipFee"));
        }
    }
}
