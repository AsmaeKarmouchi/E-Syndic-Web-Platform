package com.syndic.dao;



import com.syndic.beans.Account;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class AccountDAOImplTest {

    private Connection connection;
    private AccountDAO accountDAO;
    private static final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

    @BeforeEach
    public void setUp() throws SQLException {
        connection = DriverManager.getConnection("jdbc:h2:mem:testdb", "sa", "");
        accountDAO = new AccountDAOImpl(connection);
        createTables();
    }

    @AfterEach
    public void tearDown() throws SQLException {
        connection.close();
    }

    private void createTables() throws SQLException {
        try (Statement stmt = connection.createStatement()) {
            stmt.execute("CREATE TABLE accounts (" +
                    "account_id INT AUTO_INCREMENT PRIMARY KEY," +
                    "account_number INT UNIQUE," +
                    "account_type VARCHAR(255)," +
                    "account_balance DECIMAL(19, 1)," +
                    "account_created_at DATE," +
                    "account_syndic_id INT)");
        }
    }

    @Test
    public void testCreateAccount() throws SQLException {
        Account account = new Account();
        account.setAccountNumber(12345);
        account.setAccountType("Checking");
        account.setAccountBalance(BigDecimal.valueOf(1000.0));
        account.setAccountCreatedAt(new Date());
        account.setAccountSyndicId(1);

        accountDAO.createAccount(account);

        List<Account> accounts = accountDAO.getAllAccounts();
        assertEquals(1, accounts.size());

        Account retrievedAccount = accounts.get(0);
        assertEquals(12345, retrievedAccount.getAccountNumber());
        assertEquals("Checking", retrievedAccount.getAccountType());
        assertEquals(BigDecimal.valueOf(1000.0), retrievedAccount.getAccountBalance());
        assertEquals(dateFormat.format(account.getAccountCreatedAt()), dateFormat.format(retrievedAccount.getAccountCreatedAt()));
        assertEquals(1, retrievedAccount.getAccountSyndicId());
    }

    @Test
    public void testGetLastAccountNumber() throws SQLException {
        Account account1 = new Account();
        account1.setAccountNumber(12345);
        account1.setAccountType("Checking");
        account1.setAccountBalance(BigDecimal.valueOf(1000.0));
        account1.setAccountCreatedAt(new Date());
        account1.setAccountSyndicId(1);

        Account account2 = new Account();
        account2.setAccountNumber(12346);
        account2.setAccountType("Savings");
        account2.setAccountBalance(BigDecimal.valueOf(2000.0));
        account2.setAccountCreatedAt(new Date());
        account2.setAccountSyndicId(1);

        accountDAO.createAccount(account1);
        accountDAO.createAccount(account2);

        int lastAccountNumber = accountDAO.getLastAccountNumber();
        assertEquals(12346, lastAccountNumber);
    }

    @Test
    public void testGetAllAccounts() throws SQLException {
        Account account1 = new Account();
        account1.setAccountNumber(12345);
        account1.setAccountType("Checking");
        account1.setAccountBalance(BigDecimal.valueOf(1000.0));
        account1.setAccountCreatedAt(new Date());
        account1.setAccountSyndicId(1);

        Account account2 = new Account();
        account2.setAccountNumber(12346);
        account2.setAccountType("Savings");
        account2.setAccountBalance(BigDecimal.valueOf(2000.0));
        account2.setAccountCreatedAt(new Date());
        account2.setAccountSyndicId(1);

        accountDAO.createAccount(account1);
        accountDAO.createAccount(account2);

        List<Account> accounts = accountDAO.getAllAccounts();
        assertEquals(2, accounts.size());

        Account retrievedAccount1 = accounts.get(0);
        assertEquals(12345, retrievedAccount1.getAccountNumber());
        assertEquals("Checking", retrievedAccount1.getAccountType());
        assertEquals(BigDecimal.valueOf(1000.0), retrievedAccount1.getAccountBalance());
        assertEquals(dateFormat.format(account1.getAccountCreatedAt()), dateFormat.format(retrievedAccount1.getAccountCreatedAt()));
        assertEquals(1, retrievedAccount1.getAccountSyndicId());

        Account retrievedAccount2 = accounts.get(1);
        assertEquals(12346, retrievedAccount2.getAccountNumber());
        assertEquals("Savings", retrievedAccount2.getAccountType());
        assertEquals(BigDecimal.valueOf(2000.0), retrievedAccount2.getAccountBalance());
        assertEquals(dateFormat.format(account2.getAccountCreatedAt()), dateFormat.format(retrievedAccount2.getAccountCreatedAt()));
        assertEquals(1, retrievedAccount2.getAccountSyndicId());
    }
}
