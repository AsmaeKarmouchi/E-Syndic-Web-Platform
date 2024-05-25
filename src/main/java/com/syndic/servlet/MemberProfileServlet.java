package com.syndic.servlet;

import com.syndic.beans.Member;
import com.syndic.beans.User;
import com.syndic.connection.Syndic_con;
import com.syndic.dao.MemberProfileDAO;
import com.syndic.dao.MemberProfileDAOImpl;

import jakarta.servlet.RequestDispatcher;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;



public class  MemberProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private MemberProfileDAO memberDAO;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        RequestDispatcher dispatcher = request.getRequestDispatcher("memberprofile.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String firstname = request.getParameter("firstname");
        String lastname = request.getParameter("lastname");
        String codepostal = request.getParameter("codepostal");
        String phonenumber = request.getParameter("phonenumber");
        String fulladdress = request.getParameter("fulladdress");
        String mail = request.getParameter("mail");

        String propertyCodeStr = request.getParameter("property_code");
        String propertyAddress = request.getParameter("property_address");
        String propertyType = request.getParameter("property_type");
        String propertySizeStr = request.getParameter("property_size");
        String coOwnershipFeeStr = request.getParameter("co_ownership_fee");

        int propertyCode = (propertyCodeStr != null && !propertyCodeStr.isEmpty()) ? Integer.parseInt(propertyCodeStr) : 0;
        int propertySize = (propertySizeStr != null && !propertySizeStr.isEmpty()) ? Integer.parseInt(propertySizeStr) : 0;
        int coOwnershipFee = (coOwnershipFeeStr != null && !coOwnershipFeeStr.isEmpty()) ? Integer.parseInt(coOwnershipFeeStr) : 0;



        try {
            Connection connection = Syndic_con.getConnection();
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            int userId = user.getIdUser();

            memberDAO = new MemberProfileDAOImpl(connection);
            Member member = memberDAO.getMemberByUserId(userId);

            member.setFirstName(firstname);
            member.setLastName(lastname);
            member.setCodepostal(codepostal);
            member.setPhoneNumber(phonenumber);
            member.setFulladdress(fulladdress);
            member.setMail(mail);
            member.setUserId(userId);

            member.setPropertyCode(propertyCode);
            member.setPropertyAddress(propertyAddress);
            member.setPropertyType(propertyType);
            member.setPropertySize(propertySize);
            member.setCoOwnershipFee(coOwnershipFee);

            memberDAO.updateMember(member);
            session.setAttribute("member", member);
            RequestDispatcher dispatcher = request.getRequestDispatcher("memberprofile.jsp");
            dispatcher.forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println(e);
            RequestDispatcher dispatcher = request.getRequestDispatcher("memberprofile.jsp");
            dispatcher.forward(request, response);

        }


    }
}
