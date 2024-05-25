package com.syndic.servlet;

import com.syndic.beans.*;
import com.syndic.dao.*;
import com.syndic.connection.Syndic_con;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.RequestDispatcher;
import com.syndic.dao.MemberProfileDAO;
import com.syndic.dao.MemberProfileDAOImpl;
import org.bouncycastle.crypto.util.Pack;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeUnit;


public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;
    private MemberProfileDAO memberDAO;
    private SyndicProfileDAO syndicDAO;

    private MeetingDAO meetingDAO;
    private IncidentDAO incidentDAO;
    private NewsDAO newsDAO;

    private ChargeDAO chargeDAO;

    private PaymentDAO paymentDAO;
    private AccountDAO accountsDAO;


    public LoginServlet() {
        super();
        // Instanciation de votre DAO
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Fermer la session si elle existe
        HttpSession session = request.getSession(false); // Ne pas créer de nouvelle session si elle n'existe pas
        if (session != null) {
            session.invalidate(); // Fermer la session existante
        }

        // Rediriger vers la page login.jsp
        RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String residence = request.getParameter("residence");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        Connection connection = null;

        do {
            try {
                connection = Syndic_con.getConnection();
                if (connection != null) {
                    userDAO = new UserDAOImpl(connection);
                    User user = userDAO.login(email, password);

                    if (user != null) {
                        HttpSession session = request.getSession();
                        session.setAttribute("user", user);


                        if (user.getAdmin() == 1  ) {
                            response.sendRedirect("admin.jsp");

                            List<Payment> payments;
                            paymentDAO = new PaymentDAOImpl(connection);
                            payments = paymentDAO.getAllPayments();
                            session.setAttribute("payments", payments);

                            List<Syndic> List_syndics;
                            syndicDAO = new SyndicProfileDAOImpl(connection);
                            List_syndics = syndicDAO.getSyndic();
                            session.setAttribute("List_syndics", List_syndics);

                            List<Member> list_members;
                            memberDAO = new MemberProfileDAOImpl(connection);
                            list_members = memberDAO.getMember();
                            session.setAttribute("list_members", list_members);

                            List<Account> accounts;
                            accountsDAO = new AccountDAOImpl (connection);
                            accounts = accountsDAO.getAllAccounts();
                            session.setAttribute("accounts", accounts);

                            return;
                        } else if (user.getAdmin() == 2){
                            response.sendRedirect("dashboardSyndic.jsp");
                            int userId = user.getIdUser();
                            syndicDAO = new SyndicProfileDAOImpl(connection);
                            Syndic syndic = syndicDAO.getSyndicByUserId(userId);
                            session.setAttribute("syndic", syndic);

                            Syndic syndic2 = syndicDAO.getSyndicById(syndic.getId());
                            session.setAttribute("syndic2", syndic2);

                            int syndicId = syndic.getId();
                            List<Meeting> list_Meetings = new ArrayList<>();
                            meetingDAO = new MeetingDAOImpl(connection);
                            list_Meetings = meetingDAO.getMeetingBySyndicId(syndicId);
                            session.setAttribute("list_Meetings", list_Meetings);

                            List<Incident> list_Incidents = new ArrayList<>();
                            incidentDAO = new IncidentDAOImpl(connection);
                            list_Incidents = incidentDAO.getIncidentBySyndicId(syndicId);
                            session.setAttribute("list_Incidents", list_Incidents);

                            List<News> list_News = new ArrayList<>();
                            newsDAO = new NewsDAOImpl(connection);
                            list_News = newsDAO.getNewsBySyndicId(syndicId);
                            session.setAttribute("list_News", list_News);

                            List<Charge> list_Charges = new ArrayList<>();
                            chargeDAO = new ChargeDAOImpl(connection);
                            list_Charges = chargeDAO.getCharges();
                            session.setAttribute("list_Charges", list_Charges);


                            return;
                        }  else  {

                            response.sendRedirect("home.jsp");
                            int userId = user.getIdUser();
                            memberDAO = new MemberProfileDAOImpl(connection);
                            Member member = memberDAO.getMemberByUserId(userId);
                            session.setAttribute("member", member);

                            int syndicId = member.getMemberSId();
                            List<Incident> list_Incidents = new ArrayList<>();
                            incidentDAO = new IncidentDAOImpl(connection);
                            list_Incidents = incidentDAO.getIncidentBySyndicId(syndicId);
                            session.setAttribute("list_Incidents", list_Incidents);

                            syndicDAO = new SyndicProfileDAOImpl(connection);
                            Syndic syndic = syndicDAO.getSyndicById(syndicId);
                            session.setAttribute("syndic", syndic);

                            return;
                        }
                    } else {
                        response.sendRedirect("login.jsp?error=1");
                        return;
                    }
                }
            } catch (IOException e) {
                e.printStackTrace();
                return;
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }

        } while (true); // Continue indefinitely until connection is obtained


    }
}