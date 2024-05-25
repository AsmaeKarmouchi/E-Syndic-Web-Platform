package com.syndic.dao;

import static org.junit.jupiter.api.Assertions.*;
import java.sql.Connection;
import java.sql.DriverManager;

import java.sql.Statement;
import java.sql.SQLException;
import java.util.List;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import com.syndic.beans.Charge;


public class ChargeDAOImplTest {

    private Connection connection;
    private ChargeDAOImpl chargeDAO;

    @BeforeEach
    void setUp() throws SQLException {
        // Créer une connexion à la base de données H2 en mémoire
        connection = DriverManager.getConnection("jdbc:h2:mem:testdb;DB_CLOSE_DELAY=-1");
        chargeDAO = new ChargeDAOImpl(connection);


        try (Statement statement = connection.createStatement()) {
            statement.execute("CREATE TABLE charges (" +
                    "charges_id INT AUTO_INCREMENT PRIMARY KEY," +
                    "charge_code VARCHAR(255)," +
                    "charge_name VARCHAR(255)," +
                    "charge_description VARCHAR(255)," +
                    "charge_amount DOUBLE," +
                    "charge_frequency VARCHAR(255)," +
                    "charge_category VARCHAR(255)," +
                    "charge_due_month VARCHAR(255)" +
                    ")");


            statement.execute("INSERT INTO charges (charge_code, charge_name, charge_description, charge_amount, charge_frequency, charge_category, charge_due_month) " +
                    "VALUES ('C001', 'Charge1', 'Description1', 100.0, 'Monthly', 'Category1', 'January')");
            statement.execute("INSERT INTO charges (charge_code, charge_name, charge_description, charge_amount, charge_frequency, charge_category, charge_due_month) " +
                    "VALUES ('C002', 'Charge2', 'Description2', 200.0, 'Yearly', 'Category2', 'February')");
        }
    }

    @AfterEach
    void tearDown() throws SQLException {

        try (Statement statement = connection.createStatement()) {
            statement.execute("DROP TABLE charges");
        }


        connection.close();
    }

    @Test
    void testGetCharges() throws SQLException {

        List<Charge> charges = chargeDAO.getCharges();


        assertNotNull(charges);
        assertEquals(2, charges.size());

        Charge charge1 = charges.get(0);
        assertEquals("C001", charge1.getChargeCode());
        assertEquals("Charge1", charge1.getChargeName());
        assertEquals("Description1", charge1.getChargeDescription());
        assertEquals(100.0, charge1.getChargeAmount());
        assertEquals("Monthly", charge1.getChargeFrequency());
        assertEquals("Category1", charge1.getChargeCategory());
        assertEquals("January", charge1.getChargeDueMonth());

        Charge charge2 = charges.get(1);
        assertEquals("C002", charge2.getChargeCode());
        assertEquals("Charge2", charge2.getChargeName());
        assertEquals("Description2", charge2.getChargeDescription());
        assertEquals(200.0, charge2.getChargeAmount());
        assertEquals("Yearly", charge2.getChargeFrequency());
        assertEquals("Category2", charge2.getChargeCategory());
        assertEquals("February", charge2.getChargeDueMonth());
    }
}
