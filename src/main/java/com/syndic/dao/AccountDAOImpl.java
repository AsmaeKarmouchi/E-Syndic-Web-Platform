// AccountDAOImpl.java
package com.syndic.dao;

import com.syndic.beans.Account;
import com.syndic.beans.Payment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AccountDAOImpl implements AccountDAO {
    private final Connection connection;

    public AccountDAOImpl(Connection connection) {
        this.connection = connection;
    }

    @Override
    public void createAccount(Account account) throws SQLException {
        String sql = "INSERT INTO accounts (account_number, account_type, account_balance, account_created_at, account_syndic_id) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, account.getAccountNumber());
            statement.setString(2, account.getAccountType());
            statement.setBigDecimal(3, account.getAccountBalance());
            statement.setDate(4, new java.sql.Date(account.getAccountCreatedAt().getTime()));
            statement.setInt(5, account.getAccountSyndicId());
            statement.executeUpdate();
        }
    }
    @Override
    public int getLastAccountNumber() throws SQLException {
        String sql = "SELECT MAX(account_number) AS last_account_number FROM accounts";
        try (PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {
            if (resultSet.next()) {
                return resultSet.getInt("last_account_number");
            } else {
                return 0; // If no accounts exist, start with 0
            }
        }
    }

    public List<Account> getAllAccounts() throws SQLException {
        String sql = "SELECT * FROM accounts";
        List<Account> accounts = new ArrayList<>();
        try (PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                Account account = new Account();
                account.setAccountId(resultSet.getInt("account_id"));
                account.setAccountNumber(resultSet.getInt("account_number"));
                account.setAccountType(resultSet.getString("account_type"));
                account.setAccountBalance(resultSet.getBigDecimal("account_balance"));
                account.setAccountCreatedAt(resultSet.getDate("account_created_at"));
                account.setAccountSyndicId(resultSet.getInt("account_syndic_id"));
                accounts.add(account);
            }
        }
        return accounts;
    }

}
