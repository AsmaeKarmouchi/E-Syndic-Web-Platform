package com.syndic.dao;
import com.syndic.beans.Supplier;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

public class SupplierDAOImplTest {

    private Connection connection;
    private SupplierDAO supplierDAO;

    @BeforeEach
    public void setUp() throws SQLException {
        connection = DriverManager.getConnection("jdbc:h2:mem:testdb", "sa", "");
        supplierDAO = new SupplierDAOImpl(connection);
        createTables();
    }

    @AfterEach
    public void tearDown() throws SQLException {
        connection.close();
    }

    private void createTables() throws SQLException {
        try (Statement stmt = connection.createStatement()) {
            stmt.execute("CREATE TABLE Suppliers (" +
                    "supplier_id INT AUTO_INCREMENT PRIMARY KEY," +
                    "supplier_name VARCHAR(255)," +
                    "supplier_email VARCHAR(255)," +
                    "supplier_phone VARCHAR(255)," +
                    "supplier_type VARCHAR(255)," +
                    "supplier_active BOOLEAN," +
                    "supplier_rating VARCHAR(255)," +
                    "supplier_s_id INT UNIQUE)");
        }
    }

    @Test
    public void testInsertSupplier() throws SQLException {
        Supplier supplier = new Supplier();
        supplier.setSupplier_name("Supplier1");
        supplier.setSupplier_email("supplier1@example.com");
        supplier.setSupplier_phone("1234567890");
        supplier.setSupplier_type("Type1");
        supplier.setSupplier_active(true);
        supplier.setSupplier_rating("A");
        supplier.setSupplier_s_id(1);

        boolean result = supplierDAO.insertSupplier(supplier);
        assertTrue(result);

        List<Supplier> suppliers = supplierDAO.getAllSuppliers();
        assertEquals(1, suppliers.size());

        Supplier retrievedSupplier = suppliers.get(0);
        assertEquals("Supplier1", retrievedSupplier.getSupplier_name());
        assertEquals("supplier1@example.com", retrievedSupplier.getSupplier_email());
        assertEquals("1234567890", retrievedSupplier.getSupplier_phone());
        assertEquals("Type1", retrievedSupplier.getSupplier_type());
        assertTrue(retrievedSupplier.isSupplier_active());
        assertEquals("A", retrievedSupplier.getSupplier_rating());
        assertEquals(1, retrievedSupplier.getSupplier_s_id());
    }

    @Test
    public void testUpdateSupplier() throws SQLException {
        Supplier supplier = new Supplier();
        supplier.setSupplier_name("Supplier1");
        supplier.setSupplier_email("supplier1@example.com");
        supplier.setSupplier_phone("1234567890");
        supplier.setSupplier_type("Type1");
        supplier.setSupplier_active(true);
        supplier.setSupplier_rating("A");
        supplier.setSupplier_s_id(1);

        supplierDAO.insertSupplier(supplier);

        supplier.setSupplier_name("Updated Supplier1");
        supplier.setSupplier_email("updated_supplier1@example.com");
        supplier.setSupplier_phone("0987654321");
        supplier.setSupplier_type("Type2");
        supplier.setSupplier_active(false);
        supplier.setSupplier_rating("B");

        boolean result = supplierDAO.updateSupplier(supplier);
        assertTrue(result);

        List<Supplier> suppliers = supplierDAO.getAllSuppliers();
        assertEquals(1, suppliers.size());

        Supplier updatedSupplier = suppliers.get(0);
        assertEquals("Updated Supplier1", updatedSupplier.getSupplier_name());
        assertEquals("updated_supplier1@example.com", updatedSupplier.getSupplier_email());
        assertEquals("0987654321", updatedSupplier.getSupplier_phone());
        assertEquals("Type2", updatedSupplier.getSupplier_type());
        assertFalse(updatedSupplier.isSupplier_active());
        assertEquals("B", updatedSupplier.getSupplier_rating());
    }

    @Test
    public void testDeleteSupplier() throws SQLException {
        Supplier supplier = new Supplier();
        supplier.setSupplier_name("Supplier1");
        supplier.setSupplier_email("supplier1@example.com");
        supplier.setSupplier_phone("1234567890");
        supplier.setSupplier_type("Type1");
        supplier.setSupplier_active(true);
        supplier.setSupplier_rating("A");
        supplier.setSupplier_s_id(1);

        supplierDAO.insertSupplier(supplier);

        boolean result = supplierDAO.deleteSupplier(1);
        assertTrue(result);

        List<Supplier> suppliers = supplierDAO.getAllSuppliers();
        assertEquals(0, suppliers.size());
    }

    @Test
    public void testGetAllSuppliers() throws SQLException {
        Supplier supplier1 = new Supplier();
        supplier1.setSupplier_name("Supplier1");
        supplier1.setSupplier_email("supplier1@example.com");
        supplier1.setSupplier_phone("1234567890");
        supplier1.setSupplier_type("Type1");
        supplier1.setSupplier_active(true);
        supplier1.setSupplier_rating("A");
        supplier1.setSupplier_s_id(1);

        Supplier supplier2 = new Supplier();
        supplier2.setSupplier_name("Supplier2");
        supplier2.setSupplier_email("supplier2@example.com");
        supplier2.setSupplier_phone("0987654321");
        supplier2.setSupplier_type("Type2");
        supplier2.setSupplier_active(false);
        supplier2.setSupplier_rating("B");
        supplier2.setSupplier_s_id(2);

        supplierDAO.insertSupplier(supplier1);
        supplierDAO.insertSupplier(supplier2);

        List<Supplier> suppliers = supplierDAO.getAllSuppliers();
        assertEquals(2, suppliers.size());

        Supplier retrievedSupplier1 = suppliers.get(0);
        assertEquals("Supplier1", retrievedSupplier1.getSupplier_name());
        assertEquals("supplier1@example.com", retrievedSupplier1.getSupplier_email());
        assertEquals("1234567890", retrievedSupplier1.getSupplier_phone());
        assertEquals("Type1", retrievedSupplier1.getSupplier_type());
        assertTrue(retrievedSupplier1.isSupplier_active());
        assertEquals("A", retrievedSupplier1.getSupplier_rating());
        assertEquals(1, retrievedSupplier1.getSupplier_s_id());

        Supplier retrievedSupplier2 = suppliers.get(1);
        assertEquals("Supplier2", retrievedSupplier2.getSupplier_name());
        assertEquals("supplier2@example.com", retrievedSupplier2.getSupplier_email());
        assertEquals("0987654321", retrievedSupplier2.getSupplier_phone());
        assertEquals("Type2", retrievedSupplier2.getSupplier_type());
        assertFalse(retrievedSupplier2.isSupplier_active());
        assertEquals("B", retrievedSupplier2.getSupplier_rating());
        assertEquals(2, retrievedSupplier2.getSupplier_s_id());
    }

    @Test
    public void testGetSupplierCount() throws SQLException {
        Supplier supplier1 = new Supplier();
        supplier1.setSupplier_name("Supplier1");
        supplier1.setSupplier_email("supplier1@example.com");
        supplier1.setSupplier_phone("1234567890");
        supplier1.setSupplier_type("Type1");
        supplier1.setSupplier_active(true);
        supplier1.setSupplier_rating("A");
        supplier1.setSupplier_s_id(1);

        Supplier supplier2 = new Supplier();
        supplier2.setSupplier_name("Supplier2");
        supplier2.setSupplier_email("supplier2@example.com");
        supplier2.setSupplier_phone("0987654321");
        supplier2.setSupplier_type("Type2");
        supplier2.setSupplier_active(false);
        supplier2.setSupplier_rating("B");
        supplier2.setSupplier_s_id(2);

        supplierDAO.insertSupplier(supplier1);
        supplierDAO.insertSupplier(supplier2);

        int supplierCount = supplierDAO.getSupplierCount();
        assertEquals(2, supplierCount);
    }
}
