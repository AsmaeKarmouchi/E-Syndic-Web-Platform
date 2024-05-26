package com.syndic.servlet;

import com.syndic.beans.Meeting;
import com.syndic.beans.Syndic;
import com.syndic.connection.Syndic_con;
import com.syndic.dao.MeetingDAO;
import com.syndic.dao.MeetingDAOImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;


public class MeetingMServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public MeetingMServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("meetingMember.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

}
