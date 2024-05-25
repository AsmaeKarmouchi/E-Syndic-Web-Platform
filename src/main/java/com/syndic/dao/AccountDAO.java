// AccountDAO.java
package com.syndic.dao;

import com.syndic.beans.Account;
import com.syndic.beans.Payment;

import java.sql.SQLException;
import java.util.List;

public interface AccountDAO {
    void createAccount(Account account) throws SQLException;

    int getLastAccountNumber() throws SQLException;
    List<Account> getAllAccounts() throws SQLException ;


}
