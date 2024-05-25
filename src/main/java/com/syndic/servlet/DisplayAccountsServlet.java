// DisplayAccountsServlet.java
package com.syndic.servlet;

import com.syndic.beans.Account;
import com.syndic.dao.AccountDAO;
import com.syndic.dao.AccountDAOImpl;
import com.syndic.connection.Syndic_con;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

public class DisplayAccountsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("displayaccounts.jsp");
        dispatcher.forward(request, response);

    }
}
