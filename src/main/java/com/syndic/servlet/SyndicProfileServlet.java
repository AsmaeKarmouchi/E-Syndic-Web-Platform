package com.syndic.servlet;

import com.syndic.beans.Syndic;
import com.syndic.beans.User;
import com.syndic.connection.Syndic_con;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.syndic.dao.SyndicProfileDAO;
import com.syndic.dao.SyndicProfileDAOImpl;
import jakarta.servlet.RequestDispatcher;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


public class SyndicProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private SyndicProfileDAO syndicDAO;
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("syndicprofile.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String firstname = request.getParameter("firstname");
        String lastname = request.getParameter("lastname");
        String codepostal = request.getParameter("codepostal");
        String phonenumber = request.getParameter("phonenumber");
        String fulladdress = request.getParameter("fulladdress");
        String mail = request.getParameter("mail");

        // Nouvelles informations
        String residenceName = request.getParameter("residenceName");
        String residenceAddress = request.getParameter("residenceAddress");
        String residenceType = request.getParameter("residenceType");
        int residenceSize = Integer.parseInt(request.getParameter("residenceSize"));
        int apartmentCount = Integer.parseInt(request.getParameter("apartmentCount"));
        int villaCount = Integer.parseInt(request.getParameter("villaCount"));
        int gardenCount = Integer.parseInt(request.getParameter("gardenCount"));
        int poolCount = Integer.parseInt(request.getParameter("poolCount"));
        int parkingCount = Integer.parseInt(request.getParameter("parkingCount"));
        int elevatorsCount = Integer.parseInt(request.getParameter("elevatorsCount"));
        boolean securitySystem = Boolean.parseBoolean(request.getParameter("securitySystem"));


        try {
            Connection connection = Syndic_con.getConnection();
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            int userId = user.getIdUser();

            syndicDAO = new SyndicProfileDAOImpl(connection);
            Syndic syndic = syndicDAO.getSyndicByUserId(userId);

            syndic.setFirstName(firstname);
            syndic.setLastName(lastname);
            syndic.setCodepostal(codepostal);
            syndic.setPhoneNumber(phonenumber);
            syndic.setFulladdress(fulladdress);
            syndic.setMail(mail);
            syndic.setUserId(userId);

            // Mettre à jour les nouvelles informations
            syndic.setResidenceName(residenceName);
            syndic.setResidenceAddress(residenceAddress);
            syndic.setResidenceType(residenceType);
            syndic.setResidenceSize(residenceSize);
            syndic.setApartmentCount(apartmentCount);
            syndic.setVillaCount(villaCount);
            syndic.setGardenCount(gardenCount);
            syndic.setPoolCount(poolCount);
            syndic.setParkingCount(parkingCount);
            syndic.setElevatorsCount(elevatorsCount);
            syndic.setSecuritySystem(securitySystem);

            syndicDAO.updateSyndic2(syndic);
            session.setAttribute("syndic", syndic);
            System.out.println("succès " + firstname);
            RequestDispatcher dispatcher = request.getRequestDispatcher("syndicprofile.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            System.out.println("echec " + firstname);
            e.printStackTrace();
            System.out.println(e);
            RequestDispatcher dispatcher = request.getRequestDispatcher("syndicprofile.jsp");
            dispatcher.forward(request, response);
        }

    }
}
