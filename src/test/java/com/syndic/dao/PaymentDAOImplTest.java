package com.syndic.dao;
import com.syndic.beans.Payment;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

public class PaymentDAOImplTest {

    private Connection connection;
    private PaymentDAO paymentDAO;

    @BeforeEach
    public void setUp() throws SQLException {
        connection = DriverManager.getConnection("jdbc:h2:mem:testdb", "sa", "");
        paymentDAO = new PaymentDAOImpl(connection);
        createTables();
    }

    @AfterEach
    public void tearDown() throws SQLException {
        connection.close();
    }

    private void createTables() throws SQLException {
        try (Statement stmt = connection.createStatement()) {
            stmt.execute("CREATE TABLE Payments (" +
                    "payment_code INT PRIMARY KEY," +
                    "payment_date VARCHAR(255)," +
                    "payment_amount DOUBLE," +
                    "payment_method VARCHAR(255)," +
                    "payment_type VARCHAR(255)," +
                    "payment_account_id INT," +
                    "payment_member_id INT," +
                    "payment_status VARCHAR(255))");
        }
    }

    @Test
    public void testInsertPayment() throws SQLException {
        Payment payment = new Payment();
        payment.setCode(1);
        payment.setDate("2024-05-24");
        payment.setAmount(100.0);
        payment.setMethod("Credit Card");
        payment.setType("Monthly");
        payment.setAccount_id(1);
        payment.setMember_id(1);
        payment.setStatus("Completed");

        boolean result = paymentDAO.insertPayment(payment);
        assertTrue(result);

        List<Payment> payments = paymentDAO.getAllPayments();
        assertEquals(1, payments.size());

        Payment retrievedPayment = payments.get(0);
        assertEquals(1, retrievedPayment.getCode());
        assertEquals("2024-05-24", retrievedPayment.getDate());
        assertEquals(100.0, retrievedPayment.getAmount());
        assertEquals("Credit Card", retrievedPayment.getMethod());
        assertEquals("Monthly", retrievedPayment.getType());
        assertEquals(1, retrievedPayment.getAccount_id());
        assertEquals(1, retrievedPayment.getMember_id());
        assertEquals("Completed", retrievedPayment.getStatus());
    }

    @Test
    public void testUpdatePayment() throws SQLException {
        Payment payment = new Payment();
        payment.setCode(1);
        payment.setDate("2024-05-24");
        payment.setAmount(100.0);
        payment.setMethod("Credit Card");
        payment.setType("Monthly");
        payment.setAccount_id(1);
        payment.setMember_id(1);
        payment.setStatus("Completed");

        paymentDAO.insertPayment(payment);

        payment.setDate("2024-06-24");
        payment.setAmount(150.0);
        payment.setMethod("Debit Card");
        payment.setStatus("Pending");

        boolean result = paymentDAO.updatePayment(payment);
        assertTrue(result);

        List<Payment> payments = paymentDAO.getAllPayments();
        assertEquals(1, payments.size());

        Payment updatedPayment = payments.get(0);
        assertEquals("2024-06-24", updatedPayment.getDate());
        assertEquals(150.0, updatedPayment.getAmount());
        assertEquals("Debit Card", updatedPayment.getMethod());
        assertEquals("Pending", updatedPayment.getStatus());
    }

    @Test
    public void testDeletePayment() throws SQLException {
        Payment payment = new Payment();
        payment.setCode(1);
        payment.setDate("2024-05-24");
        payment.setAmount(100.0);
        payment.setMethod("Credit Card");
        payment.setType("Monthly");
        payment.setAccount_id(1);
        payment.setMember_id(1);
        payment.setStatus("Completed");

        paymentDAO.insertPayment(payment);

        boolean result = paymentDAO.deletePayment(1);
        assertTrue(result);

        List<Payment> payments = paymentDAO.getAllPayments();
        assertEquals(0, payments.size());
    }

    @Test
    public void testGetAllPayments() throws SQLException {
        Payment payment1 = new Payment();
        payment1.setCode(1);
        payment1.setDate("2024-05-24");
        payment1.setAmount(100.0);
        payment1.setMethod("Credit Card");
        payment1.setType("Monthly");
        payment1.setAccount_id(1);
        payment1.setMember_id(1);
        payment1.setStatus("Completed");

        Payment payment2 = new Payment();
        payment2.setCode(2);
        payment2.setDate("2024-06-24");
        payment2.setAmount(150.0);
        payment2.setMethod("Debit Card");
        payment2.setType("Annual");
        payment2.setAccount_id(2);
        payment2.setMember_id(2);
        payment2.setStatus("Pending");

        paymentDAO.insertPayment(payment1);
        paymentDAO.insertPayment(payment2);

        List<Payment> payments = paymentDAO.getAllPayments();
        assertEquals(2, payments.size());

        Payment retrievedPayment1 = payments.get(0);
        assertEquals(1, retrievedPayment1.getCode());
        assertEquals("2024-05-24", retrievedPayment1.getDate());
        assertEquals(100.0, retrievedPayment1.getAmount());
        assertEquals("Credit Card", retrievedPayment1.getMethod());
        assertEquals("Monthly", retrievedPayment1.getType());
        assertEquals(1, retrievedPayment1.getAccount_id());
        assertEquals(1, retrievedPayment1.getMember_id());
        assertEquals("Completed", retrievedPayment1.getStatus());

        Payment retrievedPayment2 = payments.get(1);
        assertEquals(2, retrievedPayment2.getCode());
        assertEquals("2024-06-24", retrievedPayment2.getDate());
        assertEquals(150.0, retrievedPayment2.getAmount());
        assertEquals("Debit Card", retrievedPayment2.getMethod());
        assertEquals("Annual", retrievedPayment2.getType());
        assertEquals(2, retrievedPayment2.getAccount_id());
        assertEquals(2, retrievedPayment2.getMember_id());
        assertEquals("Pending", retrievedPayment2.getStatus());
    }

    @Test
    public void testGetPaymentSum() throws SQLException {
        Payment payment1 = new Payment();
        payment1.setCode(1);
        payment1.setDate("2024-05-24");
        payment1.setAmount(100.0);
        payment1.setMethod("Credit Card");
        payment1.setType("Monthly");
        payment1.setAccount_id(1);
        payment1.setMember_id(1);
        payment1.setStatus("Completed");

        Payment payment2 = new Payment();
        payment2.setCode(2);
        payment2.setDate("2024-06-24");
        payment2.setAmount(150.0);
        payment2.setMethod("Debit Card");
        payment2.setType("Annual");
        payment2.setAccount_id(2);
        payment2.setMember_id(2);
        payment2.setStatus("Pending");

        paymentDAO.insertPayment(payment1);
        paymentDAO.insertPayment(payment2);

        float totalAmount = paymentDAO.getPaymentSum();
        assertEquals(250.0, totalAmount);
    }
}
